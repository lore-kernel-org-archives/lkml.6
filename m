Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F900C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F82520854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F82520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeILS5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:57:37 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:53855 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbeILS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:57:37 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 12 Sep 2018 22:52:58 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id B2E4E87677;
        Wed, 12 Sep 2018 22:52:58 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,364,1531753200"; 
   d="scan'208";a="290751382"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 12 Sep 2018 22:52:53 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: enable R8A774C0 SoC
Date:   Wed, 12 Sep 2018 14:52:50 +0100
Message-Id: <1536760371-17300-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Renesas RZ/G2E (R8A774C0) SoC in the ARM64 defconfig.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch applies on top of next-20180912

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 47d7665..a8bce1b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -51,6 +51,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
+CONFIG_ARCH_R8A774C0=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
-- 
2.7.4

