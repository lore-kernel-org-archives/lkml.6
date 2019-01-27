Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA758C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5C217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfA0Ll5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:41:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:60620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbfA0Ll5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:41:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69F39ABDC;
        Sun, 27 Jan 2019 11:41:56 +0000 (UTC)
Date:   Sun, 27 Jan 2019 12:41:54 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for 5.0
Message-ID: <20190127114154.GB3916@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull this single fix for Altera EDAC below.

Thx.

---
The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fix_for_5.0

for you to fetch changes up to 245b6c6558128327d330549b23d09594c46f58df:

  EDAC, altera: Fix S10 persistent register offset (2019-01-24 17:13:59 +0100)

----------------------------------------------------------------
Fix persistent register offsets of altera_edac, from Thor Thayer.

----------------------------------------------------------------
Thor Thayer (1):
      EDAC, altera: Fix S10 persistent register offset

 drivers/edac/altera_edac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 4213cb0bb2a7..f8664bac9fa8 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -295,8 +295,8 @@ struct altr_sdram_mc_data {
 #define S10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
 
 /* Sticky registers for Uncorrected Errors */
-#define S10_SYSMGR_UE_VAL_OFST            0x120
-#define S10_SYSMGR_UE_ADDR_OFST           0x124
+#define S10_SYSMGR_UE_VAL_OFST            0x220
+#define S10_SYSMGR_UE_ADDR_OFST           0x224
 
 #define S10_DDR0_IRQ_MASK                 BIT(16)
 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
