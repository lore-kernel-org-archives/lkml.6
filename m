Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3A0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F6A20849
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F6A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGMOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:01:38 -0400
Received: from mout.web.de ([217.72.192.78]:51225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbeGMOBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:01:37 -0400
Received: from lab-pc04.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Laky4-1gJabw0PPs-00kSmS; Fri, 13 Jul 2018 15:41:20 +0200
From:   =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>
To:     gregkh@linuxfoundation.org
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>,
        Vanessa Borgmann <nessa.x@web.de>
Subject: [PATCH 3/4] staging: mt7621: Add braces around macro argument
Date:   Fri, 13 Jul 2018 15:41:05 +0200
Message-Id: <1531489266-20410-3-git-send-email-oliver.huebers@web.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YCQ6PeXzC6TDoWKZ60GUSfLw/wyoAZSKN7i+4DROvqXiOTte+uM
 ZgVU6p2nFB4Q9aIf7SueVg01Ns0Dughsn9FkgMwt4AUpX72ypZDu2vw+SxqE08hw8tu7tSg
 tpAhyLkp3toIwiLKQhv79L+7NNudngYYzGK/lAk+YEbf0L/7PeLLdZ7gukw9GVrRYSF7hcd
 Q+7zDc2NrG4NXPfIlvEDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g/Hico0JP1U=:qMyQbulk2ZSKE3lobobpcA
 sCl7cNPvDQdElLHPaOz9/p0WS5tzRkxIRCCxpTGj+ru0ysLgTvFk9Aj6TXOI48b7XWlFD8C2d
 h3AdC58q3GqO/9skkwZodtYwYYD/v/fcBYtyaTuqdeolBqvAO5KnLna6qLOdctPRk5pPdWH1D
 8QiJT7b/3Q/In6eRZ4rsIUaRsY1dzqCQiSE6z7Y6NbefyCtfoQNNsiUav2/zNHGaAgxDhqUHY
 JO4UWq7wbESfX4inA6rddNVoCC9MOzEW0+NDY+y8XtRs+JHG8jW1Z+DU6LvK4TPX/N/4qiQ4/
 17k/oVamk9JiC4RKJXvEDtwT5ozbSmbtlUZu5KVH+ybh8MLBRqIZ9LYZzv0zw71gXvN7solKd
 y+/xWVZx8mHMsUoYjJ+74evRSA5TrkI6eSWojfeZnbustCzrfHfsfVeGmO+C1ym/FA0ho2aNN
 /fwrfD48yNPTW8HPAw6L9PehDW355pubWWuO459ujcFwZilsEUJWArcns8q3ZQzuK8JPmKMAq
 dtA9alSUupPUD30YRkzPhV1O8EbRh6/SrE+FdRvX7E49lY386p4UsEe86o9MYs8g8S7qJ3C6Z
 1rqiGiePiqpvTEDKe2el0p3/w3l/8aX5KhEdf5j7vHhBsuzBlCFxePm/7S2gyqKIsacWcheMm
 brCfylE49L3+r1EXWbPI5K2yCK0fajvZ2XQy/v7ZYkLG/52P2LlPwHJ7EIbyJukQFbRfZyYes
 0E2Q6VQckHjIehPzGe818nOxRltQ3ilmY0rs+FfbD1FoTCs0VghcfVAUomJY1wWNsjtVLyrcO
 TLII7Sr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add braces around macro argument to avoid precedence problems.
This fixes the corresponding checkpatch warning.

Signed-off-by: Oliver Hübers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index d0d3fb9..c118d78 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -132,7 +132,8 @@
 		else							\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
 	} while (0)
-#define DEASSERT_SYSRST_PCIE(val)	\
+
+#define DEASSERT_SYSRST_PCIE(val)					\
 	do {								\
 		if (rt_sysc_r32(SYSC_REG_CHIP_REV) == 0x00030101)	\
 			rt_sysc_m32(val, 0, RALINK_RSTCTRL);		\
-- 
2.7.4

