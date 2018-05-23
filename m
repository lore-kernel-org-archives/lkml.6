Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeEWP6V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:58:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49432 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeEWP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:58:20 -0400
Date: Wed, 23 May 2018 16:58:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180523155811.GO4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DITGHUV3p5DjDsXt"
Content-Disposition: inline
In-Reply-To: <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DITGHUV3p5DjDsXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 08:54:18AM -0700, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 23, 2018 at 03:54:54PM +0200, Takashi Iwai wrote:

> > > And I'm wondering whether we should move these definitions to uapi
> > > headers.

> > Yes, we should.

> Are you sure ? They used to be in
>  sound/soc/intel/skylake/skl-tplg-interface.h.
> I took my clue from sound/soc/soc-topology.c, where the v4 structures are
> also
> declared locally and not in the uapi files.

I'm saying we should move them there.  They're clearly part of the
userspace ABI and therefore belong in uapi, it was a mistake to let them
be elsewhere.

--DITGHUV3p5DjDsXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFj5MACgkQJNaLcl1U
h9A0bAf9EMfDKlkBtgCzOARzcE+FvBVIXQ4el59+N1yXkXVotFiuE79QhAwNUAu0
A0YxklDRct3QdIGoPZNxxYaLLsLswhdxf7IenKzPsvK8GMAeJEyjSn47NMglcOqx
2KuerqnF0DL8lPrmsV563ndp0Kio4BOVMSz8CY6K8mOMK/v2TuQCSuhyzSnOZvhu
a6tvUcqQfv7Bj/KQiUD6KasuQ8vyACvUPwgVFRyjPGm5pVoA3rdRphkoQKgfNx+5
MI2j71sQ/BRiDOy4H20yfblN++72trejv6P1heYYcriQV6Eo8sAzIHT0kVOYqN/N
ZJE9dpki1+Q2K8iiXVPmwRWFsRKtQw==
=EzJI
-----END PGP SIGNATURE-----

--DITGHUV3p5DjDsXt--
