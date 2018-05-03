Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeECUvr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:51:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeECUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:51:44 -0400
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the
 actions_logged sysctl
To: Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
 <2193990.pCRMhOm3SD@x2>
 <CAHC9VhS69VD9+L=oN-uLZqvo7BCg+HOvEuT4mnv8Wy7qo2MLMA@mail.gmail.com>
 <3241732.94y415NZZK@x2>
 <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>
From: Tyler Hicks <tyhicks@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tyhicks@canonical.com; prefer-encrypt=mutual; keydata=
 xsFNBE5flbYBEADRwKwAt+WQR0wtgBdld4U/6z0UMsjZ3KkB5OIcHDwVbWfFHRZDYY+U8oUj
 R66rps/vjtEy/LOVcvWyDRWdzHcVtedrxEXhhQ7ljR8ei2cOUcORImdQfOcnSAT1fCOOHJM7
 YQJDHWeyXxeWToZHYul49+1hPI9aLDbwTAHziH8kQuLKkj1RbEWSW7itq0Zw/TPGgoIKx+3T
 z6hwDtV7BxBTcf1CQf77dKwpHy0nPK8uZuRojSaUnvYSkqwSjrdkbL7iPNUKjsbO2zZSbY/p
 NUqHSHcEzEaeT0SH1bEg6aQbVZDKUnmKTslliGS0xx/twPpUfRG+hcQG+MTJy3yzb13mXCO/
 9BdpOVxhzcM/TRCsk7mgAJtujDvxmyvIDL5F5FNZM0FPDFLKU446eb2MSAiA5kmX4f1VIwyS
 GxAUGMkk10GaLptYrPvwVCW7h11/PpWt5J0dvQ3kaeYxmxFU+wDC/AIesczmGFBWFvMBPA6M
 qrMeQ/DPR+CqL0Bwvya3FJ2+HlY7p0U7T+dI4kIL748rgkFM0DP29rPYaVGcD/jcdJ8ko7hq
 wULbUQb08ggJkVS4sbOjt7HCG614FSljooEvLOOTeGsFjMh+XEZjYBxa4LRBtcih+Z7UwSUJ
 9CCanX/JgCVDZnoGhNYfD54g33beQ7ib5Ro8nFyurMyVe9M2TwARAQABzSFUeWxlciBIaWNr
 cyA8dHloaWNrc0B0eWhpY2tzLm5ldD7CwXoEEwEKACQCGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4AFAk5ft10CGQEACgkQ1pIAPaoCxwrsjQ//THR2VbefAMrU7J1yFnnp1OuLuiFgOwyy
 794E65/vodRKdvUkoCcT2F9EQC4RPXe62CE8VrGHvvOxFSGoCyoIBtvWHA9luUsznCprWu8H
 FHwV2upHmzt/lTPH52EU98KCdyzNXGVb+OfejG6QY3WCYFI0JmWr4CJNp5H0ofPtm+pLqkbM
 Wb0Olk71UDUvVasVFBb7/vJXQw9frZRxYJwx20CKO6qnmj67wbL55eX1BMd4eE3okTR6p5yh
 WsZPesYnu7cV0F/bKVO510WszJMydrj/lk4W9GoadpvOHq/Pu9kCIPVCorulnepjuDmeZ5Wa
 SUmFcBSvtBXo1N0IdlixdaUFbdOnfPNRTzWwxYNDmhyRehUJUhf4R166EqMLTYcv8TE7924d
 B5NaU0onB+ar1mnsqqZ4aAjEuf5ZEatVui7iiNx6SB0IP7hlR9jX5stjDjDi++5XjvmUB+ZX
 /g39cOuMedUUXFUU9a3eeswBtu8rYr6PSXh3mmqSVdCAI1fspFDGK3Q720LVorIiONdtaZQl
 X2LjoCqIFp8p0ExOWXpNTZ+YNORGBpU/9rcJtW4MpZtUHochGjqwfVsBrMLkMuTJUcIP8JDE
 O7bqjGzOBEuFtDLZ+InIZpIc9atZ9gXx5EYP9SlLImhGCjVhPfXifA7hVq3/tnRhdbbSYt7I
 UvDOwU0ETl+VtgEQAPp97vRK5aMtDuiDUcvlGpU2h0/kWFuxXBWPa8q2yVi+yyCtr51v3ic6
 sllksZdIg0uIP7Qk+mIqCEs5IR1BUWCwTyOjvQXtQhIoX8YvFZUGr7tk7vo/N9N1UR4nTXVE
 owRdFzV8ct7W/BFaEdqspYn5rYhEI6pKsyYxRS5AzvIE+sL+EBwGDacfMvYXaAmd5w2Fk2bo
 woRtHgouZyyCgk0Enitndt1sdLce3ZwUE3r6+Yfj+Pv3ZA9uw3ZH/G/ZRk++71haKvU/3BjT
 EHPgkBIHz+ZVmqox102U1I8xVlV11faO8dZN+blugFEWyxg3Z/5hRzaA7QPUaXpLrK/UQvcM
 lhXtTBZmQqKELohm1sGirtcxf81wPappXe9TevXCu9jiBwUNnFdHva10rWqdEt9utFvyMTYH
 PwsW7CDwibXcDGoPfE9zjToIOXQhIMvvdEFyxhdTgivHmGJ7iIU7m58a/WdwMAcYB1F4yVBb
 mTJYe0lI/G5xrLRXDg1EtEiSibU8uux32nRJzp88FUUi9U7FZgv/Bu/07d4PbeF3bYd00CCg
 0nKvyCF15Vs9WMLo0B2MhgG6CAeuMpJgc3V0q0iHDUbZW/YNzV07tBxSqeUpReJ5NGv0uzYH
 k1g4wR2KpkRtfTRad5CgGbgjvuhvmfjEk81sAgQ2vEkLF/HFh21tABEBAAHCwV4EGAEKAAkF
 Ak5flbYCGwwACgkQ1pIAPaoCxwqJsw/3VuUwx2LxINifuNwLZGLSg6TL6uVh+TvMphrAN6je
 S3wF3l6SH+hrGda/k0d3FET/ONgEf1+0alFr/Cq7+Ykng7be/uAo4Mi0SzsLE8k6HNuLL5xv
 24KYfd++qP3dYzBh45Pf349Df45lWFwXgxw5Tm9Kno7NFkR/u2CN5w9G499TdJXJbit80JQP
 tWIi6kZCxULerGY51H7yne/E+WBiZk0EeDFAtHzGsCefUjk4BjNghETdXBt9/jxo63BnH23i
 v3DzOTVcs+AaP8PIQbpqwJBnb5j7wIYNM0US7Q+F0d2IG+29Iu+0wm1NQXGCFBSw6wFAU7nX
 xqj1GWq8Y+qR+bGTyJZijdGM0er8S/67cPweTgrXjsk0cL7SCe4q5ucUvWSCSa1K+yCkNODj
 26K+UP1FeRUGTgEFEntqG9rtQEXNJdMAdGzi6842lV8XjdXRGFHvFh1BTIg2pteJhD1Km9rr
 0V4CqVcOTWm/We0Cuhx3KmVODW3uKfMTsMM4eYXPBmMgEpvPTz1sa4xoec0kw4pn1mq5xScN
 d2I5hzVL7Faqg38fN6AyxrhgMGtI09Hu6vQnjQHbGW1ZwAXU43/TfcFa6V1aoYQyLwJbtj0M
 2qErw5nxg+Ak7JU1cNKB2kSWfBvP2Ci9PZw8iuE8zD3nUuei5qrkLhu1cTtq8WVeAg==
