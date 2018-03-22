Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbeCVNlE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754239AbeCVNlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:41:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1E72177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Mar 2018 13:40:58 +0000
From: James Hogan <jhogan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Define has_cpu_mips64r2_user for
 Loongson-3
Message-ID: <20180322134057.GG13126@saruman>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
 <20180321145304.4639-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <20180321145304.4639-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 10:53:04PM +0800, Jiaxun Yang wrote:
> All loongson-3 processors support mips64r2 usermode instructions.
> However 3A1000 3B1000 3B1500 should be treated as mips64r1 in kernel.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.=
h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> index 581915ce231c..71c893249374 100644
> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> @@ -49,6 +49,7 @@
>  #define cpu_has_wsbh		1
>  #define cpu_has_ic_fills_f_dc	1
>  #define cpu_hwrena_impl_bits	0xc0000000
> +#define cpu_has_mips64r2_user  1

What about cpu_has_mips32r2_user?

Cheers
James

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqzsmkACgkQbAtpk944
dnrACA/7BokuXdSxjgIOhDyKYjJkYtzXW7PF7FMAiB3IPVTorb7mgeudyZ6bsWYs
dHOnoO38RA35wxMJtlg2pntdxsX0ABosbJFXJz91svgfcvOYPXG+aKK2jygf8Zv2
Yu0uxRV86twTZdnQXj07HHx3qWQMPcWAtxPXUl/ANHvCVRisIqp5gP46RY9WcHTw
6DsxMjg9oiL1T0GMnRHXNTqdGhRMgQE55aVPtPQ23K2cT+yy9cUvzwL1vSLk/hsF
5ibYXaBn6Lj7ixGTi3WYzA3vgw7aY1VnCSXb9LirpA8BeVj338QuBZ2mYg0NjLv6
+16i6jzgXz6wDSDusKHsoyeOxGgNxVe3npHw7c0aZ4F+vfBhacLhr+KVCBqOG6ly
P+j3KhtiMMB1dzDZIB8MNwu46xmxEquCofFph9/bdzHOJd293vIOKnCShZb7fxd/
sNBGnemcAPNwUi4hXiFDD5BV/gUPopQR2+DMKli70SJJ6WRN84Vu5HNxx+liuo94
PvgYJEOACXjLI9B9m9SQmLW75QlJ8F5XVfjfpWYV3UfXuJc2vMtGKYDuyl0SdEJx
S1EzpQb7gUEhPW7J6N1i0VThfX4RMcqz8IeOAcBzRdEzhP9RBe6egE0iCB8UVG5V
azlNWTbTZTrqX+SWQKyag2wbRbrRoGV2qJxJsdB2uPPngED50GQ=
=8C3d
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
