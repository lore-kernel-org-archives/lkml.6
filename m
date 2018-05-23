Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeEWLuq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:50:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeEWLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:50:45 -0400
Date: Wed, 23 May 2018 12:50:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/6] mfd: da9063: Handle less LDOs on DA9063L
Message-ID: <20180523115034.GH4828@sirena.org.uk>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-5-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Content-Disposition: inline
In-Reply-To: <20180523114230.10109-5-marek.vasut+renesas@gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 01:42:29PM +0200, Marek Vasut wrote:
> Move the LDOs present only on DA9063 at the end of the list, so that
> the DA9063L can simply indicate less LDOs and still share the list of
> regulators with DA9063.

Acked-by: Mark Brown <broonie@kernel.org>

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFVYkACgkQJNaLcl1U
h9DvKwf+L02I5L/MtRcF2N1oghs8X0tmTrzSx3W1Znoo+grXpy/PYPk3r1+nYC68
QpUvJ7cV6D+TD1kE9sDUaRoSIVkM5puGuO8cnCnNwZL4vKg7d85xJ9yjM4/3HpL0
XJRiVKG2Yhyj1BKElcF9w8ITXRRlo8aEzyGx09zsVDubT2gU1wi3RHIkcrqWNnar
di9LHzfLlVd2qbLhRnyThhbZfh9KRH06929l5uHzmTk6SrQzdP8vD2/kkRa72oo/
AcrMYfl/I4cEwpPoc8Ffkd9ZMZ5WbVz8EQf85nzn5LyKKGv/Wh1cOIEU2HRpe+kT
fZqeDTqH2vkz9GEtvB8ZafM3R2hYDg==
=I+6b
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--
