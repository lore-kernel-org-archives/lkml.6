Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932804AbeEWLu6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:50:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57744 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeEWLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:50:54 -0400
Date: Wed, 23 May 2018 12:50:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
Message-ID: <20180523115051.GI4828@sirena.org.uk>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline
In-Reply-To: <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 01:42:30PM +0200, Marek Vasut wrote:
> Add support for DA9063L, which is a reduced variant of the DA9063
> with less regulators and without RTC.

Acked-by: Mark Brown <broonie@kernel.org>

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFVZoACgkQJNaLcl1U
h9AmXgf/ZYllH7qLXw6KPctVed/ktpOpCVUDgGtvHLGo15jGcBOaZ1EFvO/bf8cZ
JLhk+dX3yxtQsOANCr02T+A4MEiaGqvwmaUHWdf0qPqSP0aYNz7Mz5A0GfsCT9Wq
PwZHrNhtmZDsGAG0CzW07C4mbjkED9GFJTKMdIU7QMuW08/sb3E9IzlrCbaYWZxq
rm0igI81ieLf2+NLQeo5wDanmzpAgUaszuSFyf6/C8u4FPc0wbb3VD/5EhbTnGb5
GLhR5Plwj/qhWH2wqA+ChFJZzx9Qm30J7Kqo0lswu2AvvDJJCK49by6qxsFTB+3J
MFYYAsxx6nDcUskQlBmzbbudqRbTWA==
=XT38
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--
