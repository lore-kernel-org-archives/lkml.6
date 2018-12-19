Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE90C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817D52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeLSNLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:37 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:38667 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbeLSNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:36 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 338F14002F;
        Wed, 19 Dec 2018 14:05:07 +0100 (CET)
Received: from orc.pedanet (c-17f4e255.26241707-0-68616c6d7374616473746164736e6174.bbcust.telenor.se [85.226.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id D24D140005;
        Wed, 19 Dec 2018 14:05:06 +0100 (CET)
From:   Peter Rosin <peda@lysator.liu.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: display: bridge: lvds-transmitter: cleanup example
Date:   Wed, 19 Dec 2018 14:04:48 +0100
Message-Id: <20181219130449.31641-3-peda@lysator.liu.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219130449.31641-1-peda@lysator.liu.se>
References: <20181219130449.31641-1-peda@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Drop #address-cells and #size-cells from the root node in the
example, they are unused.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..36ce07c8d8e6 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -38,8 +38,6 @@ Example
 
 lvds-encoder {
 	compatible = "lvds-encoder";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	ports {
 		#address-cells = <1>;
-- 
2.11.0

