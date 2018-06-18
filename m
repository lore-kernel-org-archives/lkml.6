Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F325C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564E220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeFRIQe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:16:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934284AbeFRIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83DD9C77;
        Mon, 18 Jun 2018 08:16:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 019/279] dt-bindings: pinctrl: sunxi: Fix reference to driver
Date:   Mon, 18 Jun 2018 10:10:04 +0200
Message-Id: <20180618080609.601773145@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matheus Castello <matheus@castello.eng.br>

[ Upstream commit b614e905a0bc8fc5d4fa72665ac26ae00c874a4e ]

Bindings describe hardware, not drivers.
Use reference to hardware Allwinner A1X Pin Controller instead driver.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -55,9 +55,9 @@ pins it needs, and how they should be co
 configuration, drive strength and pullups. If one of these options is
 not set, its actual value will be unspecified.
 
-This driver supports the generic pin multiplexing and configuration
-bindings. For details on each properties, you can refer to
-./pinctrl-bindings.txt.
+Allwinner A1X Pin Controller supports the generic pin multiplexing and
+configuration bindings. For details on each properties, you can refer to
+ ./pinctrl-bindings.txt.
 
 Required sub-node properties:
   - pins


