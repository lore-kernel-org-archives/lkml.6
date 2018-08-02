Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577B920895
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dCFdy/3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577B920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbeHBMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:36:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C2eR26YrzddPTdVhhGlDs6gHYB+9/kXqfWSWHvtuk8Y=; b=dCFdy/3mhutM0tqOGYb+QMzjz
        ybquzzvlX36jiGHqF5ZC/EaWf58NvjVTs2F2p0jD5Z3ItPcBS3BEMafabAgShaTZn6fXPf67yZKwO
        3G+YaZEbrFjlnFS11avvwQRqxz6rl/X1goTIWJktxdJUfYcKYPYrahznDq39JT+cJ9oJM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flB64-0001uQ-7C; Thu, 02 Aug 2018 10:44:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BC04611242E7; Thu,  2 Aug 2018 11:44:43 +0100 (BST)
Date:   Thu, 2 Aug 2018 11:44:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180802104443.GH9117@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
In-Reply-To: <20180802103425.3053-4-o.rempel@pengutronix.de>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 12:34:22PM +0200, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).

I thought we'd got an ack for this from Raphael on a previous version or
am I mistaken?

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti4JoACgkQJNaLcl1U
h9DRVggAgz0AKW33j9seRp5nJB5gGs1Gi5SjZMd7GKJLj7Fk6GOZEj4vBxZV+AWc
9F3COPoOWo7sFq2OVhmDw2UgfGWLqI3atHUkkqmk31mrAsHcts6+6AIlGK0z2sii
QrxzJoVm+7vn7ft6OcXu8Z73I5pWvzAHxOA16GNDoJDMxYgXFNjaetpntWq/z0XG
AlgagvG+Tn3ibAP5UxWR2hbfNP9gVxOMz+W784ssF02puTjU/4oY+ZQkDJYuE+Km
gbvLWq6E77+S6cF0CxuKYcqUVv4xcmMsHz0jRJWBSgJBuRG6jQiVCFxzGFy0TFx5
BgMtR9r3+Fze77Wb4fjJURqe0dykNQ==
=YEMF
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
