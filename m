Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC7920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="maTgvVm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC7920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGTVtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:49:03 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41266 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbeGTVtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:49:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2D90924E2524;
        Fri, 20 Jul 2018 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532120344; bh=Y7V9DRz2YL7IiDcJf4b7iX7XLOjAmb6Vr3H4lUuEaxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maTgvVm4uMtmfdlKQO8LlwyQH4mH6HUFhDj3aKRADcP/mMQIKt8zVectCK+NTz2Uy
         1tGgq2tHFC+5ITJNMhNNTlCXg+oMgPB7ZkrjS4oI0a3cCEn/RwTT6BGtN4bfdNQN81
         LhfUm7EMchggI1p8QH8OcX++Hs1iFVW5ewKLLMeX22DpHn7X6K0BNfwXoBPsnv4BqZ
         S6t33W36HmGzArPdx2Mk7HMNC3aRrrk25OTH4u0ixL2q0vIRUvigTyhIUbqHTKvCOK
         D5Onaiimp0KAn5ri3sTG70RQwfVpNz+YJEIOR+Ye79YsGOZM6qAhDs6r76YXYPcOv8
         VuqoVpNT8wl8g==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.25.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id ED1E45C12;
        Fri, 20 Jul 2018 13:58:57 -0700 (PDT)
From:   Vitor soares <Vitor.Soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
Subject: [PATCH 3/3] MAINTAINERS: Add myself as the dw-i3c-master module maintainer
Date:   Fri, 20 Jul 2018 21:57:52 +0100
Message-Id: <1532120272-17157-4-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor soares <soares@synopsys.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3e3cb2..d284ba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6773,6 +6773,12 @@ F:	drivers/i3c/
 F:	include/linux/i3c/
 F:	include/dt-bindings/i3c/
 
+I3C DRIVER FOR SYNOPSYS DESIGNWARE
+M:	Vitor Soares <soares@synopsys.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	drivers/i3c/master/dw*
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.7.4


