Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970282AbeEXOB2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:01:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39308 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965515AbeEXOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:01:24 -0400
Date: Thu, 24 May 2018 15:01:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180524140118.GS4828@sirena.org.uk>
References: <20180524055752.GE4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jesV4P1FjH8FXPjZ"
Content-Disposition: inline
In-Reply-To: <20180524055752.GE4249@localhost.localdomain>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jesV4P1FjH8FXPjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 08:57:52AM +0300, Matti Vaittinen wrote:

> +Required properties:
> + - compatible: should be "rohm,bd71837-pmic".
> + - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"

The MFD is for a single device, there should be no need for compatibles
on subfunctions.

--jesV4P1FjH8FXPjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsGxa0ACgkQJNaLcl1U
h9DzoAf/YtDROa5spIF4Aj92gogq2LCWJvmR0STB4Nbei4Mqbb/m5Q6Vrl4/hDn3
TKFumDLaK0XXUC7ggXNcv7r+1hXo72SGzpUwbN9sYkc8VDIlyimdLUHVpV/GHuuI
kQMBIeRe9KWnmJERhAolLDxtSoQFh4ma1kZCdWpjepBsRaS6tSznzrZhGlaEC0tG
2E8rm711TIk6WDcTEsggTCIYzbQVKlT9C6RyKCcQ5YRZ+GvkVhE1mpTaVtYrkD+P
COUMKzGV/J3wOotvDdBKIShCZ562dK4rpchUKTAWDP2YMowy0DAJFykU4SzPQC2i
b5Mo5ola3dgBXm6kiCgrMd8BWrx/og==
=IokF
-----END PGP SIGNATURE-----

--jesV4P1FjH8FXPjZ--
