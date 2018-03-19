Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeCSXPD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:15:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37519 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeCSXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:14:59 -0400
X-Google-Smtp-Source: AG47ELugkViJrl84ALMintBfXUaFuzRbLM1/obvDPuqA2/dWbaErHiPKVb2rtPCyl81aq0wCKjVY4Q==
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        puthik@google.com, Benson Leung <bleung@google.com>,
        "'Benson Leung'" <bleung@chromium.org>
References: <20180309121549.630-1-harry.pan@intel.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <56dfa209-0592-90f5-bd96-5e5df28abd2a@google.com>
Date: Mon, 19 Mar 2018 16:14:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZhgbKaIbgD3qoYndXy7UBY0VmTOocLtfL"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZhgbKaIbgD3qoYndXy7UBY0VmTOocLtfL
Content-Type: multipart/mixed; boundary="NLM87k46ZF1egIWReNv9sx44l7oEQVA2z";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 puthik@google.com, Benson Leung <bleung@google.com>,
 'Benson Leung' <bleung@chromium.org>
Message-ID: <56dfa209-0592-90f5-bd96-5e5df28abd2a@google.com>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
References: <20180309121549.630-1-harry.pan@intel.com>
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>

--NLM87k46ZF1egIWReNv9sx44l7oEQVA2z
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

+puthik@google.com

On 03/09/2018 04:15 AM, Harry Pan wrote:
> Cannon Lake microarchitecture is similar to Kaby Lake in terms of
> RAPL, this patch enables CNL RAPL support.
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>
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

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--NLM87k46ZF1egIWReNv9sx44l7oEQVA2z--

--ZhgbKaIbgD3qoYndXy7UBY0VmTOocLtfL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwRHAACgkQHwn1ewov
5lgPURAAsUQqEJ8eFQ12cwMS2+TKriGkXj9JpYJoMrTbXaVfOlB5OEIav3Shjyic
xjqeqRCxzGdaF3V3MEpzd27VBX4ANJfdxwg0V3SqPd2KX3zTnDieDY9HRkZ4MJhX
SXg73wjd6Fnrm4S2LILLyWKKpFidWkeA/YxvWWuKYIoX7C7sg3jAFAaOqAxUH3OM
VY9hL9uHXz6j0+nRRcEINERSgGF7s1qNpm4Z7uVanuur3wSUUmK5T9qF7byvnXqQ
RYCTxBN7GmK5wI98yQ1kJGmIMTLqGv4vA3YU43c7MPL48Hcxw6iQf6SVs4CG64L+
FmM6wFuuebvkr8FtU5Oo7gqmOFmE/Ni8YvZD7BjHWKKtEQuSm8qoCe705gNsu2IZ
VdOtSl06leACwoem0rwbBfL+fvv8zcVkKJS8hjIqbGZqNr1dNv0G0XNSL0atbzD9
XOgeEUQJTyHLG4DH6n8aICa4tcfuLpk9UFIOwpDokGa5l6qkkeyNPpnMXGLcyG+p
xNlACVQrIJy0lkQoZNqhlzQkss/8QH83aJhYI2s6AxnyegL3itWPNlAz0+Ne0sI+
vb1HljhXwvNUQtP0a02LzOcZhUPdvBDt3xM0aZXeXG+pJpTI+UPJJUfAdGrv/8CE
RGM4OGC/NjkMRkpIXyvO7zEmvVjOC0glbDLqVvuKNeppPu1HjkY=
=owNc
-----END PGP SIGNATURE-----

--ZhgbKaIbgD3qoYndXy7UBY0VmTOocLtfL--
