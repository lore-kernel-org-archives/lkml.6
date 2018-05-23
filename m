Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933208AbeEWN4Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:56:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42342 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932900AbeEWN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:56:20 -0400
Date: Wed, 23 May 2018 14:56:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Guenter Roeck <groeck@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>,
        Chintan Patel <chintan.m.patel@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180523135609.GK4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline
In-Reply-To: <s5hmuwqpjdd.wl-tiwai@suse.de>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJAclU0AInkryoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 03:54:54PM +0200, Takashi Iwai wrote:

> And I'm wondering whether we should move these definitions to uapi
> headers.

Yes, we should.

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFcvgACgkQJNaLcl1U
h9DoKAf/USPmjJ56h/dkk2Lo8ldpcGetP2ZQMIa3AcdlOdduDJK/gi4NSf+cF5eo
n0H1IdBK9pwF2PVjCtGnXm+DivEvhD4IH6nKG0e94OKSAvP+S2vqT3LJSIX5+h59
G7D17OtHQABd4VOMCGIGMx1PZRvKO9Kui3YUWr+uCMUreNlAvJ+W+bnmO10l3oWm
NoPQDAWPkpDinukGVO3fZueTF/QI2o4lowMf0UgPdshsXNDv3xk4VpH7l+nMG4H3
pWRQF8nnqVz++h0Ckwns7Zs2mct8w9CICK6Fu4APfU4uhCCPBEzQACE1+39na6+e
lJd6E5HsJhDqOt2sGKQy4UrsTZ4J1w==
=dMFf
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--
