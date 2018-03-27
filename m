Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeC0OtS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:49:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54884 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbeC0OtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:49:16 -0400
Date: Tue, 27 Mar 2018 16:48:56 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 09/10] drm/sun4i: Add a dedicated ioctl call for
 allocating tiled buffers
Message-ID: <20180327144856.rb757m35zyscefnn@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-10-paul.kocialkowski@bootlin.com>
 <20180323104856.qo7w376xr3gcznmm@flea>
 <1522140098.1110.40.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zstotidfqi5mpaxt"
Content-Disposition: inline
In-Reply-To: <1522140098.1110.40.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zstotidfqi5mpaxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:41:38AM +0200, Paul Kocialkowski wrote:
> > > +int drm_sun4i_gem_create_tiled(struct drm_device *dev, void *data,
> > > +			       struct drm_file *file_priv);
> >=20
> > Do you need it to be non-static, and part of the header as well?
>=20
> Here as well, I just find that it looks more readable that way, below
> the drm driver structure definition instead of above it.

But it also creates a global symbol for no particular reason, while
we're doing the function-first-structure-later pattern pretty much
everywhere else in the kernel.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zstotidfqi5mpaxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq6WdcACgkQ0rTAlCFN
r3RKVw/+OfixjNI/ZANFhCSuq0kLnB/1M3owibhxGW+IgTGvtmOREOTEQiGyulNw
Hcv50FY0+LfYEj6rOPTpLw7Gg3W0xZrDuEn1+AWc5IMPNMtQ3ncOj5MXNtU9hagD
9vuJGaWpkYycO5V2h1kptbt4FMLuudXh7B9yvUOUCkzIDmJ4PeMRVXNyvkDmz//C
r6v8pi6+Lqu7rTsnNONzqNkXDLkuEQkRqCn0d0g826KGD+Kwh/ZfxoRe1hqYjRU6
9+E4f/fdeM55VFeQIrqkQy8YxKEVqpOrMHCrAwHskMq2e9vallsGQ84sZkJmhw+d
eIElqWnSvq2VlZFsi4Y54dp0/tw47TgyuKRLfdzOIKcHuQAWIwY0VAMCZxFs/Eqg
9ZTOk7ZlIQfo3gRR4+QTtoDeVvEGOB80G45avUsojQyWPDmwhCjR1LKKg7xXe+Vg
aEYzpoehxEv/FqrKLI/jyFEPSNaFZmy2YtX3RfFbMjMbTVh2r5wFnk7o3miBseQu
zuvLOL83a7aPIWyuqPBA650Nu6FOZOdAQVQu97bL1EJIsy55Z3kLY91YZjzZVRl3
BiEngKy0d9wXjEZaT2Go1p6V7klKGpU9BDA7LCnwcQ/6o/Uy4ik46W+UIVWhbUkh
gKwAKrUPvLFD3Goit1hHS5zK2nus9AMigUuXqA1M9IW/EBhBNYM=
=Xi4s
-----END PGP SIGNATURE-----

--zstotidfqi5mpaxt--
