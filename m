Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCNJag (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:30:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46200 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752474AbeCNJad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:30:33 -0400
Date: Wed, 14 Mar 2018 10:30:31 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/sun4i: add lvds mode_valid function
Message-ID: <20180314093031.tsusfcohd7ftovu6@flea>
References: <1520940019-68977-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jlz2lfrbgotdm7to"
Content-Disposition: inline
In-Reply-To: <1520940019-68977-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlz2lfrbgotdm7to
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 12:20:19PM +0100, Giulio Benetti wrote:
> mode_valid function is missing for lvds.
>=20
> Add it making it pointed by encoder helper functions.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jlz2lfrbgotdm7to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqo67YACgkQ0rTAlCFN
r3S2ZQ/9Hof8jMZ7MMCq6VNIuoKeD4C7vUHTR80cVN0MtVLLJkRYEzIAEG1eo4T9
5PM9FbUebQ7sB6se39gFArv4SSgKaQ4NIPoPWAWlSE+mqJo5ZowMaGoT13WCMkgU
wcsH6BsWbk4BAPV7f9YpxEc+jp8daqmJIbbNvaUuuAFXTVz5OfgmshgF3qSoMONJ
TxE0Z4Rjf3ZUXK3rC85Lc+eKrQi4uu6c1NLB8LOeWalKt+nS5vEqszH/H6EfRgaM
FwVD9Kk6qS8zLLT5dVVSI4uteodhyDMpXKRf1AcViMCqjIX8mCtvGTPD4xxdO6mU
ia8pogctkBMtwuV5RJny9tUhf/9cPD1iOcsiAYbRzrn/yR8UlaBUBhTjhBsc0I7U
Uw8AsYgnvzywmcxe8Llfyhtsdlt6Dr/TGv35zs1g3uxDrSguvytwEDlbMOJJ02s6
qFnwN4VwceYVQow6z7PyW1JTSJoyMVXXykwfp90Zoi60oo6F6fwX2i2SGOj8s39p
efRCHjcicDJFoXr+MojX8jzo9A+ZdUzWPhIsYE4x7N46jFddhcYYT9U+8mIok5hT
MmpxdBOZarxh8UxCRbjg51lZmLds1zOCSmGtDaUPe2phkO4m2AFIkK0zQbAKc+rm
rU8EHK/8mpVuLIL2Ssgci2TwxQl1u0P7XDeIUE+rJkv2WRpcggw=
=ZnRT
-----END PGP SIGNATURE-----

--jlz2lfrbgotdm7to--
