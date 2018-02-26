Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeBZNM2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:12:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeBZNMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:12:24 -0500
Date: Mon, 26 Feb 2018 13:12:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 01/10] regmap: mmio: Add function to attach a clock
Message-ID: <20180226131207.GB6681@sirena.org.uk>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
X-Cookie: Do not remove tag under penalty of law.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:20:25AM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> regmap_init_mmio_clk allows to specify a clock that needs to be enabled
> while accessing the registers.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/m=
mio-clk-config

for you to fetch changes up to 31895662f9ba81e8ea9ef05abf8edcb29d4b9c18:

  regmap: mmio: Add function to attach a clock (2018-02-26 11:05:44 +0000)

----------------------------------------------------------------
regmap: MMIO regmap clock configuration

This patch provides a mechanism for specifying a different clock to be
used with the regmap clock integration.

----------------------------------------------------------------
Maxime Ripard (1):
      regmap: mmio: Add function to attach a clock

 drivers/base/regmap/regmap-mmio.c | 24 ++++++++++++++++++++++++
 include/linux/regmap.h            |  3 +++
 2 files changed, 27 insertions(+)

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqUB6YACgkQJNaLcl1U
h9Cikwf+PMimnrn6dNczsXsvqRvm5hhO/h8dL0IBFzkQtwmA/qj6bHgIcu99EHNg
rvyz+J6fGket2zqJGO1LX6sbUa9v0FoedKk1VqesmaSzIr/Z3QB6kmPXArGIr7T+
u0dEmntyUh6CLNyjEyQJMuQEKWSoxjQnb8LbWpdydUynzUlJR6eSzM9vInxxmRqt
McyD/wqJLNVBuc8Z8Xzlpqrx/IEKVUQsznUV8hAPW/GHq/H2ziCE8OFofVaRCqPW
OjRpcs7suLWn1ky3iieLkGg/iJvbRGsI5xrRgs9MxqRr6HETVghViFGwYKd9Uyw7
DagDsMXB9k5bWNsgDA5Oa1+xTIMUXw==
=DRh6
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
