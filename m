Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85B21C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F61F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F61F208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964875AbeFNKtD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:49:03 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60463 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964815AbeFNKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:49 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 23B7820006;
        Thu, 14 Jun 2018 10:48:52 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc:     linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 6/6] iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings
Date:   Thu, 14 Jun 2018 12:48:26 +0200
Message-Id: <1528973306-7962-7-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the IPMMU DT binding documentation to include the compat strings
for the IPMMU devices included in the R-Car V3H and E3 SoCs.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 8d145a4..c6e2d85 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -21,6 +21,8 @@ Required Properties:
     - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
     - "renesas,ipmmu-r8a77965" for the R8A77965 (R-Car M3-N) IPMMU.
     - "renesas,ipmmu-r8a77970" for the R8A77970 (R-Car V3M) IPMMU.
+    - "renesas,ipmmu-r8a77980" for the R8A77980 (R-Car V3H) IPMMU.
+    - "renesas,ipmmu-r8a77990" for the R8A77990 (R-Car E3) IPMMU.
     - "renesas,ipmmu-r8a77995" for the R8A77995 (R-Car D3) IPMMU.
     - "renesas,ipmmu-vmsa" for generic R-Car Gen2 or RZ/G1 VMSA-compatible
 			   IPMMU.
-- 
2.7.4

