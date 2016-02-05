from requests import get, post

from config import Config
from tests.utils import retrieve_sms, delete_sms_messge


def test_sign_in_journey():
    base_url = Config.NOTIFY_ADMIN_URL
    index_resp = get(base_url)
    assert index_resp.status_code == 200
    assert 'GOV.UK Notify' in index_resp.text

    get_sign_resp = get(base_url + '/sign-in',
                        cookies={'notify_admin_session': index_resp.cookies['notify_admin_session']})
    # print('headers: {}'.format(get_reg_resp.headers)) it's possible to assert that headers are set properly here.

    assert 200 == get_sign_resp.status_code
    assert '<p>If you do not have an account, you can <a href="register">register for one now</a>.</p>' in get_sign_resp.text

    user_name = Config.FUNCTIONAL_TEST_EMAIL
    assert user_name is not None
    print('** username: {}'.format(user_name))
    print('** password: {}'.format(Config.FUNCTIONAL_TEST_PASSWORD))
    data = {'email_address': user_name,
            'password': Config.FUNCTIONAL_TEST_PASSWORD}
    post_sign_in_resp = post(base_url + '/sign-in', data=data,
                             cookies={'notify_admin_session': get_sign_resp.cookies['notify_admin_session']})
    assert post_sign_in_resp.status_code == 200
    assert "We've sent you a text message with a verification code." in post_sign_in_resp.text

    # Test will fail if there are 0 messages
    messages = retrieve_sms(user_name)
    print('*** no. of messages {}'.format(len(messages)))

    # try to use verify code from message (hopefully only one in the list
    for m in messages:
        print(m.body)
        post_two_factor = post(base_url + '/two-factor', data={'sms_code': m.body},
                               cookies={'notify_admin_session': post_sign_in_resp.cookies['notify_admin_session']})
        assert post_two_factor.status_code == 200
        assert 'Choose service' in post_two_factor.text
        delete_sms_messge(m.sid)
        # assert 'next page'

