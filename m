Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F03204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F03204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPFcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:32:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55484 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeJPFcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:32:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 576B9808A6; Mon, 15 Oct 2018 23:45:12 +0200 (CEST)
Date:   Mon, 15 Oct 2018 23:45:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181015214512.GA2001@amd>
References: <20181011165123.32198-3-dmurphy@ti.com>
 <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus>
 <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
 <5c7f03cc-4d45-6010-523d-46721c218731@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <5c7f03cc-4d45-6010-523d-46721c218731@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Given this one seems to have not really been finished, it's probably
> >> okay to make changes in this case. Still, it would be good to see
> >> patches structured so that it's obvious we're breaking things. But how
> >> the patches are structured doesn't matter until there's some agreement
> >> on the end result.
> >=20
> > OK, so if I'm getting it right, the correct patch structure in this case
> > means that changes removing bindings from MFD and moving them along
> > with the modifications to the LED subsystem should be placed in a single
> > patch.
> >=20
> > Dan, could you please arrange the next patch set version accordingly?
>=20
> Yes I can squash the DT bindings patches and call it a "move and modify"

You can do move without problems. But if you plan to modify them,
please try to change as little as possible, make it separate patch and
explain why new version is better than old one.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvFCmgACgkQMOfwapXb+vLlCACdE9/pTkDCsUOQs5V3SQPhXgeN
rnEAn2i3kGhzClVvDPKYX6+2Tw2FyH83
=UNmj
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
