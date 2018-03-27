Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeC0OsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:48:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54773 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbeC0OsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:48:00 -0400
Date: Tue, 27 Mar 2018 16:47:48 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 06/10] drm/sun4i: Move and extend format-related helpers
 and tables
Message-ID: <20180327144748.xxpn4s3wjpt6hw4j@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-7-paul.kocialkowski@bootlin.com>
 <20180323101338.z422gpxcsdre5hgj@flea>
 <1522139264.1110.28.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oe6kmzoyszps5zbf"
Content-Disposition: inline
In-Reply-To: <1522139264.1110.28.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oe6kmzoyszps5zbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:27:44AM +0200, Paul Kocialkowski wrote:
> > > +bool sun4i_format_is_rgb(uint32_t format);
> > > +bool sun4i_format_is_yuv(uint32_t format);
> > > +bool sun4i_format_is_yuv411(uint32_t format);
> > > +bool sun4i_format_is_yuv420(uint32_t format);
> > > +bool sun4i_format_is_yuv422(uint32_t format);
> > > +bool sun4i_format_is_yuv444(uint32_t format);
> > > +bool sun4i_format_is_packed(uint32_t format);
> > > +bool sun4i_format_is_semiplanar(uint32_t format);
> > > +bool sun4i_format_is_planar(uint32_t format);
> > > +bool sun4i_format_supports_tiling(uint32_t format);
> >=20
> > If we're going to add so many of them, then we should really consider
> > to move them to drm_fourcc.c instead. Every one has some variation of
> > some of these functions, we don't really need to duplicate it all the
> > time.
>=20
> Should I try to get that through in this patchset and have sun4i-drm
> be their first user? Also, does introducing such a change require
> identifying duplicates of these functions in each DRM driver's
> codebase?

I guess converting at least one of them would prove how usable it
would be to other drivers, but I won't ask you to convert all of them
as part of this serie :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--oe6kmzoyszps5zbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq6WZMACgkQ0rTAlCFN
r3SJag/+MLNrEjxxBjwh1egDIT/GHqYwkNvnpjxeAb+ysZq8YgclnFb9X1XvWUD7
Zs+51/3hge7t4fj65qfl9bTQjxuJ5cwSFI9UjRhj49tZQLhN08DDhC09tKSRyUBX
LNJoMo24gAB9rxNfxUJKtVqiXYRCGNXPSIGhpXcduumiemlLtC9xQf0IT0hv7rp4
TYpgnXa5Fw4Y7HpM3oZj0LEE/rk26loqVIoKxWcCHDyCkGU6ZKD5LuFYTHgl4H5T
keEn+qoqAZ/E74YX9X0FWrLQAI87UXeBqOCfe1X0V10+bbwXaR6UjTiMNxkPrxyJ
myqxaiEaGVzaHpDz/gt0Pu3iria7XgUJKW7f7QDBwQ2xBsXc2nU7c7/ir50e7TlI
zsRe6B6SXz2NXl59mbbwIBNzMpVi+3aboZ/CHwcZbSWbSoetuCZlYHaxK1Qaynls
gmdiP78d2dseUzLPxJ9cez+MB0m/3KnVgdFC34N7ZOfdFgH86Vrxrv/61ynfK96+
sF7Ri5WcDy7sHlmMU3vafdFFmsDaNuotf46UpK6K2vl5LeI4xD3dN/M6T8ZbXs25
Ow+0n/mpH4ikPBSBAwltxQHH/ZKCv/DiBhqxzb21p1P0sv0lWS2wIv6BtDmLW3NL
I4DnXHSauEh1M+Ig7gKlzN+IPnXG1jhM5/YtjsupU3NVYvxeBFw=
=GhyQ
-----END PGP SIGNATURE-----

--oe6kmzoyszps5zbf--
