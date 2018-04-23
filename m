Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeDWPgn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:36:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbeDWPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:36:36 -0400
Date: Mon, 23 Apr 2018 16:35:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: tas6424: Add support for the standby pin
Message-ID: <20180423153553.GI19834@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-3-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline
In-Reply-To: <1524218684-19752-3-git-send-email-jjhiblot@ti.com>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:04:43PM +0200, Jean-Jacques Hiblot wrote:

> +	- standby-gpio: GPIO used to shut the TAS6424 down.

All GPIO property names are supposed to be called -gpios regardless of
if there can ever be more than one GPIO (though the framework does
support the singular, I wonder if it's not more helpful to just get the
spec relaxed here).

> +		dev_info(dev, "failed to get standvby GPIO: %ld\n",

Typo.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd/VkACgkQJNaLcl1U
h9DvMQf/WlAalw9VVpnJyOR7ezVpFT7BAS/zA4+NemWVT8DS0Juwk3kD/1mFjnFJ
RuJECYe1tPHFv8a2/6rqMrD48zBfXG/YcGpKm0SF05ZA9/f1r8UTNdDJMiM4IHvh
rfCJLGBraGX8TOuEZ2j8mmGBj7ToV3MXQ2Zq1tANd7mZKZ+WH+3nhl37IP7tu0t8
V6qEGKK8Aklh6+fk/zWXwrnVtIJzFqXGUx7GZepahm558nSilomVSJ/+nTN0N8iH
6RsGMJpDtfyf68fL5amN3z+ZHu9/FYCVIKICFoFRHxMqK5U3cc3ucSrCyOHGTNew
rdfB+RVfHbNwCQq8QNeAQU/QYwuN2Q==
=yJSP
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
