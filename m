Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B6C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255620837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E255620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934258AbeGDIRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:17:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43828 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932346AbeGDIRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:17:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B261200102;
        Wed,  4 Jul 2018 10:17:45 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E0902000EC;
        Wed,  4 Jul 2018 10:17:45 +0200 (CEST)
Received: from fsr-ub1464-140.ea.freescale.net (fsr-ub1464-140.ea.freescale.net [10.171.82.90])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1397F205F4;
        Wed,  4 Jul 2018 10:17:45 +0200 (CEST)
From:   Razvan Stefanescu <razvan.stefanescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ruxandra.radulescu@nxp.com,
        ioana.ciornei@nxp.com
Subject: [PATCH v2] staging: fsl-dpaa2/ethsw: Update maintainers for Ethernet Switch driver
Date:   Wed,  4 Jul 2018 11:17:44 +0300
Message-Id: <1530692264-1820-1-git-send-email-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 1.9.1
Reply-to: razvan.stefanescu@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing myself as the maintainer for this driver and adding Ioana R.
and Ioana C.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Acked-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changelog
 v2
	- add commit message and ack lines

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

