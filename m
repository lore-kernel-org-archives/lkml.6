Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589AA2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wyrzutw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbeLQMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:20:49 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44090 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbeLQMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:20:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCKLdh113197;
        Mon, 17 Dec 2018 06:20:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545049221;
        bh=7eOpV1wW9EeOAnz1HBRRtYjoz75kvtXFwptNxeaxoFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wyrzutw/RAx6uL6Z5fcPgj+k8M0iEvna9Qh9WibhV5BLeQG0HINayC7nXVrm0KFaW
         XzVubryxe8FRQcnYtFNTubK/wn/61fqjxIQwtltZBatlPJbU9C5O6DkUDNcSV1o4wR
         W9nNxYOKyqXF6kNCm72DiCmw7dJShYDfYNd1eKaw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCKLPr100792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 06:20:21 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:20:21 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:20:21 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXU023433;
        Mon, 17 Dec 2018 06:20:18 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 8/9] ARM: davinci_all_defconfig: Update the audio options
Date:   Mon, 17 Dec 2018 14:21:41 +0200
Message-ID: <20181217122142.6652-9-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new options for default audio support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 07b2eadac3dd..207962a656a2 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -167,8 +167,9 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_EDMA_SOC=m
-CONFIG_SND_DA850_SOC_EVM=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_DAVINCI_EVM=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
 CONFIG_HID_A4TECH=m
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

