Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F6C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563042075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563042075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJXRBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:01:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48029 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJXRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:01:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0C5CA807F7; Wed, 24 Oct 2018 10:34:02 +0200 (CEST)
Date:   Wed, 24 Oct 2018 10:34:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20181024083403.GB24165@amd>
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com>
 <CAMz4kuKSvqx1_=Co70QhmRJVnOACZ0EjLCAs-GF1svqvHDdttA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKSvqx1_=Co70QhmRJVnOACZ0EjLCAs-GF1svqvHDdttA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > OK, let's abide by constant update interval for now.
> >
> > Thank you for your work on this patch set throughout
> > all these months. We will have -rc8, so one week of testing
> > before sending upstream should be enough.
> >
> > Patch set applied to the for-next branch of linux-leds.git.
>=20
> Thanks Jacek and Pavel, you are so patient and always give me lots of
> help there. Glad to co-work with you, thanks again.

Thanks for patience, too. I'm pretty sure pattern trigger will be
useful in future.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvQLnsACgkQMOfwapXb+vJoGACfSxvbleM4NwzCgC7v3meDI1zq
y1QAnj4UrsTQ45lc8w5iDR8Eae2Op0oG
=ACLE
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
