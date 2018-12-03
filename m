Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD720661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeLCVd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:33:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43610 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeLCVdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:33:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so12339922oie.10;
        Mon, 03 Dec 2018 13:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgwOjYGaUM4jacGS7tw342B/DTF9EbMnkpVRYFr+pqY=;
        b=RuRKXbRjD7BpvD+A8o4MaOKColH97Vzl8CBuG5ZAaC8ZczRGi2qn3MQmsv6r9tSDsu
         FgSxh3n9STqBJo3HUBrkPjoVvi1XPm6LZ5Wt8G3W7v768fSr8n6PAsgvj/uez23WJAu0
         w+dxfkDpThtU1z4ufuOeLQZqtqqZreuJQbDQVdJcmKP1SBh6/JMGcCqBWGt+uBnyTxEt
         CFfPDSC71z6hvniG13iPDnoiSrRn8GmcsgvEg+s2g6ZgaEB5iU+pBvzBtNz0mx/932Ou
         lwoxSNsxjVZyhb++ln9ScEy5Tut1Rx/F3VOH7SR1kOAI6yiFA1kGmtbX3CmBQeNZ3E+y
         lQNA==
X-Gm-Message-State: AA+aEWYMlM4TMclYms8hicZgamQUouj+Lz46r0tAXMFA820qevsyU3O3
        +lO4M9rTf11nKaOcJ/RQqhKWqHs=
X-Google-Smtp-Source: AFSGD/VgCUDrNHBT/uGjxuTWorLqCSCE7WshaNATuumRyWinarPM3J+GZiUM/gI/C1Xz4hhKTjWr0g==
X-Received: by 2002:aca:e283:: with SMTP id z125mr10414602oig.23.1543872785413;
        Mon, 03 Dec 2018 13:33:05 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:33:04 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 33/34] dt-bindings: arm: Add missing Xilinx boards
Date:   Mon,  3 Dec 2018 15:32:22 -0600
Message-Id: <20181203213223.16986-34-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Add missing description for Ultra96, zcu104, zcu106 and zcu111.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.yaml       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index 64cd21b737af..c73b1f5c7f49 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -70,6 +70,14 @@ properties:
           - const: xlnx,zynqmp-zcu100
           - const: xlnx,zynqmp
 
+      - description: Xilinx 96boards compatible board Ultra96
+        items:
+          - const: avnet,ultra96-rev1
+          - const: avnet,ultra96
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
       - description: Xilinx evaluation board zcu102
         items:
           - enum:
@@ -79,4 +87,28 @@ properties:
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
+      - description: Xilinx evaluation board zcu104
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu104-revA
+              - xlnx,zynqmp-zcu104-rev1.0
+          - const: xlnx,zynqmp-zcu104
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu106
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu106-revA
+              - xlnx,zynqmp-zcu106-rev1.0
+          - const: xlnx,zynqmp-zcu106
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu111
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu111-revA
+              - xlnx,zynqmp-zcu11-rev1.0
+          - const: xlnx,zynqmp-zcu111
+          - const: xlnx,zynqmp
+
 ...
-- 
2.19.1

