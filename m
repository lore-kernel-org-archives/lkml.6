Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F87C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583FC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RGQH/A5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583FC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbeJ2S4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:56:24 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:35618 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeJ2S4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:56:24 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 23AF310C1326;
        Mon, 29 Oct 2018 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540807705; bh=PEXOwxWnNnXhAQvDzEx4CSincLH2//m/s5VHGGoGZJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGQH/A5smwRopEA7q7dtR/CVrReb13fiP0+pyG9K6wsHynKY3m3HMM98oXFwcXOIq
         kAuvc3YK3qmzwVgyoOguGcJBWBEGRjvD6QRzzMVRue0dWR0DLBAz2Nq/wY04GSWApu
         CGIOE23FBCa2N3SmpUix7r7NgLtoHDSzldBG3VkRqGKURiTC/LJzSlBTiJQvuk7IQc
         unuCRxg9wFoCGU76Ai8eyEMSyylFRoWbjYpZKeFyksxHagWtz9cQq57b9IO72aa04b
         Tc3Q7N3M7q7ogjHI/NDHu4PpMPmQVTmV+xYZnFqv0TPv71953rnrdx6iM8Ne/soFN6
         cDbgEtnuw+Apg==
Received: from localhost.localdomain (soares-e7470.internal.synopsys.com [10.225.2.39])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0694A5573;
        Mon, 29 Oct 2018 03:08:15 -0700 (PDT)
From:   Vitor soares <vitor.soares@synopsys.com>
To:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com,
        bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com,
        cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vitor.soares@synopsys.com, geert@linux-m68k.org,
        linus.walleij@linaro.org, Xiang.Lin@synaptics.com,
        linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com,
        peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: [PATCH 3/3] MAINTAINERS: Add myself as the dw-i3c-master module maintainer
Date:   Mon, 29 Oct 2018 10:06:58 +0000
Message-Id: <1540807618-13246-4-git-send-email-soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540807618-13246-1-git-send-email-soares@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor soares <soares@synopsys.com>
---
Change in v2:
-None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 293c863..38c2760 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6930,6 +6930,12 @@ F:	drivers/i3c/
 F:	include/linux/i3c/
 F:	include/dt-bindings/i3c/
 
+I3C·DRIVER·FOR·SYNOPSYS·DESIGNWARE
+M:	Vitor·Soares·<soares@synopsys.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	drivers/i3c/master/dw*
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.7.4


