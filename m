Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeCGIc2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:32:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57935 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCGIc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:32:26 -0500
Date: Wed, 7 Mar 2018 09:32:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Emmanuel Vadot <manu@freebsd.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dts: sunxi: Add eMMC for NanoPi M1 Plus
Message-ID: <20180307083223.7is5ty22gsp65eoz@flea.lan>
References: <20180302213852.64588-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yp745zaimxki7m37"
Content-Disposition: inline
In-Reply-To: <20180302213852.64588-1-manu@freebsd.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yp745zaimxki7m37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 10:38:52PM +0100, Emmanuel Vadot wrote:
> The NanoPi-M1-Plus have a 8GB eMMC, add a node for it.
> This eMMC is always powered with 3.3V.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yp745zaimxki7m37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqfo5YACgkQ0rTAlCFN
r3SIyA/+KYdCYDqCoMyjMrk6zS3ZQacum/6g8Qt9KtlWGZuTwqZY9bGWj2qYog2S
9joZsl86FZcHNhGk4dttPAc6E4sPTA4iONsjx9eF3dEdTLXadGbboYnPnwjg62kw
QjBMB/layUKmz+em7Wd1F0dzdR9BmQ/5sHyIdigeZSRkxeTR4ElcTRrXrUDVoUez
HfXYrlwEOoBOEVtlt+dJpRU4N3ta0p6EfW+ehR7DtaDhn4s9KMNMVj2HMenqcSO4
ie+V4JXGLeH48ZItJfPlE+huiVTIBFHcNbIOzJSjVCqPHcn7/TfqYS7beFFmctHN
OY88DS89tntW2iZNBYkSCvgWLgKMsV0MfkmXrsJMitCy+bncExFXHK1zxqwpEYS6
IiuLdupgpUCREeK7PPeAf0Z+QD5nlXGELfEDlxeEcY/Dr9s/xOh2fZ5fWcfMNl9j
rCN18ziMPvwWerzByN/xhom5NG/SQIkC8WK7oKUCDDiqoxHNqUPm4VlDvdQQHxBP
JlNNvNm2/PaFhX/ob/gCHvNVWQKA8mh+HaTD02deKcKS6Y+Ig32UGYn+BeQs7qjm
vDeGVFHxkCLVd5eCY4cXIfdgtTaATuKHXofhNCH5n2cgVWcDGcadu08FQkKLo//V
SOYtm/bKuMrOpRRWLDtZtkpfiQOKPAwJ8sQax5suuswra82jqCw=
=iyr8
-----END PGP SIGNATURE-----

--yp745zaimxki7m37--
