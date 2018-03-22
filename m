Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeCVIHB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 04:07:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34940 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752494AbeCVIG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 04:06:58 -0400
Message-ID: <1521705949.1175.0.camel@bootlin.com>
Subject: Re: [PATCH 08/10] drm/fourcc: Add definitions for Allwinner vendor
 and MB32 tiled format
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Thu, 22 Mar 2018 09:05:49 +0100
In-Reply-To: <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
         <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-L7lvQHvlwIUcVZd6fL5f"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L7lvQHvlwIUcVZd6fL5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2018-03-21 at 16:47 +0000, Daniel Stone wrote:
> Hi Paul,
>=20
> On 21 March 2018 at 15:29, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > +/*
> > + * Allwinner "MB32" tiled format
> > + *
> > + * This is the primary layout coming out of the VPU, where pixels
> > are tiled
> > + * 32x32.
> > + */
>=20
> Can you please be a bit more specific here, following the other
> examples? In particular, it should list whether the tile order is row-
> or column-major.

Yes that would definitely make sense, I'll do that in v2.

Thanks for the review!

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-L7lvQHvlwIUcVZd6fL5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlqzY90ACgkQ3cLmz3+f
v9FntQf/dxJx5mpnJHRp3Kd8mmvbOF9JA8U50xbYK7o7h/KzIi6WV+6HlD5rvAd/
h0Ux955AweCv3OTdg5qf64Vpev6q24HU/m5gvHPgHRzPRrBIJhYxaXC8gLenI10F
4NkJpHwtD2fWdjvhT5AWWn2JkolJuLYVMfuv5og+c1Lil3GcOQoNzlwXhWhLHdKl
f3+uuqhIW2TmV0TfzC8fw7mo9iJvwiw8J8uEwkGIx3PKeYkgiRFI+SH4hK5P2sxs
yvpYV1d93um/5V7DYep9wvTDyqnZuomfjYSOfRCzgKE8Q22BBk7GRx5TCKi9g6r+
hxJEbFNDICh11gpUeqtA0UgekDFUog==
=dJFt
-----END PGP SIGNATURE-----

--=-L7lvQHvlwIUcVZd6fL5f--
