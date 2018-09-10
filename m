Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIKCQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:16:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38827 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:16:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0B0568057C; Mon, 10 Sep 2018 23:20:51 +0200 (CEST)
Date:   Mon, 10 Sep 2018 23:20:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180910212051.GB4697@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux>
 <0190dc10-99a3-abb7-b196-a537c49a2b6e@gmail.com>
 <CAMz4kuK=t9t0nZaVHguv_BVH5WKTDvxPrxCjPrpws9=VV_57ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <CAMz4kuK=t9t0nZaVHguv_BVH5WKTDvxPrxCjPrpws9=VV_57ag@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I'm still convinced that this will confuse our users and to me it would
> >> be more logical if this denotes the number of times the pattern should
> >> be repeated, with e.g. negative numbers denoting infinite.
> >
> > Sounds reasonable. Let's change this semantics as you propose.
> >
> >> In particular I expect to have to explain why my driver expects that y=
ou
> >> write 0 in the file named "repeat" to make it repeat and 1 to make it
> >> not repeat.
>=20
> Hm, so there are some cases we need to make clear.
> 1) If negative numbers present infinite, so what's the meaning of number =
0?
> 2) What we should show for users if repeat number is negative, just
> show negative numbers or one string "infinite"?

I'd say just -1 is infinite, anything else is error.

And yes, reading it should just display -1.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluW4DMACgkQMOfwapXb+vIRYACfUOm5UgiwdZQQCFVSVG9lOeQE
kUYAoIB9aeDi3jtaGk/9BaMm/73NNuAT
=V+ge
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
