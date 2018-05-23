Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeEWLuU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:50:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeEWLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:50:16 -0400
Date: Wed, 23 May 2018 12:50:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/6] mfd: da9063: Replace model with type
Message-ID: <20180523115012.GG4828@sirena.org.uk>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-2-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <20180523114230.10109-2-marek.vasut+renesas@gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 01:42:26PM +0200, Marek Vasut wrote:
> The model number stored in the struct da9063 is the same for all
> variants of the da9063 since it is the chip ID, which is always
> the same. Replace that with a separate identifier instead, which

Acked-by: Mark Brown <broonie@kernel.org>

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFVXQACgkQJNaLcl1U
h9BSAggAhweERD6NMxyF/EC1YhWeLIdRUk8Ouc28pLB3wQYRZMLbIQIAJd+5O+aV
YP4QzfakUlmTF+N/gCQGefRY7D9Iut2LiuaJKIcaDOdg9XC0TpqHJmda7I3nLDkz
Vrv/nia9wJBYckh6Ir8p3PPDWr9siwncu1v7XNm9NC55Fe/Q7bFVS0A9Zvdai8X5
W+EAXZjJ/SJzHf8HYy0NxEyo15lziW/mFORq3mNXCM0MHsatnGWZp/U5fX24Kx0e
YaCPj/UuGvJE6ZE8qtG77mvM2gOmF2wF1aWJyJMEasvQFBohs7O56iVfTAaWNtUM
f/iGrBPWPkp6VxUDJYHSr3L79R6maw==
=ySq4
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
