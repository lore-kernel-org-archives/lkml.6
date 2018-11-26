Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5782147D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="btGs9tp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5782147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeKZV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbeKZV52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F5A20672;
        Mon, 26 Nov 2018 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230223;
        bh=b9RdiHVSZ0J0auGr7DmV8czL2gJAVio87ga0D94Mxmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btGs9tp+EQdMPtVd13fnfKLD7gWEGLQIEYX7a+LWSo6lTVJLcSbd8udNQ/uGB2Wd/
         olb8iqzbga6J1puGxbBH1A8CR1Huf5bsdfmIFDtHFCexjVzXyJ9dWdHiz4uGZ0GJna
         ZBP7M7VmUnVuixV1+jE3kqzjzWceUoFj+KgaOfII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/118] ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node
Date:   Mon, 26 Nov 2018 11:50:49 +0100
Message-Id: <20181126105103.023220808@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 438ad09af5581b7024850b5dbb6353c7f2f7d8a9 ]

Fix the type of compatible string "fs,imx6sll-i2c" which should be
"fsl,imx6sll-i2c".

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 000e6136a9d6..3e6ffaf5f104 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -709,7 +709,7 @@
 			i2c1: i2c@21a0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fs,imx6sll-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
 				reg = <0x021a0000 0x4000>;
 				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_I2C1>;
-- 
2.17.1



