Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55570C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170EF208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170EF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeKKVSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:18:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44149 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeKKVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:18:05 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 25844806BB; Sun, 11 Nov 2018 12:29:43 +0100 (CET)
Date:   Sun, 11 Nov 2018 12:29:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: Re: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
Message-ID: <20181111112944.GA27666@amd>
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com>
 <1541018689-20625-2-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <1541018689-20625-2-git-send-email-dan@emutex.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +static void __reg_io_start(const struct upboard_ddata * const ddata)
> +{
> +	/*
> +	 * CLEAR signal must be pulsed low before any register access.
> +	 * This resets internal counters in the controller and marks
> +	 * the start of a new register access.
> +	 */
> +	set_clear(ddata, 0);
> +	set_clear(ddata, 1);
> +}

We normally reserve __ prefix for different stuff. This is not using
it appropriately.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoEqgACgkQMOfwapXb+vJW6QCggp4a+m3xauUoHQ3g7SOBg8Kw
w/8AoLHm+xmWtStIi0AZooRWYKr4kZnw
=puC8
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
