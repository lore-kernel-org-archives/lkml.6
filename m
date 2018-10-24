Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B55C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AC7207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AC7207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJXVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:45:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55676 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:45:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D1ADD807FE; Wed, 24 Oct 2018 15:17:15 +0200 (CEST)
Date:   Wed, 24 Oct 2018 15:17:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v4 1/7] leds: add TI LMU backlight driver
Message-ID: <20181024131716.GA11619@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181024091407.GC24997@amd>
 <4afc7944-d6f1-fef1-1ae4-f761e050fec9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <4afc7944-d6f1-fef1-1ae4-f761e050fec9@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-24 07:27:57, Dan Murphy wrote:
> Pavel
>=20
> On 10/24/2018 04:14 AM, Pavel Machek wrote:
> > On Tue 2018-10-23 12:06:17, Dan Murphy wrote:
> >> From: Pavel Machek <pavel@ucw.cz>
> >>
> >> This adds backlight support for the following TI LMU
> >> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> >>
> >> It controls LEDs on Droid 4
> >> smartphone, including keyboard and screen backlights.
> >>
> >> Signed-off-by: Milo Kim <milo.kim@ti.com>
> >> [add LED subsystem support for keyboard backlight and rework DT
> >> binding according to Rob Herrings feedback]
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >> [remove backlight subsystem support for now]
> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > This is not correct way to sign off a patch.
> >=20
> > What is worse, this is very different from patch I submitted; this
> > misses imporant parts while my patch was complete.
> >=20
> > I already submitted better patch for both the driver and device tree
> > bindings. Can we go back and apply that?
> >=20
> > Then you can add your changes on top of that, if they actually make
> > the situation better.
>=20
> Thanks for this.  I wanted to make sure not to loose any authorship or cr=
edit
> in the commit.  Actually removing Milo might help stop getting the bounce=
 back
> from the mail daemon.
>=20
> I was using the RFC patch as my base https://lore.kernel.org/patchwork/pa=
tch/978995/
>=20
> Which contains this sign off.

Yeah, but you need to append your sign-off to the end, preferably
prepending note saying what you modified. [I'm ok with the original
patch, but I'm not ok with your version].

=46rom: Pavel Machek <pavel@ucw.cz>

Is not correct. Original patch is from Milo, if you want to add
explicit From:, I guess it should be his.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQcNwACgkQMOfwapXb+vL9mgCfZ/m3O860tSqL0HBhl1qUP6EV
nUsAn3Sk6DE7p7E0zkedARl61HPpdVuZ
=SUnO
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
