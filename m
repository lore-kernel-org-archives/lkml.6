Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A520657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAQKGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:06:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37628 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:06:54 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 71D0C807A7; Thu, 17 Jan 2019 11:06:46 +0100 (CET)
Date:   Thu, 17 Jan 2019 11:06:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dachaac@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20190117100651.GB17930@amd>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
 <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <20190116220401.GA28024@amd>
 <8c7dde3e-5f3c-80a5-ec57-73ce8e39deef@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <8c7dde3e-5f3c-80a5-ec57-73ce8e39deef@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> You know what? First, submit driver with similar functionality to
> >>> existing RGB drivers, using same interface existing drivers are
> >>> using. When that is accepted, we can talk about extending
> >>> kernel<->user interfaces.
> >>>
> >>
> >> I could do that but then there is no way for users to have any other c=
olor but "white" with this driver.
> >> That defeats the purpose of the device itself.
> >=20
> > No, that is not what I meant.
> >=20
> > We do have RGB drivers in tree, they just present three separate LEDs
> > -- red, green and blue. I ask you to do the same for initial
> > submission.
> >=20
>=20
> For clarification you are asking me to register a LED class per
> output pin?

Yes.

> As explained before the Master brightness register has absolute control o=
ver the output current
> to the LED outputs regardless of the color control setting.
>=20

Yes, just set master brightness to 255 and you can ignore it.

> > You'll still be able to set brightness independently on the
> > red/green/blue LEDs...
> >=20
>=20
> But which one would control the overall brightness of the cluster?

You would not have that control in initial version of the patch.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxAU7sACgkQMOfwapXb+vLcUwCgk7gzWalf88kSfQTICoLiUKgw
xMIAoI7BHm0fNZlXPU3Cqctc5PX+JhlV
=x4S1
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
