Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeBUMOG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:14:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933529AbeBUMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:14:04 -0500
Date: Wed, 21 Feb 2018 12:13:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623
 codec
Message-ID: <20180221121354.GG8334@sirena.org.uk>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Content-Disposition: inline
In-Reply-To: <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
X-Cookie: Condense soup, not books!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:

> +Optional properties:
> +- VCCA-supply : regulator phandle for the VCCA supply
> +- VCCP1-supply: regulator phandle for the VCCP1 supply
> +- VCCP2-supply: regulator phandle for the VCCP2 supply

These should be documented as mandatory unless the device genuinely
operates without power which seems unlikely.

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNYoEACgkQJNaLcl1U
h9A53Qf/WmJ8q4PvAqNeknQqNme9JDwOBoQujRRtz76hfLuFEw4mUHLzudT9RE9p
hOHPYtcBlcMgPGKRkW5E5OUxleVhjaTxrpBaHTRTEkbEdAfycje6RtqjqQ2sezfi
xyzMBu0cf1ynMV5zIVqOSlsPVGX6Ih0Ypx4JsHSQ2np9u4CqSzVYIcuUpgHEtaiN
9u+xVjnmr1NomCYFrpZWbtruqQMpsj0bYSPsU33fgy+fiVMaRn3qNRpEXgiOfJtJ
R+KmdvUs6/VfhGY1oQS2E/JF46ldohQGCLlgGkvwfsT4OLO8BwL/UZ0hVcG/Q0Qv
QYicnuQjfzlC7HjlbtZ6/lAfYZ5oYQ==
=5fLQ
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
