Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDYHTQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:19:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36314 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751022AbeDYHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:19:14 -0400
X-UUID: 950df49dc5d64ddb8073eb80895fff97-20180425
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
Date: Wed, 25 Apr 2018 15:19:02 +0800
Message-ID: <1524640743-11732-1-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change vs V1:
	fix build warning of 32bit arch

Chaotian Jing (1):
  mmc: mediatek: add 64G DRAM DMA support

 drivers/mmc/host/mtk-sd.c | 56 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

-- 
1.8.1.1.dirty
