Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfAOMks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:40:48 -0500
Received: from mx1.emlix.com ([46.4.235.150]:44190 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbfAOMkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:40:47 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D2F7C25F126;
        Tue, 15 Jan 2019 13:31:22 +0100 (CET)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, philipp.puschmann@emlix.com
Subject: [PATCH 1/2] dt-bindings: usb: ci-hdrc-usb2: add property power-active-high
Date:   Tue, 15 Jan 2019 13:31:12 +0100
Message-Id: <20190115123113.20577-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index adae82385dd6..8696e3eff6e7 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -93,6 +93,7 @@ i.mx specific properties
 - over-current-active-low: over current signal polarity is active low.
 - over-current-active-high: over current signal polarity is active high.
   It's recommended to specify the over current polarity.
+- power-active-high: power signal polarity is high active (only for imx6q/dl)
 - external-vbus-divider: enables off-chip resistor divider for Vbus
 
 Example:
-- 
2.20.1

