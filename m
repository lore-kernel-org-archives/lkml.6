Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lrJwI/ZSGFtoZgAAmS7hNA
	; Wed, 06 Jun 2018 21:32:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F217608BA; Wed,  6 Jun 2018 21:32:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 009B1607F7;
	Wed,  6 Jun 2018 21:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 009B1607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFFVcg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:32:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:11662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeFFVce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:32:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 14:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="47331294"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2018 14:32:33 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 1/2] mei: remove unused MEI_IAMTHIF_STALL_TIMER define
Date: Thu,  7 Jun 2018 00:31:47 +0300
Message-Id: <20180606213148.9469-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606213148.9469-1-tomas.winkler@intel.com>
References: <20180606213148.9469-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

MEI_IAMTHIF_STALL_TIMER is unused now and can be safely removed.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 5c8286b40b62..3b325d955fbe 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -28,8 +28,6 @@
 #define MEI_CL_CONNECT_TIMEOUT     15  /* HPS: Client Connect Timeout */
 #define MEI_CLIENTS_INIT_TIMEOUT   15  /* HPS: Clients Enumeration Timeout */
 
-#define MEI_IAMTHIF_STALL_TIMER    12  /* HPS */
-
 #define MEI_PGI_TIMEOUT             1  /* PG Isolation time response 1 sec */
 #define MEI_D0I3_TIMEOUT            5  /* D0i3 set/unset max response time */
 #define MEI_HBM_TIMEOUT             1  /* 1 second */
-- 
2.14.4
