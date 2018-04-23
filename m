Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeDWP2j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:28:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755498AbeDWP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:28:38 -0400
Date: Mon, 23 Apr 2018 16:28:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 13/18 v2] regulator: wm8994: Pass descriptor instead of
 GPIO number
Message-ID: <20180423152835.GG19834@sirena.org.uk>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
 <20180422230742.3729-13-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <20180422230742.3729-13-linus.walleij@linaro.org>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2018 at 01:07:37AM +0200, Linus Walleij wrote:
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up from the device tree node or the board file
> decriptor table for the regulator.

This doesn't apply against current code, please check and resend.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd+6IACgkQJNaLcl1U
h9AGkAf9EaxjU1WJJls7JRqeuaohUyxUarN2bTWWM5wo4wfc14FQ0YPMHkDUk5cA
o6kkrE2Y2s5tMrc5h7Odbaa5p23XXAqWi1Xbque519Pp+lO1DSJPEmZ6n2Q4VqT8
24KCrhU2f9uYiBjsad7JoG3EOJL8JSqoHYW8b4dv/zkRQWh7cN8mCmTUIty332Qk
Igua4diXTb1TaUeh3QheapmDdV4BCgI5vVpNsTB3t7pBoJOgn0ImGkY50naRtEQM
laVNIVSKyABMItf8jT5sfhxMfzpX5GiFc5e+zZZp8b//HyGDXiDUaKo+rPEz+cRR
XmIVN0ONODWFJRbisLFqGRlMHb43Mg==
=aGb5
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
