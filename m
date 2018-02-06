Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeBFMIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:08:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBFMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:08:33 -0500
Date: Tue, 6 Feb 2018 12:08:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: clabbe.montjoie@gmail.com, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Sean Paul <seanpaul@chromium.org>, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 03/20] kconfig: Remove leftover references to AVR32
 symbol
Message-ID: <20180206120825.GF5681@sirena.org.uk>
References: <20180205081151.GA11907@Red>
 <20180205190552.14282-1-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <20180205190552.14282-1-ulfalizer@gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2018 at 08:05:39PM +0100, Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture"). Remove the remaining references to it
> from the Kconfig files.

>  drivers/spi/Kconfig           | 2 +-
>  drivers/video/console/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

It'd probably be easier to just submit these as separate patches to the
individual subsystems, that'd make it more likely that reviewers will
see them.  As I've no context for this I can't tell if there's any
dependencies, I'm guessing not but just in case

Acked-by: Mark Brown <broonie@kernel.org>

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5mrgACgkQJNaLcl1U
h9CxMgf+JGurc+K5jhMMPpAoGyGrZ2TugIAbUw6WrjvHDaaxifeQLKh2i8ujLw3+
OKgl0XJ1ytpqMPkVVCH9WGZF/BSl8tQKtbVvmF2jSBMmFTlk1mevQcoqrgJb4NTf
U3m2JAQoWqcPsI4lVF146SNy+AP8N042uQgpXIq9sREp1qHAnzSiD22+WD8LtWVW
yfIHX5p6Pkdh5odO7hezLjHv2VlMcqSfla7q4Lzm2vAb01OhySdi1Uep6TnahHRX
fY/lVkeqRjOcKOoacLIgNSxDZ2K1Vgc55krRxXZbB2gAySlFSIksnPSdtE9nH/xm
yluMHQbeE2ORH3Yhhu7cSOqFwUBAdw==
=rUEE
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
