Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7059C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF7A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfAIPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:41:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34994 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfAIPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:41:10 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4AD3E807EF; Wed,  9 Jan 2019 16:41:03 +0100 (CET)
Date:   Wed, 9 Jan 2019 16:41:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/5] leds: trigger: pattern: Add pattern
 initialization from Device Tree
Message-ID: <20190109154108.GB5938@amd>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
 <1547045089-19128-4-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <1547045089-19128-4-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-09 15:44:47, Krzysztof Kozlowski wrote:
> Allow initialization of pattern used in pattern trigger from Device Tree
> property.
>=20
> This is especially useful for embedded systems where the pattern trigger
> would be used to indicate the process of boot status in a nice,
> user-friendly blinking way.  This initialization pattern will be used
> till user-space is brought up and sets its own pattern, indicating the
> boot status is for example finished.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2FhQACgkQMOfwapXb+vKcUgCgohbkeHnCP18YSC1qlsDtxTQy
m1kAn3WHuXsCb5gNdzyspRVitGW7RYbK
=7ZVt
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
