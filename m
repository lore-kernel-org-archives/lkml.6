Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739CC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F22075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062F22075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJXRl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:41:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49229 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:41:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A5427807F7; Wed, 24 Oct 2018 11:14:06 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:14:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com,
        Milo Kim <milo.kim@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v4 1/7] leds: add TI LMU backlight driver
Message-ID: <20181024091407.GC24997@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20181023170623.31820-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-23 12:06:17, Dan Murphy wrote:
> From: Pavel Machek <pavel@ucw.cz>
>=20
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>=20
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
>=20
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

This is not correct way to sign off a patch.

What is worse, this is very different from patch I submitted; this
misses imporant parts while my patch was complete.

I already submitted better patch for both the driver and device tree
bindings. Can we go back and apply that?

Then you can add your changes on top of that, if they actually make
the situation better.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQN98ACgkQMOfwapXb+vIOCACfQN8uM9Mm9rBT85ynEiWjE19w
zKEAn2XQzpMu+BYx1591Y+bK54grktTX
=4gGL
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