Message-ID: <d8e1c48b-70d0-13a7-e563-755a8760b25f@canonical.com>
Date: Thu, 3 May 2018 15:51:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bGnbAzjM7JYve4ImdNbRz5eupiVfmo7Oh"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bGnbAzjM7JYve4ImdNbRz5eupiVfmo7Oh
Content-Type: multipart/mixed; boundary="LyNFLLHMZLeYnh7xCM2ZJhhImiMiZSzuQ";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-audit@redhat.com, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <d8e1c48b-70d0-13a7-e563-755a8760b25f@canonical.com>
Subject: Re: [PATCH v2 3/4] seccomp: Audit attempts to modify the
 actions_logged sysctl
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
 <2193990.pCRMhOm3SD@x2>
 <CAHC9VhS69VD9+L=oN-uLZqvo7BCg+HOvEuT4mnv8Wy7qo2MLMA@mail.gmail.com>
 <3241732.94y415NZZK@x2>
 <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>
In-Reply-To: <CAHC9VhSq=56twBxnzZ8T=APGvtZV39FrHFVqmDMiKOK=WeWJRA@mail.gmail.com>

--LyNFLLHMZLeYnh7xCM2ZJhhImiMiZSzuQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/03/2018 03:48 PM, Paul Moore wrote:
> On Thu, May 3, 2018 at 4:42 PM, Steve Grubb <sgrubb@redhat.com> wrote:
>> On Thursday, May 3, 2018 4:18:26 PM EDT Paul Moore wrote:
>>> On Wed, May 2, 2018 at 2:18 PM, Steve Grubb <sgrubb@redhat.com> wrote=
:
>>>> On Wednesday, May 2, 2018 11:53:19 AM EDT Tyler Hicks wrote:
>>>>> The decision to log a seccomp action will always be subject to the
>>>>> value of the kernel.seccomp.actions_logged sysctl, even for process=
es
>>>>> that are being inspected via the audit subsystem, in an upcoming pa=
tch.
>>>>> Therefore, we need to emit an audit record on attempts at writing t=
o the
>>>>> actions_logged sysctl when auditing is enabled.
>>>>>
>>>>> This patch updates the write handler for the actions_logged sysctl =
to
>>>>> emit an audit record on attempts to write to the sysctl. Successful=

