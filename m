Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeCNJax (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:30:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46213 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeCNJav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:30:51 -0400
Date: Wed, 14 Mar 2018 10:30:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/sun4i: move rgb mode_valid from connector to
 encoder
Message-ID: <20180314093050.aimmdpx4heghuf74@flea>
References: <1520941017-81177-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ficsuhinqjbjo3zk"
Content-Disposition: inline
In-Reply-To: <1520941017-81177-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ficsuhinqjbjo3zk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 12:36:57PM +0100, Giulio Benetti wrote:
> mode_valid function must be connected to encoder.
> Otherwise it could get not be called by drm in the case there's a
> bridge connected to encoder instead of a panel.
>=20
> Move mode_valid function pointer to encoder helper functions,
> changing its prototype according to encoder helper function pointer.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime


--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ficsuhinqjbjo3zk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqo68kACgkQ0rTAlCFN
r3SHVxAAg9NP7usmW/skjqXTwMHOpU5M5nASxXGk52GAt/Q5TGaHPCcrygjiQraO
3BnAhj4aHvg36DfB4typqyjVckcZ8D0n9JgXmhAOYe7qhWkRVwkBNd++gbCW2TM7
1EfqCwWczlp425Z+/gmm7UAEERL33d3c0Y51ULTNOqz8X/Vtow6NJza4JZe2tthV
U1rSM2hmzmcLQoxUtXfh5Rnyr2/XELxTQHjlVJecsWpGEbSgqea7dw3XxXL2NaL/
PLQZO03w7Rw0qzVtGXeTKwp7Vrhj+8d3AQ1gfc/gPolQMzCvPH3jOLWS4Tk3lElF
j5T+ceYr6H9XdHcnox8zy4ihZSLSAuTfSYD++pPIuSxUtzrYSpUXVcY1U4x3bnl6
T1yEKcLBo6vkEK+H+ecV2nBbkKVEau1Rvgd1iJtBATwMSUXN8kN6nMoNMA6tOkyu
1JteQ+zYR1bQPV43XI8OjxqPwFsK3g7EyuS4RlKCvJiCDogQuWAzNp0u9HGCVEjs
7nRTsfzLzCxkEl8sUxjBkRIiWCoOmSDfFjiMFmdhfEygGtyLI3Wc8RkrMTtINygk
gtoFPsw+IUHOJa6K+6io79b7tn3EAbfWAVQiH49NiMkqwWstF36HlPnXZDLkLCba
4ghcspjND791rP9uh7XcBpJW+X/CoPdY3Z3dBCFqBEAoaJ2oqI8=
=WR6Y
-----END PGP SIGNATURE-----

--ficsuhinqjbjo3zk--
