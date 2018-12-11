Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A406C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274520879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544560624;
	bh=KlMIkDtQRWKeQ2MXIsz7TEsptjrSwkAzyZj5DukjHWc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=J/nkBJN4GUUgBc4wip+zihmFEaHiCeu65ik0lOe+DMJKWhf0aN237cY0KNmZPxnDV
	 rSBNDNFancwrOJTzVt/y8+pg5JdOkuFDJm60aI0pbGWSlDbiQdKs5f5t+w8aQkS9Db
	 4kA/IER0lu9BE0mnH0wdaGVKFo12RCF98iq7XWUk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F274520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeLKUhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:37:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeLKUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=m/U5FBlYCmgY5VOQOXdGknlWVEVfGSSh/ycPSPRipfM=; b=rkuwNxf810hp
        wt/8sQ1dfZVrdvMmcUI5Jolc20oK841ulv2CEEOirdUcVlOookXzpg6qlMDd1RPoomaiNmQBL0z0X
        Os4aKnmaad9PTL7tnVZ1fYenl04/n+maB/IC+TThC2Y4mTH1wc4FCF6IyqsxPXgLETpxlklZ0caXO
        bY/6Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWom2-0001ez-GE; Tue, 11 Dec 2018 20:36:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C79B7112540E; Tue, 11 Dec 2018 20:36:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Clean enabling always-on regulators + their supplies" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211203657.C79B7112540E@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 20:36:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Clean enabling always-on regulators + their supplies

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4c9ed27f79fe4fb46db42dd0c6e69328371f2f3d Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 11 Dec 2018 08:17:19 -0800
Subject: [PATCH] regulator: core: Clean enabling always-on regulators + their
 supplies

At the end of regulator_resolve_supply() we have historically turned
on our supply in some cases.  This could be for one of two reasons:

1. If resolving supplies was happening before the call to
   set_machine_constraints() we needed to predict if
   set_machine_constraints() was going to turn the regulator on and we
   needed to preemptively turn the supply on.
2. Maybe set_machine_constraints() happened before we could resolve
   supplies (because we failed the first time to resolve) and thus we
   might need to propagate an enable that already happened up to our
   supply.

Historically regulator_resolve_supply() used _regulator_is_enabled()
to decide whether to turn on the supply.

Let's change things a little bit.  Specifically:

1. Let's try to enable the supply and the regulator in the same place,
   both in set_machine_constraints().  This means that we have exactly
   the same logic for enabling the supply and the regulator.
2. Let's properly set use_count when we enable always-on or boot-on
   regulators even for those that don't have supplies.  The previous
   commit 1fc12b05895e ("regulator: core: Avoid propagating to
   supplies when possible") only did this right for regulators with
   supplies.
3. Let's make it clear that the only time we need to enable the supply
   in regulator_resolve_supply() is if the main regulator is currently
   in use.  By using use_count (like the rest of the code) to decide
   if we're going to enable our supply we keep everything consistent.

Overall the new scheme should be cleaner and easier to reason about.
In addition to fixing regulator_summary to be more correct (because of
the more correct use_count), this change also has the effect of no
longer using _regulator_is_enabled() in this code path.
_regulator_is_enabled() could return an error code for some regulators
at bootup (like RPMh) that can't read their initial state.  While one
can argue that the design of those regulators is sub-optimal, the new
logic sidesteps this brokenness.  This fix in particular fixes
observed problems on Qualcomm sdm845 boards which use the
above-mentioned RPMh regulator.  Those problems were made worse by
commit 1fc12b05895e ("regulator: core: Avoid propagating to supplies
when possible") because now we'd think at bootup that the SD
regulators were already enabled and we'd never try them again.

Fixes: 1fc12b05895e ("regulator: core: Avoid propagating to supplies when possible")
Reported-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4981ed71686d..925fa0f5d7cb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1356,11 +1356,21 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 	 * and we have control then make sure it is enabled.
 	 */
 	if (rdev->constraints->always_on || rdev->constraints->boot_on) {
+		if (rdev->supply) {
+			ret = regulator_enable(rdev->supply);
+			if (ret < 0) {
+				_regulator_put(rdev->supply);
+				rdev->supply = NULL;
+				return ret;
+			}
+		}
+
 		ret = _regulator_do_enable(rdev);
 		if (ret < 0 && ret != -EINVAL) {
 			rdev_err(rdev, "failed to enable\n");
 			return ret;
 		}
+		rdev->use_count++;
 	}
 
 	if ((rdev->constraints->ramp_delay || rdev->constraints->ramp_disable)
@@ -1822,15 +1832,18 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		return ret;
 	}
 
-	/* Cascade always-on state to supply */
-	if (_regulator_is_enabled(rdev)) {
+	/*
+	 * In set_machine_constraints() we may have turned this regulator on
+	 * but we couldn't propagate to the supply if it hadn't been resolved
+	 * yet.  Do it now.
+	 */
+	if (rdev->use_count) {
 		ret = regulator_enable(rdev->supply);
 		if (ret < 0) {
 			_regulator_put(rdev->supply);
 			rdev->supply = NULL;
 			return ret;
 		}
-		rdev->use_count = 1;
 	}
 
 	return 0;
-- 
2.19.0.rc2

