Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7328C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3D62070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbfBNL3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:29:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40893 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBNL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:29:01 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4FAD180331; Thu, 14 Feb 2019 12:28:52 +0100 (CET)
Date:   Thu, 14 Feb 2019 12:28:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214112858.GG6132@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>Basically the charge led has 3 states:
> >>
> >>1) Off
> >>2) On
> >>3) On when charging
> >>
> >>And then when on it has 4 patterns:
> >>
> >>1) Permanently off (so still not really on)
> >>2) Permanently on
> >>3) Blinking
> >>4) Breathing
> >
> >Ok, so you don't really need to support _both_ off methods.
> >
> >Still sounds like a normal LED, with special "yoga-charging" and
> >"yoga-breathing" triggers. (All the normal triggers should still work,
> >too.)
>=20
> Except that when in yoga-charging mode, the user should
> still be able to select if the LED is simply on when charging,
> blinking when charging, or breathing when charging.

BTW... all this should really go in the comment to the top of the
file. It is non-trivial.

> >>The problem is that any changes made are permanent, they
> >>survice reboots and the default is Breathing, so we need
> >>a way to restore that which does not involve removing
> >>the internal battery of these devices.

As should this.... as it is quite unusual.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlUPoACgkQMOfwapXb+vKDeQCgj8YoCeC9y3msoIYfCsFyGPYh
sdMAnAtIhoY/uZb8icAAoaBhWoEem8rQ
=Aczs
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
