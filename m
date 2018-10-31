Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03630ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB62A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeJaV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:27:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52376 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeJaV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:27:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 093FE80834; Wed, 31 Oct 2018 13:29:17 +0100 (CET)
Date:   Wed, 31 Oct 2018 13:29:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     James Cameron <quozl@laptop.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181031122919.GA15074@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
 <20181030102610.GC21529@amd>
 <20181030235430.GF30863@us.netrek.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20181030235430.GF30863@us.netrek.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > But I don't get kernel messages during boot:
> >=20
> > OLPC 1B1, 512 MiB memory...
> > OpenFirmware Q4C02 EC Frimware 0.3.02
> >=20
> > Type any key to interrupt...
> > (but keys do not interrupt anything, ouch).
> > Warning... partition type is 0xb...
> > Boot device: /usb/disk:\boot\olpc.fth Arguments:
> > Boot device ....
> > Warning... partition type is 0xb...
>=20
> That firmware has problems with USB drives.  Please upgrade to Q4D38.
> Quickest tested method is http://wiki.laptop.org/go/Upgrading_firmware

Let me try that... Upgrading firmware said "USB drive" so I placed
bootfw.zip on usb drive. It did quite a show, but I believe it said
that my firmware is up to date?

It all ended with "activation lease not found" message. Let me retry?
Same result.

Let me try "upgrading firmware" with SD card. It seems to work with SD
card. Holding down both "yes" and "no" keys during boot results in
more useful messages... good. I have now updated firmware, and it even
fixed my previous boot problem. Good.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvZoB8ACgkQMOfwapXb+vIpwQCfWH+L06L+O7eJ1zs+wXKhuo3Y
Y0cAoLRDSdd0TA/ttWF7HfBB4K/daRe+
=hlkl
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
