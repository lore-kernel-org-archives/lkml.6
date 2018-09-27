Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A5E21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A5E21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeI0ReF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:34:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38142 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbeI0ReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:34:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 34EE61A029F;
        Thu, 27 Sep 2018 13:16:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D16D01A02CA;
        Thu, 27 Sep 2018 13:16:13 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2FC91402EE;
        Thu, 27 Sep 2018 19:16:08 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/2] MAINTAINERS: update files maintained under DPAA2 PTP/ETHERNET
Date:   Thu, 27 Sep 2018 19:12:28 +0800
Message-Id: <20180927111228.46118-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180927111228.46118-1-yangbo.lu@nxp.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files maintained under DPAA2 PTP/ETHERNET needs to
be updated since dpaa2 ptp driver had been moved into
drivers/net/ethernet/freescale/dpaa2/.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 MAINTAINERS |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15565de..ba6f441 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4530,7 +4530,11 @@ DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/freescale/dpaa2
+F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-eth*
+F:	drivers/net/ethernet/freescale/dpaa2/dpni*
+F:	drivers/net/ethernet/freescale/dpaa2/dpkg.h
+F:	drivers/net/ethernet/freescale/dpaa2/Makefile
+F:	drivers/net/ethernet/freescale/dpaa2/Kconfig
 
 DPAA2 ETHERNET SWITCH DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
@@ -4541,9 +4545,10 @@ F:	drivers/staging/fsl-dpaa2/ethsw
 
 DPAA2 PTP CLOCK DRIVER
 M:	Yangbo Lu <yangbo.lu@nxp.com>
-L:	linux-kernel@vger.kernel.org
+L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-dpaa2/rtc
+F:	drivers/net/ethernet/freescale/dpaa2/rtc*
+F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
-- 
1.7.1

