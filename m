Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F3C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C693A216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C693A216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeHCE56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:57:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:48918 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeHCE56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:57:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="78325507"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2018 20:03:47 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel MIPS SoCs
Date:   Fri,  3 Aug 2018 11:02:24 +0800
Message-Id: <20180803030237.3366-6-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hua Ma <hua.ma@linux.intel.com>

This patch adds binding documentation for the
compatible values of the Intel MIPS SoCs.

Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2:
- New patch split from previous patch
- Add the board and chip compatible in dt document

 Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

diff --git a/Documentation/devicetree/bindings/mips/intel.txt b/Documentation/devicetree/bindings/mips/intel.txt
new file mode 100644
index 000000000000..ac594ef303b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/intel.txt
@@ -0,0 +1,17 @@
+Intel MIPS SoC device tree bindings
+
+1, SoCs
+
+Each device tree must specify a compatible value for the Intel SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,xrx500
+
+2, Boards
+
+Each device tree must specify a compatible value for the Intel Board
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,easy350-anywan
-- 
2.11.0

