Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C16ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD56521529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD56521529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbeITS3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:56674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387721AbeITS3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820953"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:32 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 14/16] stm class: heartbeat: Fix whitespace
Date:   Thu, 20 Sep 2018 15:45:51 +0300
Message-Id: <20180920124553.56978-15-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace in the code for better readability, no functional changes.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 7db42395e131..3e7df1c0477f 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -76,7 +76,7 @@ static int stm_heartbeat_init(void)
 			goto fail_unregister;
 
 		stm_heartbeat[i].data.nr_chans	= 1;
-		stm_heartbeat[i].data.link		= stm_heartbeat_link;
+		stm_heartbeat[i].data.link	= stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	= stm_heartbeat_unlink;
 		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_ABS);
-- 
2.18.0

