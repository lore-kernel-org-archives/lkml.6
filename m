Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC771C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8523D25F81
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrRNXokb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8523D25F81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935074AbeF0SHN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934541AbeF0SHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:07:12 -0400
Received: from localhost.localdomain (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E7C25F7B;
        Wed, 27 Jun 2018 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530122831;
        bh=TN1KlOHRYSM18/5JZn1lK2xqN9GKFzgUBFdpAbKdRnE=;
        h=From:To:Subject:Date:From;
        b=FrRNXokbeQlez3rUZaYFJR7zV3Qgv/9jPJyI23w+RIIdVW4TOR4bc/jQlPkKOnrLP
         6DHsFLa8XejpTJ8T+6ifCR8DjfdIyrtUz35QqkEgUbPaUnAdwoit1HVd+bx5BwNjVN
         f7fZ3TC0M+1VQtOwxda5EA8v17TjoTa4txxWfD0Q=
From:   Timur Tabi <timur@kernel.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH] MAINTAINERS: Timur has a kernel.org address
Date:   Wed, 27 Jun 2018 13:07:07 -0500
Message-Id: <20180627180707.16665-1-timur@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi no longer works for Qualcomm, and he now has a kernel.org
email address, so update MAINTAINERS accordingly.

Signed-off-by: Timur Tabi <timur@kernel.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e19ec6d90a44..192e05b8a39a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5669,7 +5669,7 @@ F:	drivers/crypto/caam/
 F:	Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 
 FREESCALE DIU FRAMEBUFFER DRIVER
-M:	Timur Tabi <timur@tabi.org>
+M:	Timur Tabi <timur@kernel.org>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/fsl-diu-fb.*
@@ -5769,7 +5769,7 @@ S:	Maintained
 F:	drivers/net/wan/fsl_ucc_hdlc*
 
 FREESCALE QUICC ENGINE UCC UART DRIVER
-M:	Timur Tabi <timur@tabi.org>
+M:	Timur Tabi <timur@kernel.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/tty/serial/ucc_uart.c
@@ -5793,7 +5793,7 @@ F:	drivers/net/ethernet/freescale/fs_enet/
 F:	include/linux/fs_enet_pd.h
 
 FREESCALE SOC SOUND DRIVERS
-M:	Timur Tabi <timur@tabi.org>
+M:	Timur Tabi <timur@kernel.org>
 M:	Nicolin Chen <nicoleotsuka@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
 R:	Fabio Estevam <fabio.estevam@nxp.com>
@@ -11809,9 +11809,9 @@ F:  Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
 F:  drivers/cpufreq/qcom-cpufreq-kryo.c
 
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
-M:	Timur Tabi <timur@codeaurora.org>
+M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/qualcomm/emac/
 
 QUALCOMM HEXAGON ARCHITECTURE
-- 
2.17.1

