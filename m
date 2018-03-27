Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC0MPD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:15:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41076 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeC0MPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:15:01 -0400
Date: Tue, 27 Mar 2018 20:14:41 +0800
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180327121441.GH29239@sirena.org.uk>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <20180326155828.ttnduivadob4iqmd@earth.universe>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2018 at 05:58:28PM +0200, Sebastian Reichel wrote:

> My understanding is, that we only need to replace the audio-graph-card
> driver to something more complex. The VOICE DAI needs to be configured
> differently based on the use case:

No, this is exactly the sort of use case with multiple DAIs that the
graph card is intended to enable over the old simple-card.

> "audio-graph-card" is not capable of doing this. I was planning to
> try "audio-graph-scu-card" in combination with adding codecs for the
> modem and BT to DT. If that does not work we need a Droid 4 specific
> soundcard driver.

That's just the audio graph card with some hacks for working with a DPCM
based SoC driver set.

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6NbEACgkQJNaLcl1U
h9B3oAf8DFja7E3t6S5AyZX1NtVgh8eJn596ExCt8AVnePFYiplaATZ6Ep943zrd
UzT1lYfV6O9HJeF3rw6hTQWdH5YMIH8OIGFN7fWmXlrHrpFzKkmi9Q9cNMukPo96
DP5sWk1bsyCay5R0utl/A89SBHlImiB9IDHzS4mZnzALl3cWVP+ldjeZ56K4/haT
sRH+pH+fcFH3IVklo5HZY3xnovBr9eXwS6na24SAR7jX+WSCGGLQQoyCVpnoZfFT
7mIw59VLDaBmi+YA+rPsBJAmMlq2buiwtk9HPf2j800sAJd/hkyyID+GvmgQekBD
10Oq5Nhdcf7b7XQC+T2ISH5bxL8nYA==
=nvVV
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
