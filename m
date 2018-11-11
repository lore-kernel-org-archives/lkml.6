Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D3208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34D3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeKLAUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:20:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47546 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeKLAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:20:38 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8F342806D3; Sun, 11 Nov 2018 15:31:51 +0100 (CET)
Date:   Sun, 11 Nov 2018 15:31:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 12/24] leds: lm3692x: Use led_compose_name()
Message-ID: <20181111143152.GC5215@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-13-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <1541542052-10081-13-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-06 23:07:20, Jacek Anaszewski wrote:
> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoPVgACgkQMOfwapXb+vI3CQCffUm9z8/lspP43YnrcQLXFV+e
tykAn0y2982tEuO1goAhfZEVVjqRf+mO
=2K9x
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
