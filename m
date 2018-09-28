Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B02C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AB1206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ujQHFgCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AB1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeI2FM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:12:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44622 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2FM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:12:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SMkIaZ083239;
        Fri, 28 Sep 2018 17:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538174778;
        bh=qH20WXVDz+vpZNryAzTXxQ/Mqme50/sHKY0QaPnUg/4=;
        h=From:To:CC:Subject:Date;
        b=ujQHFgCfgwWsVNWebXKqTfldo/xUXbpu6xbWFZqelTlWX8Z6HximLNkD7l6ozZMwW
         2k0rFsNTjhip7hHsHxqI7/7a6NOKC0YS6w0yLI8BCM3VMl6J9Y5PDy4fuvDXUX+tpz
         00q0hYgBJucridyTvdbv692TEeG/kpz054bDT6uc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SMkIlh030582;
        Fri, 28 Sep 2018 17:46:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 17:46:18 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 17:46:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SMkHsC001089;
        Fri, 28 Sep 2018 17:46:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] MAINTAINERS: Drop dt-bindings/genpd/k2g.h
Date:   Fri, 28 Sep 2018 17:46:15 -0500
Message-ID: <20180928224615.19862-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop include/dt-bindings/genpd/k2g.h which disappeared from kernel tree
some time back, however MAINTAINERS file was missed to be updated.

Fixes: d16645054d2f ("dt-bindings: Drop k2g genpd device ID macros")
Cc: Rob Herring <robh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

A big oops.. Sorry about that. will do better next time. I tried to relook and
I think we have'nt missed any other files.

Based off next-20180928 tag.

Santosh, any chance you could pick this up -> Thread:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1776470.html

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c62b724bb60..633aa6385e37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14550,7 +14550,6 @@ F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	drivers/firmware/ti_sci*
 F:	include/linux/soc/ti/ti_sci_protocol.h
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
-F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
 F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
-- 
2.15.1

