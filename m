Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D747C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE28620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="fg3DQf0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE28620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeGaAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:49:03 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55782 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbeGaAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:48:58 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 09CF2B00A99
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:11:42 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532992301; x=1533856302; bh=xT
        z2KyB/RH7HIkARKB6iUIp24bV5Qhsh7X7Ib02AdbI=; b=fg3DQf0Ay45oaN1zBF
        AaBWfdKs7JaO5S4q40VzKuozAYg+jDQapAF94tUXSi7ttmflABlqf7MxcyvlSlZU
        VAo3ZhmhXbf75KYnDl5EYeODVq7hZkJG0wc3Zp6R/HMqkPdRtiuWlq9m+557aCaz
        Bl6XGpONrA2anxKpR+A7Ee9qw=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m7kHOpjc_PGd for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jul 2018 01:11:41 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id A4540B00AA8;
        Tue, 31 Jul 2018 01:11:37 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 5/5] dt-bindings: Add CDTech S043WQ26H-CT7 panel bindings
Date:   Tue, 31 Jul 2018 01:11:17 +0200
Message-Id: <20180730231117.5631-6-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
References: <20180730231117.5631-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for S043WQ26H-CT7 panel

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../bindings/display/panel/cdtech,s043wq26h-ct7.txt  | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt

diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
new file mode 100644
index 000000000000..057f7f3f6dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
@@ -0,0 +1,12 @@
+CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
+
+Required properties:
+- compatible: should be "cdtech,s043wq26h-ct7"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.17.1

