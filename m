Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD0C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E39B208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E39B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeLEUSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:18:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33332 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeLEUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:18:02 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6592F8094D; Wed,  5 Dec 2018 21:17:56 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:17:59 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/10] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20181205201759.GA28800@amd>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <b1a7aa06389ccd46f60db3e63bdf1e9ce9781d49.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <154403090130.88331.18352581261422337586@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-05 09:28:21, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:39:38)
> > diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
> > new file mode 100644
> > index 000000000000..d486859526ed
> > --- /dev/null
> > +++ b/drivers/clk/clk-bd718x7.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c  -- ROHM BD71837MWV clock driver
>=20
> This isn't even the name of the file. Please remove. Also, only the SPDX
> tag is supposed to have // on it and the other things should be normal
> /* */ comment style.

Actually whole block commented by // is now considered ok.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwIMncACgkQMOfwapXb+vKOZwCfZFh8cByPz16glJKlruCOyrXW
f8cAoKTS7UTpBAr8tywOzM2pi7YqIf39
=+GXS
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
