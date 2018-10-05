Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D67C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6E3206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6E3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeJETmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:42:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:28567 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:42:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687817"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:35 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 13/16] stm class: SPDX-ify the documentation
Date:   Fri,  5 Oct 2018 15:43:03 +0300
Message-Id: <20181005124306.54870-14-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDX header to the STM class documentation.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/stm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/stm.rst b/Documentation/trace/stm.rst
index 944994fd6368..99f99963e5e7 100644
--- a/Documentation/trace/stm.rst
+++ b/Documentation/trace/stm.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 System Trace Module
 ===================
-- 
2.19.0

