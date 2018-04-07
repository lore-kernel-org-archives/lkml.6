Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeDGIKE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 04:10:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59020 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeDGIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 04:10:02 -0400
Date: Sat, 7 Apr 2018 10:10:00 +0200
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
Subject: simultaneous voice/data works (was Re: call/normal switch was Re:
 omap4-droid4: voice call support was)
Message-ID: <20180407081000.GB7818@amd>
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
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems qmicli can be used while unicsy_demo/ofone talks to the modem
using the AT commands.

So I could do:

qmicli -d /dev/cdc-wdm0 --wds-follow-network --wds-start-network=3Dapn=3Din=
ternet.t-mobile.cz
route del default
sudo ifconfig wwan0 up
dhclient wwan0

to get GPRS/UMTS connection. AT commands still work.

Does anyone have any idea what to do to get the GPS to work?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrIfNgACgkQMOfwapXb+vLUgwCeM8xvN8f4NiGsYsGYTtPbEpiu
+kMAn0ncGuWCT/d3i8uOStcDckMHMnJ9
=sXKV
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
