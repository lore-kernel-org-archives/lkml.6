Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14AEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A613A20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A613A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIDUYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbeIDUYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF2C2B09F;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/29] staging: bcm2835-audio: Clean up include files in bcm2835-ctl.c
Date:   Tue,  4 Sep 2018 17:58:32 +0200
Message-Id: <20180904155858.8001-4-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a few of them are really needed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c     | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index 9020887e1ada..1c5a87580978 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -1,23 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/jiffies.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/wait.h>
-#include <linux/delay.h>
-#include <linux/moduleparam.h>
-#include <linux/sched.h>
-
 #include <sound/core.h>
 #include <sound/control.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/rawmidi.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/asoundef.h>
 
-- 
2.18.0

