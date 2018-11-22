Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C53C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DAD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DAD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394583AbeKVVu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394543AbeKVVu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:12:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290804"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:12:01 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 6/7] mei: bump hbm version to 2.1
Date:   Thu, 22 Nov 2018 13:11:41 +0200
Message-Id: <20181122111142.18653-7-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181122111142.18653-1-tomas.winkler@intel.com>
References: <20181122111142.18653-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Bump HBM version to 2.1 to indicate DMA transfer support.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index acbccb8dba34..2b7f7677f8cc 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -35,7 +35,7 @@
 /*
  * MEI Version
  */
-#define HBM_MINOR_VERSION                   0
+#define HBM_MINOR_VERSION                   1
 #define HBM_MAJOR_VERSION                   2
 
 /*
-- 
2.17.2

