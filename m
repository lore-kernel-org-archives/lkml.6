Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1BC65C33
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E5320895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E5320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeJGUxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:53:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52819 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeJGUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:53:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A80D6807B5; Sun,  7 Oct 2018 15:46:30 +0200 (CEST)
Date:   Sun, 7 Oct 2018 15:46:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH 9/9] leds: lm3632: Introduce the TI LM3632 driver
Message-ID: <20181007134630.GA19323@amd>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-10-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20180926130921.12329-10-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-09-26 08:09:21, Dan Murphy wrote:
> Add the dedicated TI LM3632 LED driver.  This
> LED device is capable of driving a backlight display.
>=20
> In addition to the backlight the device has control
> of a strobe and torch output.

Is this in some way similar to 3639? That also seems to include flash
and torch.

drivers/video/backlight/lm3639_bl.c
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu6DjYACgkQMOfwapXb+vKIfgCfaCzUEz9ZpoY/EfPeEOMPf4a9
KQAAnRlaLwr0s5K4pIDwlOTMD6W6XxRB
=upBE
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
