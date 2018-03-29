Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeC2OJx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:09:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41341 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeC2OJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:09:51 -0400
Date: Thu, 29 Mar 2018 16:09:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180329140948.GA27473@amd>
References: <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20180329014507.GM5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Meanwhile, I can try to make voice calls more reproducable with
> qmi or MM for example instead of just n_gsm.. And then I'll try
> to fix my n_gsm pile of hacks for posting..

If you get something to work, that will be great.

If you get ofonod to work, that would be even better :-). [That's what
Jolla uses, and that's what I have graphical clients for].

Oh and.. if you have reasonable windowing system, let me know.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq886wACgkQMOfwapXb+vLnFACgrVtJWK0yBngzdwCpwkVM73m9
H1QAoIzAVpBO5beG4XIAOBG3SJgegbRY
=XPBz
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
