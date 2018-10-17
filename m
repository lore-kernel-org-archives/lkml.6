Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C2C5ACD0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F622151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F622151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJQOpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:45:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:4116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeJQOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:45:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="79371271"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2018 23:50:48 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v6 14/20] tpm: tpm-space.c remove unneeded semicolon
Date:   Wed, 17 Oct 2018 09:46:07 +0300
Message-Id: <20181017064613.19746-15-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017064613.19746-1-tomas.winkler@intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon in tpm2_map_response_header()

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4-V6: Resend.

 drivers/char/tpm/tpm2-space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index d2e101b32482..dcdfde3c253e 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -373,7 +373,7 @@ static int tpm2_map_response_header(struct tpm_chip *chip, u32 cc, u8 *rsp,
 		dev_err(&chip->dev, "%s: unknown handle 0x%08X\n",
 			__func__, phandle);
 		break;
-	};
+	}
 
 	return 0;
 out_no_slots:
-- 
2.14.4

