Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeCGQ5p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:57:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35522 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeCGQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:57:42 -0500
Date: Wed, 7 Mar 2018 16:57:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180307165738.GK7290@sirena.org.uk>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
 <20180307102006.GA7290@sirena.org.uk>
 <5A9FC3E0.5020600@rock-chips.com>
 <20180307105731.GB7290@sirena.org.uk>
 <20180307165405.ltuobrr53vko4do7@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FM4RQAc0jwHekq5"
Content-Disposition: inline
In-Reply-To: <20180307165405.ltuobrr53vko4do7@dell>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0FM4RQAc0jwHekq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2018 at 04:54:05PM +0000, Lee Jones wrote:
> On Wed, 07 Mar 2018, Mark Brown wrote:
> > On Wed, Mar 07, 2018 at 06:50:08PM +0800, JeffyChen wrote:

> > Yes, like I say I think that's a good idea anyway - that sort of usage
> > is the reason we've got the facility to set an explicit name.

> Is that an Ack?

No, it looked like the change was only for MFD?

--0FM4RQAc0jwHekq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqgGgEACgkQJNaLcl1U
h9CoKQf+Lrm8JVJBDZdK+SeS648s4w/sUGqFWjF00CF6lP/Vljah1B9QVPbXrWhZ
EEyyFt+yJAQKG76XuIuomVEKMzILJ6qtvHvHhAZJUrQpdrn934mFnPE/ck6b2fEB
jtugbzcKHfQu40/zI1JcUv7IwpknsWzoVUQpZjbkvruDEvMm+OLGnu8V29N5Fdik
rv7HDSmWnqVg7iRJp8CmVFJ7gCmCv+loKF+cpcRBbAcQJmGDvXrm2F2vML9R+k3Y
c+yWl3YgAfh+ddy71mpYN5lHLZ9mK3BRiiiqHISpv0lO0JnFIQRE1u9vWMqxq7N1
mhQnu9wAeojxfDyjIybRlSErinpJwg==
=eFp7
-----END PGP SIGNATURE-----

--0FM4RQAc0jwHekq5--
