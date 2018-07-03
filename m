Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA602C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888FD245A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888FD245A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeGCOF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:05:28 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37858 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753411AbeGCOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:05:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE20620009D;
        Tue,  3 Jul 2018 16:05:25 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B17F720008D;
        Tue,  3 Jul 2018 16:05:25 +0200 (CEST)
Received: from fsr-ub1464-140.ea.freescale.net (fsr-ub1464-140.ea.freescale.net [10.171.82.90])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 57216205E7;
        Tue,  3 Jul 2018 16:05:25 +0200 (CEST)
From:   Razvan Stefanescu <razvan.stefanescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ruxandra.radulescu@nxp.com,
        ioana.ciornei@nxp.com
Subject: [PATCH] staging: fsl-dpaa2/ethsw: Update maintainers for Ethernet Switch driver
Date:   Tue,  3 Jul 2018 17:05:24 +0300
Message-Id: <1530626724-20833-1-git-send-email-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: razvan.stefanescu@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6d0cc0..0d36546 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4434,7 +4434,8 @@ S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethernet
 
 DPAA2 ETHERNET SWITCH DRIVER
-M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
+M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
+M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethsw
-- 
1.9.1

