Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425410AbeCBJKe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:10:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59177 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424852AbeCBJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:10:28 -0500
Date: Fri, 2 Mar 2018 10:10:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, martijn@brixit.nl,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>, abcloriens@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        clayton@craftyguy.net, Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, patrikbachan@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
Message-ID: <20180302091025.GC30267@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Linux-Regression-ID: lr#4b650f

On Tue 2018-02-27 09:43:32, Linus Walleij wrote:
> On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > I did git bisect, and the winner seems to be:
> >
> > pavel@duo:/data/l/linux-n900$ git bisect bad
> > c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> > commit c85823390215e52d68d3826df92a447ed31e5c80
> > Author: Linus Walleij <linus.walleij@linaro.org>
> > Date:   Wed Dec 27 16:37:44 2017 +0100
> >
> >     gpio: of: Support SPI nonstandard GPIO properties
>=20
> I have fixes queued for this, tried to send a pull request yesterday
> but it turns out the fixes need fixing... OK I'm onto it anyways.

Do you have any updates? Is there way to fix dts so that this does not
trigger on N900?

If this is taking longer to fix, should c85823390215 be reverted in
the meantime? It does not seem particulary important/urgent...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZFQEACgkQMOfwapXb+vKi0QCgisW7TTYD3Wz6Rl2Pke3fLMBu
b6kAoLv/GtwT7M1red+ajx/xDTaISMP9
=Yzct
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
