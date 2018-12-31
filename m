Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5424C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480721019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546285367;
	bh=kqzqwoV99iJvHWKyk7Yl2s8AGP2WbHVYqE6DI1BWguE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TmSGuzf1eHfK2h7XSDk30zWdeCBdqBqd+QUq6hhbBRYNlNfLVbrpIGtOKgu/JBPvZ
	 J36IAmZmDVsYjx0QkNyVwIrWujOvBUXBttCWRrF+EFMVe5GL0XohEr/8uwSnRqCm2k
	 FFWIhyEykcm47aYPBlFqOSfLrcQWhCZoeLoLtYGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeLaTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:42:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeLaTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZL2kTmtvJE0WTVN2vNIh+PyhYJ626nlPpU66YvCE9ro=; b=FBisLJKrnOgf
        XMOLxIbcZjooCjvvnIpWyR5rYxAwLsFSzYyL9Fuk1mb7NEug7TnAvNs9VdE4veYmV0xIXo6hFGSVI
        EWgCNvO+QpMwBqJyT0/N2MvZBP+8NdEPuM/v9/E6BZIogGWXiq1RW0q7hj5VqDjhm1WxMUHsRNvLb
        xaBds=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge3SR-0002n1-0A; Mon, 31 Dec 2018 19:42:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 69BDA440080; Mon, 31 Dec 2018 19:42:38 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Set up correct .data field for "cirrus,lochnagar2-mic2vdd"" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181231194238.69BDA440080@finisterre.ee.mobilebroadband>
Date:   Mon, 31 Dec 2018 19:42:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Set up correct .data field for "cirrus,lochnagar2-mic2vdd"

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

From 4cac31e2be6e569bd55f936e662d2d146325b74c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 29 Dec 2018 19:40:47 +0800
Subject: [PATCH] regulator: lochnagar: Set up correct .data field for
 "cirrus,lochnagar2-mic2vdd"

Fix trival copy-n-paste mistake.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 5a89e6d4b9a6..818d20410518 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -226,7 +226,7 @@ static const struct of_device_id lochnagar_of_match[] = {
 	},
 	{
 		.compatible = "cirrus,lochnagar2-mic2vdd",
-		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC2VDD],
 	},
 	{
 		.compatible = "cirrus,lochnagar2-vddcore",
-- 
2.20.1

