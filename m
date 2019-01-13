Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58E82084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfAMLbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:31:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:22351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMLbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:31:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 03:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,473,1539673200"; 
   d="scan'208";a="266762709"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2019 03:31:07 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 2/3] mei: me: mark LBG devices as having dma support
Date:   Sun, 13 Jan 2019 14:24:47 +0200
Message-Id: <20190113122449.7252-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113122449.7252-1-tomas.winkler@intel.com>
References: <20190113122449.7252-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The LBG server platform sports DMA support.

Cc: <stable@vger.kernel.org> #v5.0+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pci-me.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 73ace2d59dea..c2bf3e99955e 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -88,7 +88,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_BXT_M, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
-- 
2.20.1

