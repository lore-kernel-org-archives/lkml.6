Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED88C21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBKNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:05:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48799 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfBKNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:05:57 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B1849804FC; Mon, 11 Feb 2019 14:05:48 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:05:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] Intel Cherry Trail Whiskey Cove LEDs support
Message-ID: <20190211130554.GA10203@amd>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190211115951.GC9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190211115951.GC9224@smile.fi.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-02-11 13:59:51, Andy Shevchenko wrote:
> On Sun, Feb 10, 2019 at 01:12:12AM +0300, Yauhen Kharuzhy wrote:
> > This patch series introduces new driver for controlling LEDs connected
> > to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
> > status led). Only simple 'always on' and blinking modes are supported
> > for now, no breathing.
> >=20
> > Driver was tested only with Lenovo Yoga Book notebook, and I don't have
> > any documentation for the PMIC, so proposals and testing are welcome.
> >=20
>=20
> I'm not sure you have a correct Cc list here. LED maintainers are
> M:      Jacek Anaszewski <jacek.anaszewski@gmail.com>
> M:      Pavel Machek <pavel@ucw.cz>
>=20
> Also would be nice to cc to Hans de Goede.

I follow the list. I beileve Jacek does, too.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxhczIACgkQMOfwapXb+vI+KQCdGaLwZGMbRwjtrDHUgSqwNfOH
T5gAn2yJmb3vQX6jF0jvIW491WJaB/RC
=6Pzg
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
