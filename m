Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B82CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197BE208B1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197BE208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeHHTaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:30:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33583 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:30:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5A34F805C8; Wed,  8 Aug 2018 19:09:39 +0200 (CEST)
Date:   Wed, 8 Aug 2018 19:09:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com,
        narmstrong@baylibre.com, claudiu.beznea@microchip.com,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180808170933.GC7306@amd>
References: <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801185823.GC26087@amd>
 <20180802110701.3b4voigegy67h4p5@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20180802110701.3b4voigegy67h4p5@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, Aug 01, 2018 at 08:58:24PM +0200, Pavel Machek wrote:
> > > > Yep, so I have two patches that make the device appear, but vibrati=
ons
> > > > still do not work for me.
> > > >=20
> > > > a) any ideas how to debug that / get them to work?
> > >=20
> > > Hmm no new ideas except I wonder if there is also some other
> > > regression with the timer pdata not being passed properly now.
> >=20
> > I checked vibrations work in original Motorola Android; my hardware is
> > not broken.
>=20
> You got it working, but this information might still be interesting
> in case of future problems:
>=20
> The Android "driver" is very different from the one I wrote from
> scratch and upstreamed. The mainline driver is less lines of code
> (iirc 25%), less complicated (Android vibration support is spread
> over multiple drivers/arch code), more efficient (Android drivers
> does GPIO bitbanging instead of PWM) and provides more features
> (Android driver does not allow all strength settings). Also it uses
> normal input device API instead of a custom one.

Thanks for doing it right.

> P.S.: Sorry, I don't have much time to work on D4 at the moment :(

Thanks for doing the work, d4 seems to be the most usable phone at the
moment. Yes, there's more work to do, but there's always more work to
do.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrI80ACgkQMOfwapXb+vLgkQCggzpi9K5+lYalLpefgKEEBvYI
JaQAn3jjgKOiQ5LPwnbzA0ucR8NGi9t0
=oSb0
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
