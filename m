Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85CE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeLNPyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:54:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:15172 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbeLNPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:54:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 07:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,353,1539673200"; 
   d="scan'208";a="283602007"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2018 07:54:15 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 2/3] stm class: Add a reference to the SyS-T document
Date:   Fri, 14 Dec 2018 17:53:46 +0200
Message-Id: <20181214155347.75722-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214155347.75722-1-alexander.shishkin@linux.intel.com>
References: <20181214155347.75722-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4cb3653df0cd ("stm class: Document the MIPI SyS-T protocol usage")
added a document describing the SyS-T protocol usage, but forgot to add
it to the directory index. Fix that.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 4cb3653df0cd ("stm class: Document the MIPI SyS-T protocol usage")
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 306997941ba1..6b4107cf4b98 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -22,3 +22,4 @@ Linux Tracing Technologies
    hwlat_detector
    intel_th
    stm
+   sys-t
-- 
2.19.2

