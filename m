Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B81C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273CA206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfAIPjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:39:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34926 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfAIPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:39:49 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AC37D8095A; Wed,  9 Jan 2019 16:39:41 +0100 (CET)
Date:   Wed, 9 Jan 2019 16:39:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/5] leds: Add helper for getting default pattern from
 Device Tree
Message-ID: <20190109153946.GA5938@amd>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
 <1547045089-19128-3-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <1547045089-19128-3-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-09 15:44:46, Krzysztof Kozlowski wrote:
> Multiple LED triggers might need to access default pattern so add a
> helper for that.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw2FcIACgkQMOfwapXb+vJBOACgkCpcsS9eqDCeVHHB8Nis+xUN
V3wAn3jeU1LepYCnYHirxGUMD8Kq3s6C
=yFfp
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
