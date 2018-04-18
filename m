Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeDRLZ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:25:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39824 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDRLZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:25:25 -0400
Date: Wed, 18 Apr 2018 12:24:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance param added
Message-ID: <20180418112442.GB10061@sirena.org.uk>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2018 at 04:34:52PM +0530, Vijendar Mukunda wrote:
> When multiple I2S controller instances created,
> i2s_instance parameter refers to i2s controller instance value.

You're missing the point here a bit - it's not just the defines for the
magic numbers that are the problem, it's the whole idea of passing
instance numbers around like this that's the big problem.  Whatever you
are trying to do here is most likely better accomplished at the machine
driver level.  If I'm missing something here and this is a useful
concept to have in the driver it really needs to be articulated much
more clearly than in your very brief changelog, and most likely done at
the subsystem level (though the fact that we've managed to get this far
without needing it is a bit of a red flag).

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXKvoACgkQJNaLcl1U
h9A0TQgAgCxN6Hh4RzagIfL5GE3Aq/Ea1B+j/UiKbKEz9jfK8rcpFzB2YBM+ibsV
UCFEAWpA+b+cAXT4itIdy8OfLq0lqvqLLVPUzke8q5yzCCbjdBDRZNeLXmFEiPvv
UIqP6YAMUjrsTtdQ0MkH+30XcB+k+CoWusfRI5NMI505sUrTydJUVF3g3mBy9NMa
L2dvwddgX3nGsIRMl0DiBTGcW3qOp296ArLpUQILB3irMXqAB0P6+irr9fFhcRCe
bkaG2gBEqFY+fJkV31ONqUlq3BegNps2xyJ1rwkUoKSwHscATrswgbPNwQgJPGbv
DkuDztSNOh6C2BF+UJ7cy47hAwg26g==
=UssD
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
