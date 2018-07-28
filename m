Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09AC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CD520897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CD520897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbeG1WjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:39:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60885 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbeG1WjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:39:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C285680600; Sat, 28 Jul 2018 23:11:16 +0200 (CEST)
Date:   Sat, 28 Jul 2018 23:11:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        mchehab@s-opensource.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, hans.verkuil@cisco.com
Subject: new libv4l2 (was Re: [PATCH, libv4l]: Make libv4l2 usable on devices
 with complex pipeline)
Message-ID: <20180728211110.GB1152@amd>
References: <20180708213258.GA18217@amd>
 <20180719205344.GA12098@amd>
 <20180723153649.73337c0f@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20180723153649.73337c0f@coco.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Add support for opening multiple devices in v4l2_open(), and for
> > > mapping controls between devices.
> > >=20
> > > This is necessary for complex devices, such as Nokia N900.
> > >=20
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz> =20
> >=20
> > Ping?
> >=20
> > There's a lot of work to do on libv4l2... timely patch handling would
> > be nice.
>=20
> As we're be start working at the new library in order to support
> complex cameras, and I don't want to prevent you keeping doing your
> work, IMHO the best way to keep doing it would be to create two
> libv4l2 forks:

BTW.. new library. Was there decision what langauge to use? I know C
is obvious choice, but while working on libv4l2, I wished it would be
Rust...

Rewriting same routine over and over, with slightly different types
was not too much fun, and it looked like textbook example for
generics...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltc2+4ACgkQMOfwapXb+vJbDgCgpP8+5EucGvB662O+9LxjcWoX
twEAn0b3OtHZpzrlK3aM98f83hL+DFEo
=UuS2
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
