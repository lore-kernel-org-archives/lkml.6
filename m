Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED338C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB59020672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB59020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeLKWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57291 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeLKWok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:44:40 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C7F1580818; Tue, 11 Dec 2018 23:44:33 +0100 (CET)
Date:   Tue, 11 Dec 2018 23:44:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
Message-ID: <20181211224436.GA27976@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
 <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
 <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181130210814.GA5756@amd>
 <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
 <fa5add90-e1b7-d527-374f-175abdf88455@gmail.com>
 <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> Basically every single device could have a LED associated with it
> > >> ("activity"). Would doing it like this mean we'd have to modify every
> > >> single driver to parse leds / led-names properties?
> > >
> > > Normally, that's how properties like this would work. A driver is also
> > > what knows how the leds should function.
> >
> > This is not true in case of associations where LED controller is
> > an independent device, as in Pavel's example [0].
>=20
> I'm not really following how the HDD example is different. The parent
> of an LED would be the controller. The link to the led node would be
> in the disk controller node. Though maybe if things get complicated
> enough, we'd want to describe the drives or drive bays in DT.

We were talking case where the LED is on GPIO somewhere. And yes,
drive bays would be similar.

And.. often you have a single LED for multiple harddrives, too. Fun
:-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwQPdQACgkQMOfwapXb+vLnGwCgtFgGl73d1rwY7gfpcDZHaRP5
akgAoIRxzgT8UZQvLrRu5ZLyNwN/Q2xH
=VpU7
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
