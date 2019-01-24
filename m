Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829CDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537F7218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548352249;
	bh=2D7cQI0ta04B5vyVxvsPoWdCnHufIZ+39wyBLDSTaz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eUoUMg77TjA85TYNrrhn/yqOVTPLCvLodyh6EuVaY9ORmkayhvdtkcRjAtGNHQvJC
	 1AtMuiFq98NawqLY32EQbpMTZ8KHxQdeeApIGskvXLnGdpYaNAqdDFDfQ+MgowTZ/v
	 Xwbe+IoxoPM5l7Jm6lC7iR5q2eNX+yfvykkEJftM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAXRur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:50:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfAXRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z+lnL8gRAM+Tg8a9b4A7BCpI9nDknC8CsAFk1quCqYM=; b=uJ+FqnO56pWZbsE76CGu2r+3q
        R0RKzCMV20mnih45eVMsM7TWYPAgss4FjejSoHFXc+JM0Lb+3UiFYLe0CxNPRgZMS7sTJOCpL+Zwl
        QlZlCYcX6q5vzc/sac4rfQ+uODzaQzRhQPTP3TJpxvrPKuidrpjCYWTJ60ZHdH6xHvOp4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmj9A-0006Xd-Jo; Thu, 24 Jan 2019 17:50:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 13B121121B6F; Thu, 24 Jan 2019 17:50:36 +0000 (GMT)
Date:   Thu, 24 Jan 2019 17:50:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Petr Cvek <petr.cvek@tul.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul Parsons <lost.distance@yahoo.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/5 v9] regulator: gpio: Convert to use descriptors
Message-ID: <20190124175036.GF5641@sirena.org.uk>
References: <20190121091206.18239-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <20190121091206.18239-1-linus.walleij@linaro.org>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 10:12:02AM +0100, Linus Walleij wrote:
> This converts the GPIO regulator driver to use decriptors only.

This patch breaks the build for me:

drivers/regulator/gpio-regulator.c: In function =E2=80=98gpio_regulator_pro=
be=E2=80=99:
drivers/regulator/gpio-regulator.c:256:33: error: =E2=80=98dev=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98pdev=E2=80=99?
  drvdata->gpiods =3D devm_kzalloc(dev, sizeof(struct gpio_desc *),

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxJ+usACgkQJNaLcl1U
h9C/5wf+LBGJqaa+HC4uOutbjn1VzCOBhC3LQif3WP2tap4z81xU16vOif4DMXbs
ZwdMqCDMVe5atQMHBuCJZjYIStilrHkNaJZVJZZ/+XghtZdQ8y9L7maQ+4HzsF9/
eDiaUMgXglb/XXIFZ7zHMJRoPudv98EmBHQjeEJFE4i16NYOfRA9MhehabYwITBr
PkuEaN1nzGTtHLpZv3+YyksOWbprQNegeYtvZjf2Dt96w2o4EqQB4bZBCIOWaUaP
j09JRQZILfYf1yc2wa05S4Ayc92p8XtvEgeVyuQPNRU3rcRowgqkUJj/Th9Hh/yl
4hMYovNUJBvcarjpvdIrLoFUSY7Nsw==
=e2+r
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
