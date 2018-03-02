Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427873AbeCBMwA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:52:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36153 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422890AbeCBMv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:51:58 -0500
Date: Fri, 2 Mar 2018 13:51:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH/RFC] DT: leds: Fix 'label' property description and add
 'colour' property
Message-ID: <20180302125157.GC28931@amd>
References: <1512251410-6084-1-git-send-email-jacek.anaszewski@gmail.com>
 <20171204104351.GA6611@amd>
 <CAL_JsqL=aN6YSH30HSuUKS86Bsb2KPMdT0dyheYjs9Z=w3hH0Q@mail.gmail.com>
 <82dc0ed3-f4fe-d8a2-65ea-4212770b78e7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <82dc0ed3-f4fe-d8a2-65ea-4212770b78e7@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Also.. it would be good to start pushing for more consistency in the
> >> labels: I have these on the thinkpad:
> >>
> >> input5::scrolllock/   tpacpi::dock_status2/ tpacpi::unknown_led/
> >> mmc0::/               tpacpi:green:batt/    tpacpi::unknown_led2/
> >> phy0-led/             tpacpi:orange:batt/   tpacpi::unknown_led3/
> >> tpacpi::bay_active/   tpacpi::power/
>=20
> In effect it looks like we should drop devicename section from
> the LED class devicename pattern, label should describe only
> LED function and additional color property could be introduced,
> to be concatenated with LED function as a final LED class device
> name.

Well, the device name makes sense if the LED is not on the "main"
device.

I do have "scrollock" led on internal keyboard, and scollock led on
USB keyboard... it is good to be able to tell  which is which.

But yes, IMO it makes sense to move from

"as4134::backlight" to "screen::backlight" or something, and have it
standard across the machines.

tpacpi:: is not useful prefix for a led name. mmc0:: and input5:: are
quite useful.

Similary, as5124::flash is not useful, but main_camera::flash or
video5::flash might be.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZSO0ACgkQMOfwapXb+vI2GgCfQLf+jK8mwh8TNm8ezfCIQcni
3pcAoIXFbIei1QSB1mVFqGlD2F0LJU+e
=LbEP
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
