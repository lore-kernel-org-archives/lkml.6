Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeCRV50 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:57:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40049 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754304AbeCRV5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:57:25 -0400
Date: Sun, 18 Mar 2018 22:57:12 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Add Mali node
Message-ID: <20180318215712.t2evailkwua5xxow@flea>
References: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7br5xyiczou6vho7"
Content-Disposition: inline
In-Reply-To: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7br5xyiczou6vho7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 11:16:45AM +0100, Giulio Benetti wrote:
> The H3 has an ARM Mali 400 GPU, so add binding to our DT.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--7br5xyiczou6vho7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqu4LgACgkQ0rTAlCFN
r3TDXA/6A1nkN6lH8iE98zckrDlgEktATEwGao635p3YhKyfhNnBrZmR5xzp5fFn
lco83aVTo6NIkP60Yueb1svKy1qPg44+hMAjiKP9eG359NVYGpcVcX19lHnGIlop
/W6rixVg96C6XvmmVY2PoILjZpzkrzHQ3jn+XlesspQNiEk4AupJCMFK4+WMlTPM
bBMyNHWu4FbjfkMz3W9Uqe/yWC2aSxoBf5wbDR/uRmWPTCggGtt6i8pHC/UwNJef
I3Eih3Nog+qTbpeePiTYeNfZzL971ndREM/BLrz97+EJ4/hh8EWhGUSSFiMNe5el
G2/hD+0VmBiAx3zlGFN4sz48DYdbhlUM5DSbSypjXQJgPgjmT5nS2+fXQBIFfT6Z
vwT+mRVPZ5sjgX27PpQ0c5CIK0l0gNov5pTGfGeGCHJaVp9ho/mWuNC4qeaEZItn
ACAg2HkGrXBxlRcxXHu3WB3wSx/BBsQ9cXKpoZTvr9fDio250hrznEFeWa7S69dc
20IR6H8XIBdsh4Owhhq0HU1p6tDz/ctH4RLdx5qYr9V0x6qVKD8nz9G0vMSiK21R
qa8ATXNf1K8fjEoyfne/b4ikd/WXAKxXDAujpKZv8CwECXR2YeSuHwoe6032Jkt7
7SJXzWfBBAiseYuNNn6+/8afbJ0gvlN7u9G6qgN/u+BSGj46bG0=
=HpyW
-----END PGP SIGNATURE-----

--7br5xyiczou6vho7--
