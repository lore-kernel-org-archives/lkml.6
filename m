Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeDKVNo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:13:44 -0400
Received: from sauhun.de ([88.99.104.3]:56778 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754904AbeDKVN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:13:28 -0400
Date: Wed, 11 Apr 2018 23:13:26 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: remove me as maintainer for I2C host
 drivers
Message-ID: <20180411211326.hudtgm2ldd2fnptm@ninjato>
References: <20180410194914.7268-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhzmdsafba5t3hyz"
Content-Disposition: inline
In-Reply-To: <20180410194914.7268-1-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rhzmdsafba5t3hyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 09:49:13PM +0200, Wolfram Sang wrote:
> The number of I2C host controller drivers keeps increasing, and although
> I had some success acquiring specific driver maintainers, my bandwidth
> is by far not enough to act as a fallback for the rest of the drivers.
> To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
> host drivers, let the I2C list (=3D community) be the contact point, and
> mark this section as "Odd fixes".
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current, thanks!


--rhzmdsafba5t3hyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrOenYACgkQFA3kzBSg
Kbb+vw//ZrPOcCY4PsuF3rUnGZ27PrMGjCGyVAf7O1Y18Jgsgc+AyUiflyqKFdDP
w5ui5aELcgQN5XpemQnqaSKFlDduLyywm7ZwjH78YA2rjhVmA1j8tIPoFMwSnzjG
mQSeYZGCBO1lwt79QHXvnh+v7h8DkknL4vJEI5qgkPHL03ESR5sHg6D5NFLIi6Vi
GI7Xpr9Tx5ZFj99jee6iRycM/P8i5B66AxtsjBPnsOt/ilpS04sBldP/PNXFpQ2r
lmqyAIoh9FuE5aip1+m1RhCwQSKin/0BnwjvPH0QWSOWES5O2yVZY15vwmz1GrpK
hm8+AJLFe4rLx/qZDSAB6pIg5vXRPC9ugk2lrDv4dzMpn7WNc7T32GwlH9AhlSBo
TItEFAJtnaoPeQSaypDBWX8SvTTIN0/vwacDlEJNDOcQPdPS5fTuK7jm25BmuLSn
sjhJD9GYb0X3zr9RdXO2w2XPKKhr0+Z6iwzAWnxo/RPES1PE2JMgiR8YAj8Q4+nI
M52g2Wg9d6tQE+qUjw3/X42XwcVK2KZTJRnYveT9Z3TvIBXZJiajbYGKunKNOybc
bUA+aj53z7BX0eo17vEwCy2mfpl164Tp8HE3DZq/pJ7Fe1lfrwEEXqsZpMRIKMo+
K7X5QZAu4ZWcwFPwX9Ev+2ORxyTaeeTXSIHrW13JiOsba399Z7I=
=jIMJ
-----END PGP SIGNATURE-----

--rhzmdsafba5t3hyz--
