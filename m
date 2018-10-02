Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF9C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AB32083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AB32083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJCExa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:53:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37120 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCEx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:53:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 123CD80775; Wed,  3 Oct 2018 00:07:54 +0200 (CEST)
Date:   Wed, 3 Oct 2018 00:07:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Message-ID: <20181002220754.GA20413@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com>
 <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
 <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We have debated this over and over and now we have 3 different implemen=
tations
> > available we need to collude on which one we want to support.
> >=20
> > Jacek I defer to you and Pavel since you are both LED maintainers.
> >=20
> > I can support the dedicated LED drivers but I cannot support the TI LMU=
 only implementation.
>=20
> I uphold my previous opinion - please go ahead with moving the support
> for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
> along with the bindings. This is semantically correct, and yet we don't
> have mainline users.
>=20
> Pavel - you will have to engage more people for your crusade to prevail.
> For now, to speed up the things, I am forced to ignore your NAK.
> So NAK to your NAK. Sorry.

No need to be sorry :-).

Lets ignore the code for now, as code can be changed easily.

Bindings are not something you or I maintain, so we don't have final
word there, and I have feeling this is not going to go past device
tree maintainers. [AFAICT: you can move binding in Documentation/ to
different place, that's not a problem; but creating a new binding when
old one exists is.]

If you and Dan feel that is okay, you are welcome to try to get the
patches past Rob, just please retain the NAK so that he remembers the
discussion, and so that it is clear that I don't like the changes.

I believe smart thing to do is to try to do that before working
further on the code, but of course, its all up to you :-).

Friends,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluz7DoACgkQMOfwapXb+vJnxQCdHpH3662vekGqNWYJsBMpPjLj
ZSIAoLpKy+Libu1zIKlStBseOo/ZzfZF
=CMwe
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
