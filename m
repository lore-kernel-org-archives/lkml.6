Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AAF206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBWRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:39:51 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42364 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBWRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:39:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F20A7FB02;
        Sat, 23 Feb 2019 18:39:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 34hHmWX3CjLy; Sat, 23 Feb 2019 18:39:45 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 28EC3414BA; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
Date:   Sat, 23 Feb 2019 18:39:42 +0100
Message-Id: <600deb9483d6233c2066f721f270f4763e23021a.1550943220.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550943220.git.agx@sigxcpu.org>
References: <cover.1550943220.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ROCKTECH DISPLAYS LIMITED (https://rocktech.com.hk) LCD panel
supplier.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 413c6f30ce88..cc24619a4249 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -338,6 +338,7 @@ ricoh	Ricoh Co. Ltd.
 rikomagic	Rikomagic Tech Corp. Ltd
 riscv	RISC-V Foundation
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
+rocktech	ROCKTECH DISPLAYS LIMITED
 rohm	ROHM Semiconductor Co., Ltd
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
-- 
2.20.1

