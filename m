Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeEOH20 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:28:26 -0400
Received: from sauhun.de ([88.99.104.3]:60796 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752321AbeEOH2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:28:25 -0400
Date: Tue, 15 May 2018 09:28:23 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: viperboard: return message count on master_xfer
 success
Message-ID: <20180515072823.kqjzlqqy3gwipxmm@ninjato>
References: <20180509194748.29222-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rjce4wpc4toapdwe"
Content-Disposition: inline
In-Reply-To: <20180509194748.29222-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rjce4wpc4toapdwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:47:48PM +0200, Peter Rosin wrote:
> Returning zero is wrong in this case.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


--rjce4wpc4toapdwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6jBcACgkQFA3kzBSg
KbYgTxAArCi8vgmnWCZyIbL5krPpBNcyQI2Ignw9zZ7ZU84G6fiaZBG1QaqCQCkU
YhoY8XPdtX+fum8T03Ni6sXUDCm3h+XSok3h7s+nM5EC6LEH4H2Mewh4iMip467H
ES0Jmo6fihxgPpljep6SX9pP3AiuiTpWi8uiO+naYmOnNCk72xXUVCuOS6TdFiU0
xp6vK/lwJee1e+bFLd9wkfrtA8Ie2BDFKjQfbBJTslct3aZ1RhTAZPYYVtEju+e1
YArTJImc2LkOMM339Lt3wilm/qW4bYGaXccO674eCGY1A4aOT0bhye7oPTBoCSQM
wHJu5kXonnx46z+qOC1Qsvzg+WBHXAuJsL29VK0sGrBXHGI15bSgQmyUvbwo8/+N
gUZoBRe0oCzivmR1gCTtK6N+bzek8tHqxGMvDdQhVNgvZGsVEqhKwhxl7OAsA56V
nnIMZTZsV8CZSDxDDqpuXKRkGUuYOucnXtjiSsp4FmoQrNqC4UO0HOk68zceAq6H
nmBJ42auDqx3DVw1u3U+jroHiPlx1PDBzYwjjb8FAvXu8QOuobcjUPlhZYGPpN9X
WSttMsGVFQjVJM3GrZ3pP7LGUeupOFE0ZiUPA7tAvRCh5Sa33aS+n4QOg+is905n
jcp3UGK2TuUdaSrdE71JFY57TX8W3roYQRAzZ05JymelrrnUsnQ=
=KD85
-----END PGP SIGNATURE-----

--rjce4wpc4toapdwe--
