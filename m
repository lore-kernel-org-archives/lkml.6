Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6341C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C54520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C54520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIJUgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:36:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59779 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:36:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 759AB80566; Mon, 10 Sep 2018 17:41:48 +0200 (CEST)
Date:   Mon, 10 Sep 2018 17:41:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180910154149.GA6845@amd>
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd>
 <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd>
 <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-09-08 21:53:00, Jacek Anaszewski wrote:
> Dan,
>=20
> On 09/07/2018 03:52 PM, Dan Murphy wrote:
> [...]
> >>
> >>> And I think Jacek pointed out that the bindings references in this bi=
ndings
> >>> don't even exist.
> >>>
> >>> I am thinking we need to deprecate this MFD driver and consolidate th=
ese drivers
> >>> in the LED directory as we indicated before.  I did not find any ti-l=
mu support
> >>> code.
> >>>
> >>> ti-lmu common core code and then the LED children appending the featu=
re differentiation.
> >>
> >>> Need some maintainer weigh in here.
> >>
> >> Hehe. I'm maintnainer. Fun.
> >=20
> > I know.  I want to see if there was any other opinion.  Especially for =
the LED driver.
> >=20
> [...]
>=20
> I have a question - is this lm3697 LED controller a cell of some MFD
> device? Or is it a self-contained chip?

lm3697 is number for stand-alone device, but same hardware seems to be
embedded into multi-functional chips, with other numbers in lm36xx
series.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAluWkL0ACgkQMOfwapXb+vImQQCffHlXQV24ag2AVempZPEtociN
qZAAl3PXs6dabqtCszyhHbns7S+wrNk=
=Aeim
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
