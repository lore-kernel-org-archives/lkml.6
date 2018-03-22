Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeCVBic (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:38:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46122 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeCVBia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:38:30 -0400
Date: Thu, 22 Mar 2018 09:38:17 +0800
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20180322013817.GY2186@sirena.org.uk>
References: <20180321133040.6754c372@canb.auug.org.au>
 <20180321024556.GX2186@sirena.org.uk>
 <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kKplKE35C9I8SQOF"
Content-Disposition: inline
In-Reply-To: <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kKplKE35C9I8SQOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2018 at 11:15:16AM +0530, Mukunda,Vijendar wrote:

> There is a patch dependency .
> Below patch not merged yet. We submitted for upstream review.
> [PATCH V2] ASoC: dwc: I2S Controller instance param added

You need to mention dependencies between patches when publishing and I
don't seem to have a copy of that patch, according to the list archives
Alex asked you to make some chnages to it.

--kKplKE35C9I8SQOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqzCQYACgkQJNaLcl1U
h9A/BQf/SsRk7fub/qqkfI0T5kgHQ8aF+hpGsXodUmmoHbm1XYMAh8UY5mQU712q
C51a+sHY0SwkzanhPPQrvYD/+siKpfFAu3/cslPwOdLfDv4A7NqXEXgmloerUb6d
TIT/H7lvY5yTG9Pj2s1HqT0x002wX+taETRk0zRIWE0mMrYO+JGWPcdqJK7fS8Jc
jKsbM78nTDGuxhheIFJmD3jYlBPbGtfqfwdwqNeTTJyoEJQ0Y/FVZ31I5iTuiqdc
5tduJkrYrx09ZT0yvfWcIc4VS2lSEm7Yke3ZARy7ez+nX+Ed0MVFzlzjnRoGduI8
Fo5OvMBbqfx9HiwZrx6hBFB0Q5YyEA==
=iCQm
-----END PGP SIGNATURE-----

--kKplKE35C9I8SQOF--
