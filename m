Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeEQQpA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:45:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeEQQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:54 -0400
Date: Thu, 17 May 2018 13:33:02 +0900
From: Mark Brown <broonie@kernel.org>
To: James Kelly <jamespeterkelly@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: regmap: Skip clk_put for attached clocks when
 freeing context
Message-ID: <20180517043302.GB20254@sirena.org.uk>
References: <20180515005958.46971-1-jamespeterkelly@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20180515005958.46971-1-jamespeterkelly@gmail.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2018 at 10:59:58AM +1000, James Kelly wrote:
> Capability to attach an existing clk to a MMIO regmap was
> introduced in 4.17rc1.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9Bf0ACgkQJNaLcl1U
h9CjJwf8Dqns7kJKFgX/rMPWk0GMWhs+bOU6ZyCZrYVTX3+O+oEpQl8auPkhynCa
n7AgeqcsMdXe44FElQqZYfBQcmWSiyj3jBfLewxbNY1hBS3J0JKnDkDVNQSVohHT
l7aXdsRKyzLlLYIvhiM2wrlT7sFfngCrgAfmF/lcqh7NLNMKcDjCNI4SJs3pxFcC
h+oL99LYtkYIyWzcc1ZQMK05F61FxNhfM1SWqkJyBQdubzwBBBaYIkYVEuIRlBZv
QM9aBf1mmfYsYVbmOtdWS64TTaw4flNHvkV4Fbs2iBld5kdxynvmF/C5QCHDODz4
EnVjwbaJ2q/jujtjqNp606brsaF3Kg==
=uIra
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
