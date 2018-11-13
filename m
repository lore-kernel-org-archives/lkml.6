Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC79223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC79223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeKNHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:50:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34076 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:50:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C8E4580723; Tue, 13 Nov 2018 22:50:38 +0100 (CET)
Date:   Tue, 13 Nov 2018 22:50:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        Linus Walleij <linus.walleij@linaro.org>, oleg@kaa.org.ua,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
Message-ID: <20181113215040.GA2235@amd>
References: <20181111120234.GA28794@amd>
 <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd>
 <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd>
 <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
 <20181112190554.GA13959@amd>
 <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com>
 <20181112220616.GB11942@amd>
 <CAMuHMdVAYpXPZie8DTrmMz+KXiVP=WNyFNtfTZPYHYkFOa9wqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVAYpXPZie8DTrmMz+KXiVP=WNyFNtfTZPYHYkFOa9wqg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-13 22:38:49, Geert Uytterhoeven wrote:
> Hi Pavel,
>=20
> On Mon, Nov 12, 2018 at 11:07 PM Pavel Machek <pavel@ucw.cz> wrote:
> > Not really, I'm afraid. Hard drives have no red LEDs on them (and the
> > LED would not be visible, anyway) so the "device" symlink in such case
> > would point to some kind of i2c LED controller.
>=20
> I've seen hard drives with LEDs on the PCB.

Me too.

> External USB enclosures with hard drives typically have LEDs, too.

Yes, but typically neither are OS controlled.

I'm thinking home NAS system; it may have per-disk LEDs and they'll
probably be on some kind of dedicated LED controller.

Anyway, my point is that "device that controls this LED" is often
different from "device this LED is about".

Regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvrRzAACgkQMOfwapXb+vK3gwCfQZiQIfJVltzytk33zq1aIbwR
ZiAAoKDyWVBNyG9TS9jhfQevyqvfWUHX
=UwZm
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
