Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbeDWJ1F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:27:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17578 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754078AbeDWJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:27:01 -0400
X-UUID: 4cd664eda6b2405c83a3e66bf4b26cc8-20180423
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Phong LE <ple@baylibre.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, yong mao <yong.mao@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: mmc: mediatek: add 64G DRAM DMA support
Date: Mon, 23 Apr 2018 17:26:49 +0800
Message-ID: <1524475610-22079-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chaotian Jing (1):
  mmc: mediatek: add 64G DRAM DMA support

 drivers/mmc/host/mtk-sd.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

-- 
1.8.1.1.dirty
