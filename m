Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9066C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA7214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEA7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeKLAUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:20:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47542 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeKLAUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:20:34 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DB909806D1; Sun, 11 Nov 2018 15:31:46 +0100 (CET)
Date:   Sun, 11 Nov 2018 15:31:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 06/24] leds: sc27xx-blt: Use led_compose_name()
Message-ID: <20181111143148.GB5215@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-7-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <1541542052-10081-7-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-06 23:07:14, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoPVQACgkQMOfwapXb+vJY7wCfZJYl+WZd/KkG0R9/Ndu2C1dp
qtIAmwRCq5kx57QvIOm3aMrdXUUNutQb
=vQrG
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
