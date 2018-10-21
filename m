Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CDECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479E22083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479E22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJUQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 12:45:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52244 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeJUQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 12:45:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F02E180959; Sun, 21 Oct 2018 10:31:58 +0200 (CEST)
Date:   Sun, 21 Oct 2018 10:31:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan O'Donovan <dan@emutex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
Message-ID: <20181021083159.GA7893@amd>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <CAHp75VcOxBFvr4MSd=y61t7eFAv=9pFzMsumd7=2jbW3aZ4O4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <CAHp75VcOxBFvr4MSd=y61t7eFAv=9pFzMsumd7=2jbW3aZ4O4g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-10-20 14:17:58, Andy Shevchenko wrote:
1;2802;0c> On Fri, Oct 19, 2018 at 8:27 PM Dan O'Donovan <dan@emutex.com> w=
rote:
> >
> > From: Javier Arteaga <javier@emutex.com>
> >
> > Allow userspace to use the on-board LEDs as "upboard:<color>:".
>=20
>=20
>=20
> > +#include <linux/kernel.h>
> > +#include <linux/leds.h>
> > +#include <linux/mfd/upboard.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/acpi.h>
>=20
> For better maintenance keep this ordered.

This is good as-is.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvMOX8ACgkQMOfwapXb+vJ5QACfcVC9dJE79Pdp2IXxB/lAt3IC
Za4Anjew84xudUHv++zcwxjD8P8dyTln
=efvM
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
