Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1CECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6277F20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6277F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJaP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:58:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59266 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeJaP6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:58:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 950EB2000AB;
        Wed, 31 Oct 2018 08:01:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91ABB2000AD;
        Wed, 31 Oct 2018 08:01:45 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E4632402D6;
        Wed, 31 Oct 2018 15:01:37 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     oss@buserror.net
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/2 v3] clk: qoriq: add more compatibles strings
Date:   Wed, 31 Oct 2018 14:57:36 +0800
Message-Id: <20181031065736.32719-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181031065736.32719-1-andy.tang@nxp.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more SoC compatible strings to support more chips.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v3:
  - undo deleting old bindings
  - split the dts and driver to different patchset

 .../devicetree/bindings/clock/qoriq-clock.txt      |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 97f46ad..c655f28 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -28,6 +28,12 @@ Required properties:
 	* "fsl,p4080-clockgen"
 	* "fsl,p5020-clockgen"
 	* "fsl,p5040-clockgen"
+	* "fsl,t1023-clockgen"
+	* "fsl,t1024-clockgen"
+	* "fsl,t1040-clockgen"
+	* "fsl,t1042-clockgen"
+	* "fsl,t2080-clockgen"
+	* "fsl,t2081-clockgen"
 	* "fsl,t4240-clockgen"
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
-- 
1.7.1

