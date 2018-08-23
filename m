Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078DBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E0A2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E0A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeHWMLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbeHWMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D57F7F6;
        Thu, 23 Aug 2018 08:42:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 040/324] arm64: dts: specify 1.8V EMMC capabilities for bcm958742t
Date:   Thu, 23 Aug 2018 09:51:46 +0200
Message-Id: <20180823074957.830023611@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Branden <scott.branden@broadcom.com>

[ Upstream commit 37c2bd81a86ebb1cc934bf52a29c33d6f9abff7f ]

Specify 1.8V EMMC capabilities for bcm958742t board to indicate support
for UHS mode.

Fixes: d4b4aba6be8a ("arm64: dts: Initial DTS files for Broadcom Stingray SOC")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
@@ -42,3 +42,7 @@
 &gphy0 {
 	enet-phy-lane-swap;
 };
+
+&sdio0 {
+	mmc-ddr-1_8v;
+};


