Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D71206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D71206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbeKMWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:40:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54930 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733010AbeKMWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:40:15 -0500
Received: from wd0155.dip.tu-dresden.de ([141.76.108.155] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gMY1D-0001YD-Vt; Tue, 13 Nov 2018 13:42:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH] dt-bindings: display: add binding for Innolux ee101ia-01d panel
Date:   Tue, 13 Nov 2018 13:42:05 +0100
Message-Id: <20181113124205.29319-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

This is a panel handled through the generic lvds-panel binding,
so only needs its additional compatible specified.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 .../bindings/display/panel/innolux,ee101ia-01d.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
new file mode 100644
index 000000000000..e5ca4ccd55ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
@@ -0,0 +1,7 @@
+Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
+
+Required properties:
+- compatible: should be "innolux,ee101ia-01d"
+
+This binding is compatible with the lvds-panel binding, which is specified
+in panel-lvds.txt in this directory.
-- 
2.18.0

