Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC3C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E35214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E35214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKTTJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:09:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14004 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbeKTTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:09:22 -0500
X-UUID: b28087d61faa4d35be3b88e1f27b3434-20181120
X-UUID: b28087d61faa4d35be3b88e1f27b3434-20181120
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 494848228; Tue, 20 Nov 2018 16:41:19 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 16:41:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 16:41:18 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <ryder.lee@mediatek.com>
Subject: [PATCH 0/2] add SPI driver support for mt7629 
Date:   Tue, 20 Nov 2018 16:41:06 +0800
Message-ID: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3CC14A8660A4CF9266C8F430CB76FB0CD2CAD4A5DB91CF758CE878D602C17F202000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 51ab18abe1ad0f8ef0bc88696d956431f3e01f3f Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 20 Nov 2018 16:34:22 +0800
Subject: [PATCH 0/2] add SPI driver support for mt7629

This series are based on 4.20-rc1 and provide two patches to support mt7629 IC.

Leilk Liu (2):
  spi: mediatek: Add bindings for mediatek MT7629 soc platform
  spi: mediatek: add spi support for mt7629 IC

 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 drivers/spi/spi-mt65xx.c                             | 3 +++
 2 files changed, 4 insertions(+)

-- 
1.9.1

