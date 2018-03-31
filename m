Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeCaTqU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 15:46:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53627 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeCaTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 15:46:19 -0400
Date: Sat, 31 Mar 2018 21:46:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Message-ID: <20180331194616.GA19388@amd>
References: <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180331145531.GA10404@amd>
 <20180331181935.GX5700@atomide.com>
 <20180331191939.GA8999@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20180331191939.GA8999@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-31 21:19:39, Pavel Machek wrote:
> On Sat 2018-03-31 11:19:35, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180331 14:56]:
> > > Hi!
> > >=20
> > > > Hmm well I got audio call hacked to work as a proof of concept hack,
> > > > see below. Maybe it can be used to verify some of the assumptions
> > > > above.
> > > >=20
> > > > Then.. To split the work a bit, can you guys maybe try to decode
> > > > the cpcap register values and try to do a proper ASoC driver patch?
> > >=20
> > > This is not proper patch yet, but it should be a step in that
> > > direction...
> >=20
> > Cool :) Microphone still does not work for me.. I tried tweaking
> > the alsamixer settings but no mic. This is with cold boot with
> > droid4-kexecboot if that might make a difference, we may have
> > some register uninitialized somewhere. Any ideas?
>=20
> Ok, I was focusing on the speaker side.
>=20
> alsamixer, tab to go to capture settings, set it to 37 37 Mic2 Mic1
> should work, according to my notes, but not recently tested and not
> tested against real human.
>=20
> I'll attempt to test it, but something in my userland shuts down
> system just after boot 60% of time, which is rather annoying.

Hmm. So I tried again, and setting Mic1 and back in the capture
settings crashed the modem. Bang, disconnected from the USB.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq/5YgACgkQMOfwapXb+vIDJgCfaibLmTgKvbpU19lpATnNUHbf
+ZkAn2gHcy0x8Xh38+19E9I4SxWWn+H6
=Gjp1
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
