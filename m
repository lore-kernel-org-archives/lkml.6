Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967257AbeCAJ5f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:57:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36297 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967092AbeCAJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:57:34 -0500
Date: Thu, 1 Mar 2018 10:57:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
Message-ID: <20180301095721.4iga7dcgg566j44m@flea>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvs3fzmvisxtndlj"
Content-Disposition: inline
In-Reply-To: <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvs3fzmvisxtndlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
>  static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs =3D=
 {
>  	.get_modes	=3D sun4i_lvds_get_modes,
> +	.mode_valid	=3D sun4i_lvds_mode_valid,
>  };

This should be on the encoder, not the connector.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--vvs3fzmvisxtndlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXzoAACgkQ0rTAlCFN
r3SuYhAAhsQL2pw+oTcI1t4aNnH9HlJG5bKq+pSN3JfHC3pWr0qz2P00f3cG1YQX
tkvMWalgR4xZlLYxcE2Lw7rtpM6cskyVtkV3a7pGLYofA43zxNzbEYDgsFufwelY
/I4udeS65Zf9aujNl2HNz43dmGEw9tYVen3EDHRX8Jmrx9ZSEKHRwD+jl/76h+wo
4Ikm8dqNF3ssTTxNFznS12qbtnK/9h5T0EOhKUS04nEu+96PInwIK6bI8KD4Wjd2
L0+feJ+SaYw2aKrz0aD/N7qAyUWO3W+iHx2FEanj29KWVWyYYC3r+TGYLhTGCDwY
sidvZEb9TmBDFtbAjLW7hHcI2Z7je1kXvR6vXVkULHQT7b+hcm+AOI3Oy0g2Vzr1
GCaVj8HBQe1sKGLGongwCvyR8P4PalngzfFKSS5QYqSX5icuRUfbIhJMrXKmCARH
lZatrXrw7/SUPVUL/KqbOscDSsJHoGxRQmAVOPLxSyQ8M/ERW1ccpzCtgrhvtu+I
aj3dh1WehrBzQuyoFY8rXNBGieDZBAY7qwDLBTL3Xx2e6YwhOBsru8wUCFc+JI1U
N8QF9QoOVXlooV8Lut89xNdFYXQokeHB69pnWqVNYbGvAqxFhdm/tncz85wSQcmt
UTcuSmDb2mnWObbtd84Wb4O7blR1ncPzCvZpRatbEvNFpWpbcSw=
=BkVM
-----END PGP SIGNATURE-----

--vvs3fzmvisxtndlj--
