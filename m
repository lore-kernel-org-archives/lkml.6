Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51020882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfA2VpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:45:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60108 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2VpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:45:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 61692801C0; Tue, 29 Jan 2019 22:45:07 +0100 (CET)
Date:   Tue, 29 Jan 2019 22:45:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20190129214513.GA8692@amd>
References: <4a20b14c-9514-25b8-affe-20f9ede4d4d8@ti.com>
 <8fac6aeb-28a8-d136-c654-9d1b5d4f7ddb@gmail.com>
 <27318c48-f84a-5129-ac88-545edd549101@gmail.com>
 <21d3e21a-e50e-ee46-6f81-5a22db878c15@ti.com>
 <1c7680d3-6926-d837-dcd9-254aca23df39@gmail.com>
 <3e804986-89ef-2465-51ad-86e793b39b7e@ti.com>
 <f7ad8d5a-2998-f6f0-be4b-b47237b3397f@gmail.com>
 <4d80cc7f-1f18-ec5b-d312-a6a0da2a4506@ti.com>
 <ca8b4251-afd4-ddde-96f2-6e3fc72e3b55@gmail.com>
 <a097bfc8-cdee-67bb-6c30-6a31142d01ab@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <a097bfc8-cdee-67bb-6c30-6a31142d01ab@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Could you, trim the parts of email you do not need in the reply? This
is quite annoying to follow:

On Tue 2019-01-29 14:26:20, Dan Murphy wrote:
> Jacek
>=20
> On 1/29/19 2:19 PM, Jacek Anaszewski wrote:
> > Hi Dan,
> >=20
> > On 1/29/19 2:56 PM, Dan Murphy wrote:
> >> Jacek
> >>
> >> On 1/24/19 3:55 PM, Jacek Anaszewski wrote:
> >>> Dan
> >>>
> >>> On 1/24/19 10:00 PM, Dan Murphy wrote:
> >>>> Jacek
> >>>>
> >>>> On 1/23/19 3:52 PM, Jacek Anaszewski wrote:
> >>>>> Dan,
> >>>>>
> >>>>> On 1/22/19 11:44 PM, Dan Murphy wrote:
> >>>>>> Jacek
> >>>>>>
> >>>>>> On 1/22/19 3:39 PM, Jacek Anaszewski wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> On 1/20/19 7:42 AM, Vesa J=E4=E4skel=E4inen wrote:
> >>>>>>>> Hi Dan,
> >>>>>>>>
> >>>>>>>> On 18/01/2019 15.58, Dan Murphy wrote:
> >>>>>>>>> Jacek
> >>>>>>>>>
> >>>>>>>>> On 1/18/19 7:45 AM, Dan Murphy wrote:
> >>>>>>>>>> Jacek
> >>>>>>>>>>
> >>>>>>>>>> On 1/17/19 3:10 PM, Jacek Anaszewski wrote:
> >>>>>>>>>>> Hi Dan,
> >>>>>>>>>>>
> >>>>>>>>>>> On 1/16/19 7:41 PM, Dan Murphy wrote:
> >>>>>>>>>>>> Hello
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 1/16/19 4:55 AM, Pavel Machek wrote:
> >>>>>>>>>>>>> Hi!
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
> >>>>>>>>>>>>>>> Hi!
> >>>>>>>>>>>>>>>
=2E..

> >> If this is OK I can post the patch with this update.
> >>
> >> But I would rather put the file creation in a class and have the color=
s directory.
> >=20
> > Yes, please post your work when it is ready.
>=20
> OK.  I will derive the class and try to post it by the EOW.

You can do that, but if you post the description of kernel<->user
interface, first, you may save yourself a bit of coding...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxQyWkACgkQMOfwapXb+vIp/gCfbUBqz6gwMGWI5ujgrmfa1JrA
nOAAn3QHSZiCoOTcMk4k1JthV2KhyZNs
=/cY7
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
