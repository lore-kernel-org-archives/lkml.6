Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7FBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66E52156B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GRBv6Xe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66E52156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeI1UZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:25:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1UZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tgeG5VXlvGw/wLo4UhrxWtgTQUc+AJNxBVb/M/K/MQQ=; b=GRBv6Xe7rRCy9IHTe0u6vQyNw
        CGiq9ykV8E9GwcGrxth5jYeZGN7XsSZA1umS0qNbk3WIH9C23g003W67GsMUnVgD1AeFMjBiZVK08
        /CAtQAv9DKzGjWzPR/ftg6HRZ8VmBwylgmvyS2vw5/tdl6UP2QX42ih4585OaPWZkZv8E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tKz-0008Vd-GI; Fri, 28 Sep 2018 14:01:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DB265440078; Fri, 28 Sep 2018 15:01:44 +0100 (BST)
Date:   Fri, 28 Sep 2018 15:01:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/7] regulator/mfd: Support ROHM BD71847 power
 management IC
Message-ID: <20180928140144.GN20825@sirena.org.uk>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <3996792a07fea45d94d4d712ed05527199cc4ac0.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <20180921172959.GG20825@sirena.org.uk>
 <20180921180241.GA4358@dell>
 <20180921181217.GI20825@sirena.org.uk>
 <20180921185258.GC4358@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zpx5Rz5PkYgiNBE6"
Content-Disposition: inline
In-Reply-To: <20180921185258.GC4358@dell>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zpx5Rz5PkYgiNBE6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 21, 2018 at 11:52:58AM -0700, Lee Jones wrote:

> > Great, thanks.  There's also the MFD DT bindings and another patch later
> > on with Acked-for-MFD tags on them, should I convert the tags to acks,
> > apply those as well and include them in the pull request?

> Please.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/bd71847-support

for you to fetch changes up to 2ece646c90c5b45dd76c76ea207a3f3459f2c472:

  regulator: bd718xx: rename bd71837 to 718xx (2018-09-28 14:57:13 +0100)

----------------------------------------------------------------
regulator/mfd: Support for the ROHM BD71847

This adds support for the BD71847 which touches both MFD and regulator.
There's a few other bits and pieces included as some dependency patches
had already been applied so would've required rebasing.

----------------------------------------------------------------
Axel Lin (2):
      regulator: isl9305: Add missing .owner field in regulator_desc
      regulator: bd71837: Remove duplicate assignment for n_voltages of LDO2

Marek Szyprowski (1):
      regulator: Fix 'do-nothing' value for regulators without suspend state

Mark Brown (1):
      Merge tag 'regulator-v4.19-rc5' into regulator-bd718xx

Matti Vaittinen (8):
      regulator: bd71837: Disable voltage monitoring for LDO3/4
      regulator/mfd: Support ROHM BD71847 power management IC
      regulator: dt bindings: add BD71847 device-tree binding documentation
      mfd: dt bindings: add BD71847 device-tree binding documentation
      regulator: Support regulators where voltage ranges are selectable
      regulator/mfd: bd718xx: rename bd71837/bd71847 common instances
      regulator: bd718XX use pickable ranges
      regulator: bd718xx: rename bd71837 to 718xx

Philipp Zabel (1):
      regulator: da9063: fix DT probing with constraints

Rob Herring (1):
      regulator: Convert to using %pOFn instead of device_node.name

Yu Zhao (1):
      regulator: fix crash caused by null driver data

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   17 +-
 .../bindings/regulator/rohm,bd71837-regulator.txt  |   12 +-
 drivers/mfd/rohm-bd718x7.c                         |  162 ++-
 drivers/regulator/Kconfig                          |    2 +-
 drivers/regulator/Makefile                         |    2 +-
 drivers/regulator/bd71837-regulator.c              |  626 -----------
 drivers/regulator/bd718x7-regulator.c              | 1138 ++++++++++++++++++++
 drivers/regulator/core.c                           |    9 +-
 drivers/regulator/helpers.c                        |  232 ++++
 drivers/regulator/isl9305.c                        |    4 +
 drivers/regulator/max8997-regulator.c              |    4 +-
 drivers/regulator/mc13xxx-regulator-core.c         |    2 +-
 drivers/regulator/of_regulator.c                   |   46 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   14 +-
 drivers/regulator/s5m8767.c                        |   12 +-
 include/linux/mfd/da9063/pdata.h                   |   16 +-
 include/linux/mfd/rohm-bd718x7.h                   |  374 +++----
 include/linux/regulator/driver.h                   |   20 +-
 include/linux/regulator/machine.h                  |    6 +-
 19 files changed, 1736 insertions(+), 962 deletions(-)
 delete mode 100644 drivers/regulator/bd71837-regulator.c
 create mode 100644 drivers/regulator/bd718x7-regulator.c

--Zpx5Rz5PkYgiNBE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuNEgACgkQJNaLcl1U
h9BndAf9EQPSPGoQ5HopKpVc4DAO6bLNdnhtZip6RXj11RQwLTDC3DVztj9jT0px
RY/q8hSAjeING9M33+IfLHSlIv65hUNdu7uAPTGxLjCpF8/soyG9VtsBgMxIqxLf
yX3CSwiia/UvnzuA8SbOLq3ec5w9lYyGqd5LXKZWr7xWynfqalJGA1bTDXfXRiyT
z9CRaXSI47GMHVOSfBMcROOLs+dU8401ftl+8Dj29kLQ538YRvuEXQcBM6IqGt/s
QPGqh3GJw2+YP4GyK+0BNna2ucwGQ2kX2zHGY3YJbifsmNqDGgQyIQ7MuUtzlMv2
NIFa+Lkn1h024IVZGav7k/iFyeFk2g==
=R/pg
-----END PGP SIGNATURE-----

--Zpx5Rz5PkYgiNBE6--
