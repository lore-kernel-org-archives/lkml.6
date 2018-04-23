Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeDWKdo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:33:44 -0400
Received: from mout.web.de ([212.227.17.12]:54805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754404AbeDWKdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:33:42 -0400
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
 <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
 <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <02ba4513-7913-6415-5252-9cb7d75f3687@web.de>
Date: Mon, 23 Apr 2018 12:33:17 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XcJkncNpnJC4XqYTgk7XzVUApah2ri6mD"
X-Provags-ID: V03:K1:VLajSjZ630UfKkwrKB3VrHF2nBs+u0UGAIl8au/FZrkznkbvNU8
 p919W9tnf19JHo+xUZ9rJtcDrT57z3b53tJ5BUA+zzHXa3WmkDTIaXm/y43yywsBTxCdLgN
 GIKaoMCgHRm4+o6Ku9GyKImfwFsiJtUr+z+U9sYpAd8b/kg+t+yaUdKmkgJi4ZltgDcoKks
 NdYpqqKVtjAgOzqGSXw9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n4ppw2kUQJA=:shxMPRX783BS6/+Qh9B4p1
 lbWJajAP6p2VMPCdCQWzi57GgWX+FXjcfAC0lwo5KJKsdQu6z6EwlzGhFyeCT3e7eWWEbLKBZ
 8fJ35Ybblg2TI1rf67jCbNWwJan46LK56ZZK9fm7VLk12ns5T6OYyigkAh08f5NQXrfRWKM0/
 QlwrPbn31rSKWBWrHN2vRTStmYuPIdZ2bKFaOwh5IYsYdLz7aNLriEPUfTYiWXMhX9qW2pCGc
 mPWKVpPEa8gn2AlR/uIjTnY9t3kiYxxiSONLgTHPmuzVZ2ew1fws3Duv65JwDD7WChFT1Mtcq
 +1Mt3t6l1DH26CYl2ADqDLMi0wvJLGa/pHY2dwxb007gKBqi2vFqcZA5yfVf5xlDs5HwEA+yK
 VgMXj3Lk6lB0Ep+ywoIPPlW5yZROljIwDD244ym3+LoVSmdsC0xcpWT0igY/kX8xESd/arHfv
 WH1m7/5VfDbazJp+ShdGIzrW22BNCMwisEfXImgQAsfout0JYeLyt9WLMYku3eRXfW2W/ty+V
 g8UIdZxZty50nZ8tYOExoPeFMLWi1HAPIXY40f507zx4YeP2aD+9RHRlm0jBOD3U/B5SDDsOU
 ibVMMN9PgrxVjOrI/tpvifaw9Xs2TKUiwIelSshb5XRE1/lFnrsvHrY1Kc/47dNyRuBeDna4d
 d8pTIy1vtujI3NaKBpwmSNW+cshdNMzrcc2oZ+Blg1CWlVebGdNtLX5vAJXAVDHndqjcJ0b7m
 aJoHn/TmTXbFUb+0C3/TT+9c7YqCoOxpgpsvlOYtykueeRCuxHnlENJD17A/72ICwMSrzb8Jc
 2SU5qqtMVlrBMYu18FNgijypnE2oA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XcJkncNpnJC4XqYTgk7XzVUApah2ri6mD
Content-Type: multipart/mixed; boundary="QEo3OMI4mWNNevmWN5lOVFjPqRgJLCZ3b";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Message-ID: <02ba4513-7913-6415-5252-9cb7d75f3687@web.de>
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
 <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
 <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
In-Reply-To: <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>

--QEo3OMI4mWNNevmWN5lOVFjPqRgJLCZ3b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-04-23 12:29, Mark Rutland wrote:
> On Mon, Apr 23, 2018 at 07:00:52AM +0200, Jan Kiszka wrote:
>> On 2018-04-22 21:06, Mark Rutland wrote:
>=20
>>> Does the below help?
>=20
>>> From ade322407e3d6d1f50e558ebd50d2c1c7bd811c2 Mon Sep 17 00:00:00 200=
1
>>> From: Mark Rutland <mark.rutland@arm.com>
>>> Date: Sun, 22 Apr 2018 19:58:08 +0100
>>> Subject: [PATCH] arm64: add sentinel to kpti_safe_list
>>>
>>> We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_ran=
ge_list()
>>> can walk past the end of kpti_safe_list. Depending on the contents of=
 memory,
>>> this could erroneously match a CPU's MIDR, cause a data abort, or oth=
er bad
>>> outcomes.
>>>
>>> Add the sentinel entry to avoid this.
>>>
>>> Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks=
 based on a list of MIDRs")
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Reported-by: Jan Kiszka <jan.kiszka@web.de>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> ---
>>>  arch/arm64/kernel/cpufeature.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufe=
ature.c
>>> index 536d572e5596..9d1b06d67c53 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm6=
4_cpu_capabilities *entry,
>>>  	static const struct midr_range kpti_safe_list[] =3D {
>>>  		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
>>>  		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
>>> +		{ /* sentinel */ }
>>>  	};
>>>  	char const *str =3D "command line option";
>>> =20
>>>
>>
>> Jep, all fine now!
>=20
> Cool. Can I take that as a Tested-by?

Yes, sorry:

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan


--QEo3OMI4mWNNevmWN5lOVFjPqRgJLCZ3b--

--XcJkncNpnJC4XqYTgk7XzVUApah2ri6mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlrdtnAACgkQitSsb3rl5xRXGwCfeU9sRJhb9h5XQ75PRq/6gGlK
aa0AnROtD6I5Wy4sqnoiwmyoBfUFCM2W
=fQGb
-----END PGP SIGNATURE-----

--XcJkncNpnJC4XqYTgk7XzVUApah2ri6mD--
