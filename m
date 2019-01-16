Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D802C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A8D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfAPWEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48298 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbfAPWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:04 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4DEAE8081B; Wed, 16 Jan 2019 23:03:56 +0100 (CET)
Date:   Wed, 16 Jan 2019 23:04:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dachaac@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20190116220401.GA28024@amd>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
 <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <86299268-3202-814a-134b-04bd2170faab@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

=2E.snip. Let me read it and reply when I have a time.

> > You know what? First, submit driver with similar functionality to
> > existing RGB drivers, using same interface existing drivers are
> > using. When that is accepted, we can talk about extending
> > kernel<->user interfaces.
> >=20
>=20
> I could do that but then there is no way for users to have any other colo=
r but "white" with this driver.
> That defeats the purpose of the device itself.

No, that is not what I meant.

We do have RGB drivers in tree, they just present three separate LEDs
-- red, green and blue. I ask you to do the same for initial
submission.

You'll still be able to set brightness independently on the
red/green/blue LEDs...

> I am not sure if you are aware of this or care but I found this recent bl=
og on this effort:
> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DLinux-RGB-LED-Int=
erface
> See some of the comments.

I went through the comments quickly, but see nothing really
interesting.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/qlEACgkQMOfwapXb+vJx4QCfXBqAKUAZw9Cu9PftPLc3wRcO
YtkAn1O/2trkfkYCSmKPbfD56kJgtqTl
=c3vh
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
