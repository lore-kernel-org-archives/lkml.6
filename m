Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B7AECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DDE2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DDE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJ3TTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:19:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59928 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJ3TTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:19:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8FF3680802; Tue, 30 Oct 2018 11:26:08 +0100 (CET)
Date:   Tue, 30 Oct 2018 11:26:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181030102610.GC21529@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
 <20181030100139.GB21529@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20181030100139.GB21529@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-t=
o-date-Linux-on-a-XO-1.75
> >=20
> > I didn't test it yet -- will do when I get home in the evening. But
> > chances are it's good enough and I guess you'd be able to get it
> > working even if I messed up some details.

Instruction say make, but you really need to do make zImage and make
mmp2-olpc-xo-1-75.dtb .

Instructions say "make -j", which is nice way to crash a machine. I
suggest "make -j 8" :-).

Ok, I think I followed the instructions. I am using empty root
filesystem, just with /boot -- want to see kernel messages first
before I mess with the userland.

But I don't get kernel messages during boot:

OLPC 1B1, 512 MiB memory...
OpenFirmware Q4C02 EC Frimware 0.3.02

Type any key to interrupt...
(but keys do not interrupt anything, ouch).
Warning... partition type is 0xb...
Boot device: /usb/disk:\boot\olpc.fth Arguments:
Boot device ....
Warning... partition type is 0xb...

And that's it, cursor and no kernel messages.

Any ideas?

Could I get prepared binary zImage for testing?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvYMcIACgkQMOfwapXb+vKPvgCfaHWdlBokcgCLJ+My3PkuySKa
JS4AoIe0MQhnBoGuf4cVdPwTwzdstzQE
=Q4St
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
