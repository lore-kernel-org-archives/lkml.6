Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DAECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B9121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B9121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeITNIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:08:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33816 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeITNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:08:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2FBCC8072A; Thu, 20 Sep 2018 09:26:36 +0200 (CEST)
Date:   Thu, 20 Sep 2018 09:26:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Aditya Prayoga <aditya@kobol.io>
Cc:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada
 38x
Message-ID: <20180920072635.GB20392@amd>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-3-git-send-email-aditya@kobol.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <1537328730-9156-3-git-send-email-aditya@kobol.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-09-19 11:45:30, Aditya Prayoga wrote:
> Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
> used in kernel configuration.

Should that be hidden symbol and should that be architecture specific?

For a notebook, I may want scrolllock LED to indicate ATA activity
(because I'm using USB keyboard and can't see the disk led).

Hmm. And while at it... it would be nice to have option to watch all
ATA ports combined, as well.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlujS6sACgkQMOfwapXb+vJ8dQCdE9X5r1O9YnzTYdBJ3yXuY6RA
qE4AnA51Hs2yMwmlxrKvUAeyZsL7icqA
=JC5/
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
