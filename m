Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D23BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4578020846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4578020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeGZJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:00:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33879 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeGZJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:00:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C310B80475; Thu, 26 Jul 2018 09:44:49 +0200 (CEST)
Date:   Thu, 26 Jul 2018 09:44:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] leds: add Panasonic AN30259A support
Message-ID: <20180726074449.GB4872@amd>
References: <20180721141228.2283-1-simon@lineageos.org>
 <20180721141228.2283-3-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20180721141228.2283-3-simon@lineageos.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-07-22 00:12:27, Simon Shields wrote:
> AN30259A is a 3-channel LED driver which uses I2C. It supports timed
> operation via an internal PWM clock, and variable brightness. This
> driver offers support for basic hardware-based blinking and brightness
> control.
>=20
> The datasheet is freely available:
> https://www.alliedelec.com/m/d/a9d2b3ee87c2d1a535a41dd747b1c247.pdf
>=20
> Signed-off-by: Simon Shields <simon@lineageos.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltZe/EACgkQMOfwapXb+vJvlwCbBXb2+g0cgKex/IjaREEUND6w
RKUAn3H8s5I6vHOaVpE+zHBQ6XP3ScOA
=/a69
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
