Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934365AbeCHPJ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:09:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52595 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeCHPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:09:25 -0500
Date: Thu, 8 Mar 2018 16:09:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: sunxi: mc-smp: Use DT enable-method for sun9i
 A80 SMP
Message-ID: <20180308150921.ftwrbbuhc5fxkchq@flea.lan>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xin56tz3uxjkgah"
Content-Disposition: inline
In-Reply-To: <20180308150012.19045-3-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xin56tz3uxjkgah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 11:00:10PM +0800, Chen-Yu Tsai wrote:
> Instead of having an early init function check the machine compatible
> and installing multi-cluster SMP support for the A80 if it matches,
> use a new cpu enable-method string. This makes the platform support
> future proof in case anyone manages to add PSCI support.
>=20
> The original init code for the SMP support is changed into the
> .prepare_cpus callback in the smp_operations structure. Instead of
> panicing when resources are missing like on some platforms, our code
> merely guards against engaging SMP or CPU hotplug and returns an error.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7xin56tz3uxjkgah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqhUiEACgkQ0rTAlCFN
r3SNFQ/9H8VUOSNegGopmfdZ+TGUc3XO2zyQX300PHDO8zyg/l92VDQbogBAuiJg
h0Ui58NALcyRYnJ3we6nfz5QwYrY0uTtdoAitvedlOyXTMoRNxb5mi+NzXdLM/J8
ydvOekO6mpd2dfu7BLnDRsgJurkDqLYFRz+dQ34WehPNRi4DmRlNb+YzMYJxZIyC
iUyXuJanvbUZqzMHRlhglxd5gqYWMB6b7d7sr3uVz8MVdgP+NhVtoySacIhayeEX
uybu+WJkFq4NV1kNLmS5Np5imivj+MItAXOZsHXrrO9f9pCB4w6YGjvZJ9NcMP7Z
iWqnWy8hoolOLFRdETYU52GGQ+++VRWzt3pOOstjOYT3HzFG/SMQjCTjmTnQ2B51
bBWSY9gs05jpJpcR5SuRwz5lUi0cheSnCa8sbq9VmpZDFGCGwXGqNc7jfiToGBE3
4actwzPd7pFV0nn+iTO6wXiyynm+FDhj7jn9N1fUf3t56dyAJ5htUHdRdfGjuxGO
NUyfnRxbsbJKy8+qVGasXeb+Iy/9Fn7zpuEHWc0S6KeD3tpIIa6lwCyW9X/s29oC
k/iXC2qGsBYnOYpQLSkRayWCgkSZ1guCa5TLEigDuW8p2I+Q9ow+0Eied/auQQCz
Z5Fh/aNGKYTBvnsDHrX6yHHKUZxh2dW4YOAwy6vbDsnsTXn06uQ=
=sG01
-----END PGP SIGNATURE-----

--7xin56tz3uxjkgah--
