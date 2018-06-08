Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c5McMCZxGlvzNwAAmS7hNA
	; Fri, 08 Jun 2018 12:06:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C36786089E; Fri,  8 Jun 2018 12:06:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4EAE3605A5;
	Fri,  8 Jun 2018 12:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EAE3605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeFHMGm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:06:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45183 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751019AbeFHMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:06:40 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fRGAA-0006hM-6c; Fri, 08 Jun 2018 13:06:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fRGA4-0001uP-C8; Fri, 08 Jun 2018 13:06:32 +0100
Message-ID: <9a1eedee747fd7b0f985919a51d11f1b4445a6e6.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 191/410] Input: mms114 - fix license module
 information
From: Ben Hutchings <ben@decadent.org.uk>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Shyti <andi.shyti@samsung.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 08 Jun 2018 13:06:32 +0100
In-Reply-To: <CAKdAkRRZqayW8AKbjHwBp+RWS5Q1Y6tAW0h9o7cULp+J_bTz8w@mail.gmail.com>
References: <lsq.1528380320.647747352@decadent.org.uk>
         <lsq.1528380321.591046177@decadent.org.uk>
         <CAKdAkRRZqayW8AKbjHwBp+RWS5Q1Y6tAW0h9o7cULp+J_bTz8w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Xm9/06tU5Y8e9vEcI9lR"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xm9/06tU5Y8e9vEcI9lR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-07 at 14:41 -0700, Dmitry Torokhov wrote:
> On Thu, Jun 7, 2018 at 7:05 AM, Ben Hutchings <ben@decadent.org.uk> wrote=
:
> > 3.16.57-rc1 review patch.  If anyone has any objections, please let me =
know.
>=20
> Not a hard objection, but rather a curiosity: for this to be pulled
> into stable what user issue does this fix?

I start by selecting anything with a 'Cc: stable' or Fixes tag for a
commit that's in the stable branch.  If it applies cleanly I might not
look far beyond that.

This commit doesn't really meet the stable kernel rules, but it's
fixing documentation and is low risk so I'll keep it.

Ben.

> >=20
> > ------------------
> >=20
> > From: Andi Shyti <andi.shyti@samsung.com>
> >=20
> > commit 498e7e7ed1fd72c275a682f0903c4a20cc538658 upstream.
> >=20
> > The driver has been released with GNU Public License v2 as stated
> > in the header, but the module license information has been tagged
> > as "GPL" (GNU Public License v2 or later).
> >=20
> > Fix the module license information so that it matches the one in
> > the header as "GPL v2".
> >=20
> > Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
> > Reported-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  drivers/input/touchscreen/mms114.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > --- a/drivers/input/touchscreen/mms114.c
> > +++ b/drivers/input/touchscreen/mms114.c
> > @@ -592,4 +592,4 @@ module_i2c_driver(mms114_driver);
> >  /* Module information */
> >  MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
> >  MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
> > -MODULE_LICENSE("GPL");
> > +MODULE_LICENSE("GPL v2");
> >=20
>=20
>=20
>=20
--=20
Ben Hutchings
When in doubt, use brute force. - Ken Thompson


--=-Xm9/06tU5Y8e9vEcI9lR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsacUgACgkQ57/I7JWG
EQkaBBAAguzxBqVPFbcAeI7KVjfUUSEDnBjMX2mC8ZLn2R+SJX1PP0G3pdfgUhey
WgwJZ/K0pAv552tfEF+oKzm2aGcdgBL5dHNHRFUzzOetOMYC94/MK9/jXo0keotC
DPoFYofORNoqF/kfjnw2VnWwF59rGsLA2IvpPY8KOLtwZ1GDvaD6xC8EDh2vRBOJ
dBuoAT837L7mMEDwfWdcSVH2+LtlIuDKQUexJkT/jQq+h1A0RNRF21mAzIijrRAM
858HBay9f8fIPclvzihVcOI8RZmeagMNKG/wTvhSwR9OO4fcyNLHM9aLMBrhB+ee
M2NQdoMDGfU0i3pT9hx2kgSijbzaulgVC5+rizPZ3L6CcWydaLdICfCmSBkzn18u
aMCoHK9rI21mm5Rnlk6+U5mjalCPcW+U9aHbUDbnpNbKaAqM6HCusmev4t3++5RK
8feMr2Unp44RJxIrYuIK2p2LsREpyM6aQmYewlz2C/DJUIipC8VJzHYyq3YFYoPV
SE1XHk3SuVREjHgMmrHpmgHztdFpUKYCdm9w67Wzud2Adu6l7wQsnCPFK+CzbFmQ
5kl98SKrDmLvy3fKHjtttGM5W/wsRw/afcX2r7fgmNArRkVQonVKV7X+4Ohlhpyz
/Jz4cpl8HL6RGO1T3O2zWYohK77H2ytVD7nnAQAEmjI3rVYkCuk=
=1ooP
-----END PGP SIGNATURE-----

--=-Xm9/06tU5Y8e9vEcI9lR--
