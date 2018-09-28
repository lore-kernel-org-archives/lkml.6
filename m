Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C87C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F045B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F045B2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeI1SEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:04:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10523 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729254AbeI1SEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:04:33 -0400
X-UUID: f25488d7c9234db9971b57cbeefe3085-20180928
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 714544435; Fri, 28 Sep 2018 19:41:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Sep 2018 19:41:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 19:41:04 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: mmc: mediatek: add bus_clk control
Date:   Fri, 28 Sep 2018 19:40:53 +0800
Message-ID: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chaotian Jing (2):
  mmc: dt-bindings: add "bus-clk" for MT2712
  mmc: mediatek: add bus_clk control

 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 drivers/mmc/host/mtk-sd.c                        | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
1.8.1.1.dirty

