Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeDPLfo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:35:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50944 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753597AbeDPLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:35:43 -0400
Date: Mon, 16 Apr 2018 12:35:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Message-ID: <20180416113535.GA20726@sirena.org.uk>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
 <20180412211437.21599-4-peda@axentia.se>
 <20180413111927.GC6854@sirena.org.uk>
 <20180415073229.GA19823@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20180415073229.GA19823@infradead.org>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 15, 2018 at 12:32:29AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 13, 2018 at 12:19:27PM +0100, Mark Brown wrote:
> > On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:

> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > >  /*
> > >   * Driver for the MAX9860 Mono Audio Voice Codec
> > >   *

> > Please don't mix C and C++ comments like this - it looks unintentional
> > and messy.  Just convert the entire comment block to C++ so it's
> > consistent with itself.

> NAK - that is exactky the wrong way to go.  Normal Linux comments are
> classi C-style comments and should remain so.  SPDX tags use c++
> comments exactly to be different and stick out.

During some of the discussions of the SPDX stuff Linus was expressing a
willingness or desire to just use C++ comments where sensible outside of
the SPDX headers, especially with single line stuff though this seems
like another useful exception.

Quite why we'd particularly need to have the SPDX stuff sticking out
isn't really obvious either; there's the desire to have something very
consistent to ease machine parsing but it's not exactly what I'd expect
most humans to be first looking for when they open a source file.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrUioYACgkQJNaLcl1U
h9BTdQf/QYqLAfdAtU8bXP+DPcVKjQYEcO/chVZFNnE8MPFx/fV5q+CLmBVrnThw
cWEYy7RUuTY80WVV0+4Xp3Cq9jJDh4Rv19rRSfKRWpblz4r3Cky3L7Y+Wz1rrGAo
V0lWa3ZWMvdQFxqz/pMLYGceSbcIsH3BuIZdEmf0amvT5vsLaqaG+34gihm+COYG
FFweBKlPc7pSa9LestNvJQx2uXLlbzVh4j4W2IK4JfPA5Rx9tgrge1lOr9/Xf2hm
XyiKUSHtu5aL47C9AiLvNf2i5BRhMF5CGt2AyiW04B3+LpwIBjhyPqZjCZLdc/zO
4Xp/0N15oXQN4GsMt6m/hexrX/mdVg==
=Zyh3
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
