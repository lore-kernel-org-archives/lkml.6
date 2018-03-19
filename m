Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeCSXDe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:03:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32799 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933021AbeCSXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:03:28 -0400
X-Google-Smtp-Source: AG47ELso73xoGuKtGSg3jeffmRk6lDh+Ov2VaYDXnavo5YQqlPSTn7NfHWAIrGxNSuAzdF2dexdCKw==
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
References: <20180309121549.630-1-harry.pan@intel.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <3171054c-aa81-ba6e-8183-43f6d26dd768@google.com>
Date: Mon, 19 Mar 2018 16:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wYnrYxZmLbJgMGqyicXy6TOTSl6OgdDgh"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wYnrYxZmLbJgMGqyicXy6TOTSl6OgdDgh
Content-Type: multipart/mixed; boundary="jWtexXUY07W9VtYAM2GERIQbAXcHd17Zi";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Message-ID: <3171054c-aa81-ba6e-8183-43f6d26dd768@google.com>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
References: <20180309121549.630-1-harry.pan@intel.com>
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>

--jWtexXUY07W9VtYAM2GERIQbAXcHd17Zi
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Harry,

On 03/09/2018 04:15 AM, Harry Pan wrote:
> Cannon Lake microarchitecture is similar to Kaby Lake in terms of
> RAPL, this patch enables CNL RAPL support.
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/powercap/intel_rapl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rap=
l.c
> index 35636e1d8a3d..295d8dcba48c 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initc=
onst =3D {
>  	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
>  	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
>  	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
> +	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
> =20
>  	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
>  	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
>=20

Thanks!
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--jWtexXUY07W9VtYAM2GERIQbAXcHd17Zi--

--wYnrYxZmLbJgMGqyicXy6TOTSl6OgdDgh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwQbwACgkQHwn1ewov
5liKZw//dDbXB0gY+B6eq8xZpe38ooVVR+47deNJ9w5eR9kkOGoisUhVBBRj8Iwd
fLSWwPRtzXZFDkrX+V9iFjkBSeWzbjOE9GsrM/G2XPwdwHEAQFk/s+qEDPOOi+F3
zepNI7SO69nuBI4H/zfnQWuvOkTaw3751q/f1Vj8Ny3Ud3FcWKdzTqqh06MLT4D4
GDm8qTYT4oORPRC51VU/RW58VRlXp9jO7v/Z7Z0GzsK5YGwyJH5lBo5YfMITr3YN
G+3o088hqkm+jUFnNP7Yaobhs+DPXr3vUksY2XZhDPSXOt7YWcg2J8NNZl30OKGu
QCUhEi/bP3kzBS9sjussgg8feQxbezcTcN9smV5C7s/EMp2XulQMHIb+do0hLxV7
gMgcvCJPGfS2y9UXyE1Q8Ypn7G0y91C8Eh/uaawKT0Dm0xsz+0dL8MLccV2rnZ5T
KLEkT+lKbC0jHVjtFhnk5FnxqOHBNBpXOcwZdEFpXrZxifGS9czjMzxa8xjxkg8b
SB5uCMKS2i3Fn8XQjK08XGneZBGFBB2nev5OH7Lqy0uc/AjS24d7olZ6CrZ9h991
r555QYowwoe5ZYs+Yd35zH8ZLt/zPJHJmXIKchD8RFoh4+K5KzesQfsnVQ677KY6
398g4HTczIBzyokvVay52h//WWlIGwreBzA4jU9xevC4oeQilsg=
=x9Og
-----END PGP SIGNATURE-----

--wYnrYxZmLbJgMGqyicXy6TOTSl6OgdDgh--
