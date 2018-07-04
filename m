Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB42C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89DA24042
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89DA24042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeGDVVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:21:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43749 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:21:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2487D804CD; Wed,  4 Jul 2018 23:21:20 +0200 (CEST)
Date:   Wed, 4 Jul 2018 23:21:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Andreas Klinger <ak@it-klinger.de>, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704212119.GA18063@amd>
References: <20180703155328.GA18299@arbeit>
 <20180704065305.GA23509@amd>
 <b10a8282-0297-8cd6-5d29-fb4adcf72366@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <b10a8282-0297-8cd6-5d29-fb4adcf72366@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >LED pattern trigger should be merged, instead.
>=20
> We've already agreed in [0] upon pattern sysfs file, and related
> patch set [1] is just to be merged.
>=20
> [0] https://lkml.org/lkml/2018/5/12/142
> [1] https://patchwork.kernel.org/patch/10495595/

Well, [1] is for LEDs that can do patterns in hardware. I'm aware of
that work.

I still believe that we want to do "trigger" that can do the same on
hardware that is not so lucky.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9Ok8ACgkQMOfwapXb+vIDMwCguvk+PcxIkoANV0G9UBM42mZQ
vV4AnAivyw4C/MU/NEUKyDY4pFBe4dIr
=g1PS
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
