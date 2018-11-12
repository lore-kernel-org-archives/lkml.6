Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80752241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80752241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbeKMIGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:06:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59633 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:06:14 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EC72F80706; Mon, 12 Nov 2018 23:11:02 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:11:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     dachaac@gmail.com, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        oleg@kaa.org.ua, Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Subject: LEDs on USB keyboards was Re: [PATCH 02/24] leds: core: Add support
 for composing LED class device names
Message-ID: <20181112221104.GC11942@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
 <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd>
 <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
 <CACRpkdZwgZ=PmX3PEpR-F76BZ5g9hzvQYc_3QfFYhHvBHqp4Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <CACRpkdZwgZ=PmX3PEpR-F76BZ5g9hzvQYc_3QfFYhHvBHqp4Tw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Couldn't we have here multiple variants that would then be chosen based
> > on device tree definition?
>=20
> It needs to be subsystem specific or something.
> What you say make sense for things based on device
> tree.
>=20
> The problem hit me on an Intel laptop with several
> USB keyboards.
>=20
> OK maybe I am stupid for plugging in two USB keyboards,
> but we should definately support it. Input/HID supports it
> well.

Plugging two USB keyboards should be supported.

Can we get some details... kernel version, architecture, maybe
=2Econfig, where/how it fails?

On my systems, keyboard leds are prefixed with device name, so I see
no chance for duplicities...

input5::capslock/   =20
input5::numlock/    =20
input5::scrolllock/

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvp+ngACgkQMOfwapXb+vLqywCdFaqE3SM9L6Df8+cbZl/qYHAi
7BEAoI8ogyxXrej9w7IRZ6vlaCjzxYNi
=SadW
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
