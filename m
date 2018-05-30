Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeE3Odx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:33:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbeE3Odp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:33:45 -0400
Date: Wed, 30 May 2018 15:33:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>
Subject: Re: Regression in Linux next again
Message-ID: <20180530143338.GM6920@sirena.org.uk>
References: <20180529221501.GJ5702@atomide.com>
 <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
 <20180530091314.GB6920@sirena.org.uk>
 <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline
In-Reply-To: <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 04:03:15PM +0200, Maciej Purski wrote:

> I'm afraid, I have no idea, how to fix it quickly. You can revert it and
> in the next version I'll fix the build error and split the last patch even
> more, so we could perform a more precise bisection. I'd be grateful if you
> could push it on your test coupled branch and Tony could test it again before
> merging it with next again.

Yeah, if we could get testing from Tony first that'd be ideal.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOtkEACgkQJNaLcl1U
h9DnRwf8DySBfS9D6jyXQbl8EQS2V1CxEV3vC6Jw50bQuwPr8gCNYFDQeglCijgY
K7/mSBPFvrnfYmS+PfNs7M9/4yNlMOM18Qw/LolQl4a4fxR4vYa2cFR19veO95FP
2ympwvGNKYwmm38tzh/phcCJZVR3P6ruXb1bTxs/WZZPkglxJDZsMb+VDENUJslZ
YT1Pt3Nm1ykaTfY6Md6uHDuPO26BVw9v30bX2X2M5WRH5iCAngV5Z3ssbXfxuLfe
svyTfppH14Mlq3yOCwJt2A33ONCT0IC2M4q8B/MB3t6n/ZeZfZ+BLVkIlqwqycso
Ne0Ka6pSH+bJavrO/1Zyv0su04cERg==
=9SQ4
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--
