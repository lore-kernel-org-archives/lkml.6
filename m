Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDWFBT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:01:19 -0400
Received: from mout.web.de ([212.227.17.11]:42577 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeDWFBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:01:16 -0400
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
Date: Mon, 23 Apr 2018 07:00:52 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180422190639.lyfvgnzapo2mrpu6@salmiak>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1znVi35YNlXXPoj81qE88oRx1RIUVv66s"
X-Provags-ID: V03:K1:78Lq1xa/n4ByMluUd2uabW6TVj64GJkw5ziSVT6IJ1SGahNxyw7
 SJ33wfgboUPrhpwwFhkAd/cKI6hRHdMpF+xsWkX/GIyJbSgC/nMrBGmLsHM17Bw0VmoPSWe
 7qkNb3n7vg+l+LE32TO+rzzRSicM4pdHjOhl2TXBvUGotYNPImbtjVmRuv0DZ/iuK4tRv8z
 ieZ0aNduwCDQp1Ux+veHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zZLs8TW0KsY=:X5tlPz1u/PlqqlgRPGnzOR
 d08zmIxV1anl5KL23btaN66+5gtiz+xS678y8teOnDzDN3MCDpKqQZ6RRPoBUgnudiHL7rokt
 79DjlltLmS6JRpsmlMzmcXYzAmrC97X63LyRCm2vWWujpSjcMrgzBK2agoi477M1LIfc5oSau
 jnLfQIzLhsnHl5WsUHm6BB+7lEXA7qVld+0tHwDX1PHebw37ckT0H1nedlNLeH7XJfRz+aJVB
 lC+F9/yvt2EVfAASn3W39EHLFjGNiaMwuM3/YHITg4/USGsrIJjYjaJ8mr/ePpWIqtcJpbvgJ
 suNQJvNQayvZQjYO12h7U/R6pepEmJDSXzYV3EGPsnDitHCQAtGCyO2AnDgJgoikr1Y1c2W38
 bnbJMpLupT/HYx7KXgD95KBa2pUmE5l/b5JSJfumCBFE0YigIoIxrkh3SlzfXQ0BKvZs6fBOH
 RcXLn9+tEmIcPhQ/vkcaKWklGK+RT2ZZU9vKeqZZvbkL+HAgjodXQurYL0KnDBkOCebDR+zkN
 tmjREllzj+qLX+dApY/BY3PtME7yPguGO82r9bANW8Y2MNjmCNWUxGD7Yn5rg10G05pSd68Va
 vDr1qcdVjv1DTwPrF99ZG2B03q16Paxsx0TbWm35V4uLoD0Hf1buHhlOJZ/a4My8mV0WHUIMr
 5L7f44pMve69E7n1YeiNqVoAHfavaBcGzhtkP5oyQNFDRUJ07VOxio+f2YpvKYlRF/aJsc4JE
 4BZudcjORuNTjDH5zFLZOFBUkqZdac6MvI5oQm6Kmdyu0sv5pjvEiE3mW2asdxpQgB9dpsQXJ
 /lpfdMvyrH46ZSjB/TAkjMRdVEfqA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1znVi35YNlXXPoj81qE88oRx1RIUVv66s
Content-Type: multipart/mixed; boundary="qsHzwwEy6FMnoJpN4grxAcEljmoBcuKwt";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Message-ID: <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
In-Reply-To: <20180422190639.lyfvgnzapo2mrpu6@salmiak>

--qsHzwwEy6FMnoJpN4grxAcEljmoBcuKwt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-04-22 21:06, Mark Rutland wrote:
> On Sun, Apr 22, 2018 at 12:47:57PM +0200, Jan Kiszka wrote:
>> Hi,
>>
>> this can be triggered simply by running
>>
>> # echo 0 > /sys/devices/system/cpu/cpu3/online
>> # echo 1 > /sys/devices/system/cpu/cpu3/online
>>
>> [  455.904854] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  455.906108] BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0=
+0x70/0x1a0
>> [  455.906668] Read of size 4 at addr ffff200008e3a9d8 by task swapper=
/3/0
>=20
> It looks like we miss a sentinel in kpti_safe_list.
>=20
> Does the below help?
>=20
> Mark.
>=20
> ---->8----
> From ade322407e3d6d1f50e558ebd50d2c1c7bd811c2 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Sun, 22 Apr 2018 19:58:08 +0100
> Subject: [PATCH] arm64: add sentinel to kpti_safe_list
>=20
> We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_range=
_list()
> can walk past the end of kpti_safe_list. Depending on the contents of m=
emory,
> this could erroneously match a CPU's MIDR, cause a data abort, or other=
 bad
> outcomes.
>=20
> Add the sentinel entry to avoid this.
>=20
> Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks b=
ased on a list of MIDRs")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeat=
ure.c
> index 536d572e5596..9d1b06d67c53 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm64_=
cpu_capabilities *entry,
>  	static const struct midr_range kpti_safe_list[] =3D {
>  		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
>  		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
> +		{ /* sentinel */ }
>  	};
>  	char const *str =3D "command line option";
> =20
>=20

Jep, all fine now!

Jan


--qsHzwwEy6FMnoJpN4grxAcEljmoBcuKwt--

--1znVi35YNlXXPoj81qE88oRx1RIUVv66s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlrdaIkACgkQitSsb3rl5xRgsACgz7U4Wz1oLfh+pmR+RsCDN265
cOMAn0wAHoX0XzmD8xZqLeBICXy5GUR+
=0BMj
-----END PGP SIGNATURE-----

--1znVi35YNlXXPoj81qE88oRx1RIUVv66s--
