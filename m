Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04941C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FCA2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FCA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeHNRqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:46:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:28132 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbeHNRqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:46:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 07:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="scan'208";a="62332412"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.90])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2018 07:58:32 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
Date:   Tue, 14 Aug 2018 17:57:48 +0300
Message-Id: <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a TPM maintainer I have to review all these commits. This commit is
just to make that documented.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3119bba7971c..4b51c13ae2d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7928,6 +7928,7 @@ F:	security/keys/encrypted-keys/
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.vnet.ibm.com>
 M:	Mimi Zohar <zohar@linux.vnet.ibm.com>
+M:	Jarkko Sakkkinen <jarkko.sakkinen@linux.intel.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.17.1

