Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932713AbeEWLt6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:49:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeEWLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:49:57 -0400
Date: Wed, 23 May 2018 12:49:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/6] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Message-ID: <20180523114952.GF4828@sirena.org.uk>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 01:42:25PM +0200, Marek Vasut wrote:
> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
> DA9063 chip ID register, so rename it as such. It is also the value
> of chip ID register of DA9063L though, so drop the enum as all the

Acked-by: Mark Brown <broonie@kernel.org>

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFVWAACgkQJNaLcl1U
h9AsYgf+KDlReTOZjH1w6DAx9HPYN1ofo5xNWK49+LubVw+9Ap+MEfg5XkZH+GTD
pVzoN45/myCd+UXwNoQF/MDTpEoItXldjyTcDWZQ5n1mHED6R0bHiuEqkqnqzna4
E6Qm+llhf/gUHAYBgU/ZBJEG9ujeTnuWCrs7Lr7gdlMpy/Fz8HXE0bvRNa4WWkDj
nYGFlA6i4CFzKzdMlII+IVd9Rjhaxdwtfx3vEYSWOYV1s7PhDSfDZMThA6UK8Zj7
+hKrNVU+AbQI7koNuJacVQKY6Mv4lOIEjM+WkRJS1SXE4AgXBLmmetF0f9EVIMGO
IqonHNZ+ETnafKHmPXNyFdicW6gpoQ==
=5OuJ
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
