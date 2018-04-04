Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDDKnO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:43:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48196 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:43:13 -0400
Date: Wed, 4 Apr 2018 11:42:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sergey Suloev <ssuloev@orpaltech.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
Message-ID: <20180404104252.GC7691@sirena.org.uk>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
 <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
 <20180404070817.6cens44jvlmdaxtm@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20180404070817.6cens44jvlmdaxtm@flea>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2018 at 09:08:18AM +0200, Maxime Ripard wrote:

> And I'm pretty sure that papering over an error returned by a driver
> is not the right thing to do.

We've got specific error handling for timeouts - they get accounted for
separately in the stats.  It *shouldn't* affect actual operation and
AFAICT it doesn't.  I think the main problem here is that the commit
message is very unclear.

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrErCsACgkQJNaLcl1U
h9C5Vgf+OToh7RTZkBZDR/42P3i4DVvulaQv12xyeiY8y0/cVS2T5BnlWo4H0xZ5
0NLmSRjaEJcf2hLnQE8vyOtDKHPYa/nfwdPmadimsvIHlKQ3Vumzw+8LP1WLgRxp
GmIhOosBUZ2BuCaGeidlXu6fjT3Ngh34IHg4WOH3gx7++oclzzZQG3Ka0JCA/4fL
U+tG+EUVbABd0UHznYj/j/5nuIW0Uga2ChsgpLPdZYU4vF0F1RPrHC79PfAdlQxZ
T8LQQaCdUTYKvz/H0Os+fQygFssielvdpyGWppvE98o/BHmtdMWkbcoQqIVzMWw2
phnrI7nVJuAMpegLx/Bb0IouNVpNAg==
=n2XR
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
