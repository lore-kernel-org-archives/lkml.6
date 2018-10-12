Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B29C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF482087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF482087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJMBg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:36:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46038 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeJMBg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:36:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AB05580A4D; Fri, 12 Oct 2018 20:03:13 +0200 (CEST)
Date:   Fri, 12 Oct 2018 20:03:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, lee.jones@linaro.org,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181012180312.GB5565@amd>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com>
 <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20181012162619.GA28573@bogus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > >>
> > >> NAK.
> > >=20
> > > Thanks for the NAK.
> > >=20
> > > This NAK was NAK'd by other maintainer in the V2 RFC patchset
> > >=20
> > > https://lore.kernel.org/patchwork/patch/993171/
> >=20
> > I confirm. LM3697 is a standalone device and not a cell of any
> > MFD device.
> >=20
> > Waiting for DT maintainer's ack.
>=20
> You all sort out what you want... I can't follow it all, and I'm not=20
> going to spend the time trying to figure out what is going on here.

This is what I want:

> As this is worded, changing the driver is a Linux problem and irrelevant=
=20
> to the binding. Now if you want to move documentation to a location that=
=20
> makes more sense, then fine. But structure patches that way and make it=
=20
> clear that from an binding ABI perspective, nothing is changing.

=2E..but apparently I did not have enough authority to get it.

(I'm ok with move, and it is possible that binding does need some
fixups besides the move; still it should be done as fixup not as a new
binding).

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvA4eAACgkQMOfwapXb+vKgBQCfUIZ/eXRCOTCJUVJpsOGMC5nR
58oAn37DSu7PFR32erjNbDh23QXc4GIz
=qPga
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
