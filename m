Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967898AbeBOLVC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:21:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966697AbeBOLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:21:00 -0500
Date: Thu, 15 Feb 2018 11:20:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: ERROR: "sst_context_init"
 [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
Message-ID: <20180215112041.GB8374@sirena.org.uk>
References: <201802150332.ujDzQYVH%fengguang.wu@intel.com>
 <bc8a4057-f666-30a4-9144-3bd01db1b6ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <bc8a4057-f666-30a4-9144-3bd01db1b6ba@linux.intel.com>
X-Cookie: Stay on the trail.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 03:41:22PM -0600, Pierre-Louis Bossart wrote:
> On 02/14/2018 01:23 PM, kbuild test robot wrote:

> This was reported by Arnd Bergman and fixed with a patch sent on January 24
> to alsa-devel ("ASoC: Intel: atom: fix ACPI/PCI Kconfig"), but I don't see
> it in Mark's tree?

> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130979.html

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, though there are some other maintainers who like them - if in
doubt look at how patches for the subsystem are normally handled.

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFbQkACgkQJNaLcl1U
h9D+dQf/fdRb7YTitoXBQMjfPlJQgjDSiNoD2UzRmzmAp4S/m7k8MHk2ug+A+u0J
z9gzLeul9z31++q3XR0qakORG1IPze575xltCg0FSEfLUA8vMCNVclDxJOMdfC3O
QDpZrwntL0PVPKYUlsrTGey5MyE1L+MXtd2YJ29ZPD1BGzqAatXeLcGVQsb+Z6jQ
RrGBKLLvRDj7MyrRJ+Pt/X1iZy7TDBmyxG1XTV5/0fZHhvGFT2jUBTp3yJA1W50i
w+NLPu9tdG+rQvrbYk8rfMo9NJwzxqXWWiJ33rcekHOgrow3ca2LsiwO5yO/90OP
gbAWTlH53QiwD2S8XDeaybVvMxi4Zw==
=StDF
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