>>>>> writes to the sysctl will result in a record that includes a normal=
ized
>>>>> list of logged actions in the "actions" field and a "res" field equ=
al to
>>>>> 0. Unsuccessful writes to the sysctl will result in a record that
>>>>> doesn't include the "actions" field and has a "res" field equal to =
1.
>>>>>
>>>>> Not all unsuccessful writes to the sysctl are audited. For example,=
 an
>>>>> audit record will not be emitted if an unprivileged process attempt=
s to
>>>>> open the sysctl file for reading since that access control check is=
 not
>>>>> part of the sysctl's write handler.
>>>>>
>>>>> Below are some example audit records when writing various strings t=
o the
>>>>> actions_logged sysctl.
>>>>>
>>>>> Writing "not-a-real-action", when the kernel.seccomp.actions_logged=

>>>>> sysctl previously was "kill_process kill_thread trap errno trace lo=
g",
>>>>>
>>>>> emits this audit record:
>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275273.537:130): op=3Dseccomp=
-logging
>>>>>  old-actions=3Dkill_process,kill_thread,trap,errno,trace,log res=3D=
0
>>>>>
>>>>> If you then write "kill_process kill_thread errno trace log", this =
audit
>>>>>
>>>>> record is emitted:
>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275310.208:136): op=3Dseccomp=
-logging
>>>>>  actions=3Dkill_process,kill_thread,errno,trace,log
>>>>>  old-actions=3Dkill_process,kill_thread,trap,errno,trace,log res=3D=
1
>>>>>
>>>>> If you then write the string "log log errno trace kill_process
>>>>> kill_thread", which is unordered and contains the log action twice,=

>>>>>
>>>>> it results in the same actions value as the previous record:
>>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1525275325.613:142): op=3Dseccomp=
-logging
>>>>>  actions=3Dkill_process,kill_thread,errno,trace,log
>>>>>  old-actions=3Dkill_process,kill_thread,errno,trace,log res=3D1
>>>>>
>>>>> No audit records are generated when reading the actions_logged sysc=
tl.
>>>>
>>>> ACK for the format of the records.
>>>
>>> I just wanted to clarify the record format with you Steve ... the
>>> "actions" and "old-actions" fields may not be included in the record
>>> in cases where there is an error building the action value string, ar=
e
>>> you okay with that or would you prefer the fields to always be
>>> included but with a "?" for the value?
>>
>> A ? would be more in line with how other things are handled.
>=20
> That's what I thought.
>=20
> Would you mind putting together a v3 Tyler? :)

To be clear, "?" is only to be used when the call to
seccomp_names_from_actions_logged() fails, right?

If the sysctl write fails for some other reason, such as when an invalid
action name is specified, can you confirm that you still want *no*
"actions" field, the "old-actions" field to be the value prior to
attempting the update to the sysctl, and res to be 0?

Tyler


--LyNFLLHMZLeYnh7xCM2ZJhhImiMiZSzuQ--

--bGnbAzjM7JYve4ImdNbRz5eupiVfmo7Oh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlrrdlgACgkQ1pIAPaoC
xwrG6A/+IT7tMC7CFvpUqnDginDoHWU8ZVzyL2X48Gx81eCqCOjEtlmvz5div3kW
xjoeT8gl+PYg8Ds2Ol42cG+D775Lf3VYG51ntnL6VN38HvhYs9f41iIlKPGRAZTn
X05lQju647U3kuZYHHY8O8JwRxvopaVk7iezCYmojDIIiMrODWrhxzuj0Ub5y0tP
vpuVVXSSfw2wpuMw0nFrb0kDYZiNhsKseF9rrq1JysuFMtopolGg7nDI6bbprhpb
/K9DwvuYR+cwDs2iXyHe4AOXheMTxcyhd3kF0lVLMcxJrYUPe2ON6XY/2v/Nciac
hJQv1wHfaDqbviWtKV1zPJ+xl6orFi/2GoFCxBKUsDDGH7x28hpXSix/VCeJTPSj
m2Fxg3CQSFvE6cVlq136PBVvq1IRv8Jq4rWGCpsKKEOfRB0ZJT1NNYjSG8ZDcaeX
b7fsZnMQK3wYoDvJ/zctyjuNe6NY7U5V1whGF1M/eRB3gOInFt7yyZp8Vn2UkECi
nyPI+jM5dWKrhTejYMQgO3sdniWilqMW9kPgR/BBr8XDrepAptmb7PcmjMZ+ZJle
Ps6IVYJhOFT+ENi1ca3q3MiV7Jvwd298SRH5lg3j0aEgp35PbVkBkkjldu/rhKA6
uXWj7P+TS9RPbE1YTUbOOLuN9mBq2Mv7B0vGtPBXTO2hGVQpsHM=
=03ki
-----END PGP SIGNATURE-----

--bGnbAzjM7JYve4ImdNbRz5eupiVfmo7Oh--
