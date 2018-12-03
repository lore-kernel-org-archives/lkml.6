Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE33BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEA620834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLCLhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18067 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbeLCLhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:04 -0500
X-UUID: bfac5ef9f27b49ad9fb4fdb5e949be17-20181203
X-UUID: bfac5ef9f27b49ad9fb4fdb5e949be17-20181203
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1146398381; Mon, 03 Dec 2018 19:36:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:17 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:17 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 0/8] add dts nodes to MT2712 SoC
Date:   Mon, 3 Dec 2018 19:35:54 +0800
Message-ID: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6110A19C6394A3399BCA7BCBB4DE422A7BC4FEAC630546DB70DA5E0B90BCAA042000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series based on v4.20-rc1, include MT2712 usb/iommu/smi/i2c/spi/pwm/mmc/nand/pcie device nodes

Chunfeng Yun (1):
  arm64: dts: Add USB3 related nodes for MT2712

Honghui Zhang (1):
  arm64: dts: add pcie nodes for MT2712

YT Shen (6):
  arm64: dts: add iommu/smi nodes for MT2712
  arm64: dts: add i2c nodes for MT2712
  arm64: dts: add spi nodes for MT2712
  arm64: dts: add pwm nodes for MT2712
  arm64: dts: add mmc nodes for MT2712
  arm64: dts: add nand nodes for MT2712

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  98 +++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 555 ++++++++++++++++++++++++++++
 2 files changed, 653 insertions(+)

-- 
1.9.1

