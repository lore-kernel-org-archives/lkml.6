Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D1C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4020823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJ3Sy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:54:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59218 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Sy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:54:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C2CE58078C; Tue, 30 Oct 2018 11:01:37 +0100 (CET)
Date:   Tue, 30 Oct 2018 11:01:39 +0100
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
Message-ID: <20181030100139.GB21529@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181015195612.GB29649@amd>
 <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This makes keyboard/touchpad work on a DT MMP2 platform.
> > >=20
> > > I believe that it would be a good idea if this, once reviewed, went
> > > in
> > > via the input tree. The DT and CLK parts got reviews/acks.
> > >=20
> > > Changes from v1:
> > > - Basically none, just re-send, including Ack and Review tags in
> > > patches
> > >   that received them. Plus an extra Cc.
> > >   I'd be very thankful for reviews.
> >=20
> > Ok, I believe I have OLPC 1.75, and it is actually a nice
> > machine. Can I get recent kernel working there in useful fashion? (Is
> > there docs somewhere)?
>=20
> A lovely machine indeed. I've written this now:
>=20
> https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-=
date-Linux-on-a-XO-1.75
>=20
> I didn't test it yet -- will do when I get home in the evening. But
> chances are it's good enough and I guess you'd be able to get it
> working even if I messed up some details.

Ok, let me check. I went to this branch:

commit f99b274084d320814f4b035a7e3455af424229ea
Author: Lubomir Rintel <lkundrak@v3.sk>
Date:   Sun Aug 5 23:11:27 2018 +0200

First comment: the zImage size adjusting hack should really be
somewhere in tools/ and preferably in python. This is way beyond
reasonable use of shell.

> Please let me know if it works for you -- I'm having trouble getting
> reviews/acks/tested-bys for the XO-1.75 patch sets [1] and will be
> super thankful if I get some feedback from you.
>=20
> [1] https://lore.kernel.org/patchwork/bundle/lkundrak/OLPC%20XO%201.75/

You want to just continue without them :-). As long as you don't
change the core code, you should be ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvYLAIACgkQMOfwapXb+vIJdwCfbPsc+dDKc8pF4G+DixcMANs4
IhkAn05f8C5B7DFCPkU2Xhc4eAp1Jr9/
=I0OY
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
