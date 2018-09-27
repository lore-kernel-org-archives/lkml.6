Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6CBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309FF2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309FF2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeI1EIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:08:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60426 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI1EIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:08:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 94E9E80892; Thu, 27 Sep 2018 23:47:57 +0200 (CEST)
Date:   Thu, 27 Sep 2018 23:47:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Message-ID: <20180927214752.GG17346@amd>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com>
 <20180926223612.GA32286@amd>
 <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Duplicate.
> >=20
> > Can we get some more sharing? One way would be to have struct with
> > all the constants (instead of #defines) use that...?
>=20
> I will look at the adding common constants to but they should be common a=
cross
> more then just 2 devices.  As you can see the LM3632 code is quite differ=
ent
> when you add in the flash/torch support.

LM3632 is indeed different, I see.

On the other hand, I'd really like to see the code shared, even if it
is just for 2 devices. (I believe that family is big enough that we'll
likely see more sharing in future).

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlutUAgACgkQMOfwapXb+vJLFQCeL4YKXfqkDl+7md+fsLrHBgwp
YOUAn1r4iDOnflyNQ8BWi2AF31Apg1XE
=0NJ2
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
