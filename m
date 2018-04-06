Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDFMpS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:45:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59395 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeDFMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:45:16 -0400
Date: Fri, 6 Apr 2018 14:45:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Tony Lindgren <tony@atomide.com>, Dan Williams <dcbw@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Message-ID: <20180406124513.GB18691@amd>
References: <20180401131852.GA11086@amd>
 <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com>
 <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-04-06 14:23:46, Merlijn Wajer wrote:
> Hi,
>=20
> On 06/04/18 14:04, Pavel Machek wrote:
> > Hi!
> >=20
> >> OK that explains why the speaker keeps working then :)
> >=20
> > Ok, I pushed new version of unicsy_demo.
> >=20
> > It now sends & receives sms and you can call & receive call. Tone from
> > linphone is used for incoming call. User interface and code is
> > slightly weird, as ofono was -- and still is -- meant as a backend.
>=20
> Great news, can't wait to try it.
>=20
> Did you modify ofono beyond the patches you have already posted? And
> what version of ofono was that for?

Forget ofono for now. I modified ofone to issue at commands
directly. It is .. a hack, but should be good enough for testing.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrHa9kACgkQMOfwapXb+vLNXQCgvorYKPY+Q+nmQ8JXGovE2SEM
4OUAoI4yFilnrpNCzWcWmBj2aA4WgKP4
=2DCA
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
