Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B44C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K1sG7K8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCF020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKIUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:53:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55860 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:53:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9BDj2N030529;
        Fri, 9 Nov 2018 05:13:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541762025;
        bh=rUMkrv2E8YA1/3id6btR5UonTa9mHHH3SgTydLT0ESU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K1sG7K8+2BJwJWd1CR9n77WCikRIUH04tZIYZsFs4wWmbYYQB2jGUPn3x5/VkGSnQ
         owIKAOlSdd3cS8dHq2XOPPUIyRprg4+AzGxAiBUWz+PCdppO/alCa1v6hHgKJCs3kR
         KKDclZdV/eXEOacYsFTTQtjq0Fhyat1TmChdm41A=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9BDjDw124390
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 05:13:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 05:13:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 05:13:44 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9BDYsB028715;
        Fri, 9 Nov 2018 05:13:42 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for i2c-omap driver
Date:   Fri, 9 Nov 2018 16:44:12 +0530
Message-ID: <20181109111412.24777-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109111412.24777-1-vigneshr@ti.com>
References: <20181109111412.24777-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add separate entry for i2c-omap and add my name as maintainer for this
driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c78aca287970..284ffe907b31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10808,6 +10808,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-omap2/omap_hwmod.*
 
+OMAP I2C DRIVER
+M:	Vignesh R <vigneshr@ti.com>
+L:	linux-omap@vger.kernel.org
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-omap.txt
+F:	drivers/i2c/busses/i2c-omap.c
+
 OMAP IMAGING SUBSYSTEM (OMAP3 ISP and OMAP4 ISS)
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
-- 
2.19.1

