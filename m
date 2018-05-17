Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeEQQq5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:46:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59104 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeEQQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:59 -0400
Date: Thu, 17 May 2018 16:07:43 +0900
From: Mark Brown <broonie@kernel.org>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] spi: sun6i: handle chip select polarity flag
Message-ID: <20180517070743.GQ20254@sirena.org.uk>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-3-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tk6xM/wkRlnXD2NA"
Content-Disposition: inline
In-Reply-To: <20180330125047.13936-3-ssuloev@orpaltech.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tk6xM/wkRlnXD2NA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 30, 2018 at 03:50:43PM +0300, Sergey Suloev wrote:
> The chip select polarity flag is declared as supported
> but is not handled in the code.

This is more of a fix and should really have come before the cosmetic
changes in patch 1.  In general it's best to put fixes fist in a series
unless there's a strong reason to do something else, that makes it
easier to get the fixes in without them getting caught by review issues
with other code.

--tk6xM/wkRlnXD2NA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9Kj8ACgkQJNaLcl1U
h9A26gf+Ni1rK72Q4vG/YsD2GxlnBDcJ71rRbsMeMC0XFmNsNTRHDvYaG8BJHYm8
yiS8hjSWbLb+Zq8OQtjdioXtPwmvvzvogGUemf7MWDjnifqinHTnkkXJMEW80zW8
qpJNZ1UtvW65pHQ13PZyySvv3DOaHImMONfS9D1RhQdmEhsxvu8yg551rjLuoiVG
5KhNlln0pBhkNPKlACaj41eJhXNYSBnC0urYMzXwe6IeoQylgMK+AIOa5Y1YPZxu
4B4n94KPlsigjdn2SHk/QO9fBtmCUidaeWc5QGEDKCwuadNSKGtcYmGGbBNKZzIL
QQV+4j9B6GKpLKitaCon9hIP3cPf/A==
=7uPr
-----END PGP SIGNATURE-----

--tk6xM/wkRlnXD2NA--
