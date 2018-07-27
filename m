Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CCF20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CCF20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbeG0J5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:57:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42067 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0J5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:57:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1EB3A80643; Fri, 27 Jul 2018 10:36:09 +0200 (CEST)
Date:   Fri, 27 Jul 2018 10:36:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Lechner <david@lechnology.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180727083605.GA20233@amd>
References: <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
 <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
 <20180718221717.GA5451@amd>
 <20180719202005.GA7763@amd>
 <CAMz4kuKGcnDqyF29vGDqjRDMWmmk=c=QVQExYrx_Ymomm3qh+g@mail.gmail.com>
 <20180724114147.GA26036@amd>
 <CAMz4kuKbjUDvqyM3rovRmUpeSabNL6yHX1HpFUYD0pc9d4PNMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKbjUDvqyM3rovRmUpeSabNL6yHX1HpFUYD0pc9d4PNMg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This should be a bit better. I attempted to compile it with your
> > driver, but whether it works is an open question.
>=20
> Sorry for late reply. I've compiled and tested this version on my
> platform, the hardware pattern can work with one small fix as below.
>=20
>  if (led_cdev->pattern_set && !led_cdev->pattern_set(led_cdev,
> data->steps, data->nsteps)) {
>         return;
>  }
>=20
> But I saw there are lots coding style issues and something can be
> improved in this patch, so will you send out one clean patch (I will
> help to test the hardware pattern support)? Or I can help to improve
> this code and try to upstream it again?

If you could do the upstreaming, that would be great.

I tried to get hardware accelerated LED to work on N900, but that
hardware is rather complex, so it would take me some time...

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlta2XUACgkQMOfwapXb+vKNNACfSmyhzdm3AqIKCmGsmg90g9mL
7UgAnAnztEKImnrROnu4kDaQyaZ1kB3K
=0Njs
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
