Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933433AbeCSXFi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:05:38 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37773 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933347AbeCSXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:05:37 -0400
X-Google-Smtp-Source: AG47ELs6Lr0e0X/hqG3nXWE8j4xln4nq1LMB9dA32eCzfpbrJpyKxz05b60lNv1EwCz8bsOXfz7lVw==
Subject: Re: [PATCH 2/3] perf/x86/intel: Add Cannon Lake support of RAPL
 profiling
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        peterz@infradead.org, colin.king@canonical.com, puthik@google.com,
        bleung@chromium.org, Benson Leung <bleung@google.com>
References: <20180309121549.630-1-harry.pan@intel.com>
 <20180309121549.630-2-harry.pan@intel.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <a8bee7c7-8d09-f37a-9d12-b3a8a68a9b37@google.com>
Date: Mon, 19 Mar 2018 16:05:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309121549.630-2-harry.pan@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bApq2JhOmXiQsZcOfM2hDc4uKLEulSVPm"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bApq2JhOmXiQsZcOfM2hDc4uKLEulSVPm
Content-Type: multipart/mixed; boundary="bxYjLrPmX8wwIxjJupRU5SRBoMe4KWmuM";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, kan.liang@linux.intel.com, vincent.weaver@maine.edu,
 peterz@infradead.org, colin.king@canonical.com, puthik@google.com,
 bleung@chromium.org, Benson Leung <bleung@google.com>
Message-ID: <a8bee7c7-8d09-f37a-9d12-b3a8a68a9b37@google.com>
Subject: Re: [PATCH 2/3] perf/x86/intel: Add Cannon Lake support of RAPL
 profiling
References: <20180309121549.630-1-harry.pan@intel.com>
 <20180309121549.630-2-harry.pan@intel.com>
In-Reply-To: <20180309121549.630-2-harry.pan@intel.com>

--bxYjLrPmX8wwIxjJupRU5SRBoMe4KWmuM
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Harry,

On 03/09/2018 04:15 AM, Harry Pan wrote:
> This patch enables RAPL counters (energy consumption counters)
> support for Cannon Lake processors.
>=20
> ESU and power domains refer to Intel Software Developers' Manual,
> Vol. 4, Order No. 335592.
>=20
> Usage example:
>=20
> $ perf list
> $ perf stat -a -e power/energy-cores/,power/energy-pkg/ sleep 10
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  arch/x86/events/intel/rapl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.=
c
> index a2efb490f743..32f3e9423e99 100644
> --- a/arch/x86/events/intel/rapl.c
> +++ b/arch/x86/events/intel/rapl.c
> @@ -774,6 +774,8 @@ static const struct x86_cpu_id rapl_cpu_match[] __i=
nitconst =3D {
>  	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,  skl_rapl_init),
>  	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_rapl_init),
> =20
> +	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,  skl_rapl_init),
> +
>  	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
>  	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_DENVERTON, hsw_rapl_init),
> =20
>=20

Thanks,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--bxYjLrPmX8wwIxjJupRU5SRBoMe4KWmuM--

--bApq2JhOmXiQsZcOfM2hDc4uKLEulSVPm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwQj0ACgkQHwn1ewov
5lgOng/8CIMSr/bX1r0jjZ28v3068+aphf00dM9LuqR7dKETNEYekgTU3dYxYRUE
LGeQC61deplilDwZ0oGcQ9ViqFd9dAHwPufwkIz7BoVYszE7H4j5qOGaKi1MVTfr
rjK/7ziLLVqu6QUdNSFxp+SlThAB0dzP/szYR8+6fjfmHZzK0oPoaW66Eol/LeYm
L8tOmZzKbZE6AUc3bLaurti0Ty1QRv15j8x6RW+KaR82S/TJIHMXA4gVCfkYa/2U
hZinIEUJVLmLfpKcCD/T99P9hdZd7CHQjGlljMOfWjot77noMJalOJ8MBxEHtOcO
+enVTk3HEVb+XuUOKrNJBPjCKOZwUF2Wn4eEY7j1v55JLGLr0F5xXrE9BaCW61EJ
71vsiyneWroa3BP2yrKgEpUx9m5ZrMA1AzdAiOvkqmtgzVCVYRpIVzboeO0u1aDu
4NjNEmxOUA7veoa2gMSDNvHO7RlCnn1+ueMM+GJZElQSUDmd72Mi6mQQW1MKN/A0
TGMEyflBPr+MjJlMpwyY0RFfmVBUe6zucuLvjX4ZYz5vlh9DsTNyYo/WiXeDQ3da
G0UhL8N4n/dwDa7Yb9Ab5rAsjH6obL3KRKwXajvsl9AUAKoZzOm0HEvISZF/0c+0
A4dZH0F4ITKsQlMiHNrLcZr8IjsW9iA/B7CHrG706Im9KGG0aU0=
=BrlL
-----END PGP SIGNATURE-----

--bApq2JhOmXiQsZcOfM2hDc4uKLEulSVPm--
