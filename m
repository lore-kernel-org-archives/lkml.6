Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F2820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mixed-mode.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGXLAr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:00:47 -0400
Received: from mailgate.pixel-group.de ([145.253.133.146]:49242 "EHLO
        mailgate.pixel-group.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388313AbeGXLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:00:46 -0400
Received: from mail.pixel.de (unknown [10.63.25.81])
        by mailgate.pixel-group.de (Postfix) with ESMTP id 7E6565E16D;
        Tue, 24 Jul 2018 11:46:06 +0200 (CEST)
Received: from tragicomix (localhost [127.0.0.1])
        by mail.pixel.de (Postfix) with ESMTP id 4F5101A192;
        Tue, 24 Jul 2018 11:46:06 +0200 (CEST)
Received: from neckar.pixel-group.local (10.63.25.31)
 by tragicomix (F-Secure/fsigk_smtp/550/tragicomix);
 Tue, 24 Jul 2018 11:46:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/tragicomix)
Received: from lippe.pixel-group.local (10.63.25.67) by
 Neckar.pixel-group.local (10.63.25.31) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 11:46:06 +0200
Received: from lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb]) by
 lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb%16]) with mapi id
 15.00.1367.000; Tue, 24 Jul 2018 11:46:05 +0200
From:   Sven Schmitt <Sven.Schmitt@mixed-mode.de>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: [PATCH v3 2/3] soc: imx: gpc: clean up
Thread-Topic: [PATCH v3 2/3] soc: imx: gpc: clean up
Thread-Index: AQHUIzIqZAscYhqrPkWfQiRH5UnoQA==
Date:   Tue, 24 Jul 2018 09:46:05 +0000
Message-ID: <1532425561377.1081@mixed-mode.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.25.69]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused #defines.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 5126185e68c6..35cc1d2dc4d5 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -24,15 +24,11 @@
 #define GPC_PGC_CTRL_OFFS	0x0
 #define GPC_PGC_PUPSCR_OFFS	0x4
 #define GPC_PGC_PDNSCR_OFFS	0x8
-#define GPC_PGC_SW2ISO_SHIFT	0x8
-#define GPC_PGC_SW_SHIFT	0x0
 
 #define GPC_PGC_PCI_PDN		0x200
 #define GPC_PGC_PCI_SR		0x20c
 
 #define GPC_PGC_GPU_PDN		0x260
-#define GPC_PGC_GPU_PUPSCR	0x264
-#define GPC_PGC_GPU_PDNSCR	0x268
 #define GPC_PGC_GPU_SR		0x26c
 
 #define GPC_PGC_DISP_PDN	0x240
-- 
2.17.1

