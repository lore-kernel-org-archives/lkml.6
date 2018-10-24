Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF1C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67872082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67872082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJXRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:22:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48540 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeJXRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:22:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C1CF9807F4; Wed, 24 Oct 2018 10:55:42 +0200 (CEST)
Date:   Wed, 24 Oct 2018 10:55:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181024085543.GA24997@amd>
References: <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
 <5c7f03cc-4d45-6010-523d-46721c218731@ti.com>
 <20181015214512.GA2001@amd>
 <aa401333-9650-c925-2085-6e6d17b576bd@ti.com>
 <20181018221048.GA6364@amd>
 <b3d390c8-46bf-2c94-fad5-ec85b1cca2fe@ti.com>
 <20181019145812.GC43338@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20181019145812.GC43338@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-10-19 07:58:12, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [181019 11:42]:
> > On 10/18/2018 05:10 PM, Pavel Machek wrote:
> > >=20
> > > Now... this is what I've suggested before. If you don't agree, you may
> > > want to contact Tony Lindgren, IIRC he works for TI, too, and might be
> > > willing to help.
> >
> > I will ping Tony just to close the loop.  I will be posting v4 today af=
ter making the changes.
> > I was hoping to have some code review prior to posting v4 but have not =
received any comments so
> > v4 will just be a patch rearrangement.
>=20
> I guess not much to ping here though as I know little about these
> chips :) As long as Rob is happy with the binding changes I'll be
> happy too.

Well, question is more "how to make Rob happy". I see v4 is out, let
me comment on that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQM48ACgkQMOfwapXb+vKa7QCgrGHsNWr7veMOlP3bWoCrdDpO
6EkAnji+3GZF+fbvC3H4bPwsBgniHPoi
=Yi8O
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
