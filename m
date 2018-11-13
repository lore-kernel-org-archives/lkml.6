Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD746C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749DD2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bwCoP7V+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749DD2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeKNAJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:09:16 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33762 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKNAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:09:15 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 14F3010C1286;
        Tue, 13 Nov 2018 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542118256; bh=LCHkETJE3vj858FPiWOiH/595yHOiogSkEubbLew4F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwCoP7V+LBcFlRWFgSTSpzE7pb3VRRi8nRY0BtiK/PMAJydeGzVVw08BSjbTHAo6X
         UK7IYptNUqTrH1/dcfoyYKNj3rOwK5Hgrpq25p7D2ubUn+k5MEKqugCHgFRbv863FX
         V/cEPHzNKw/Wgu54CggzIu1yA8Kqgn+SUUriDlrdcl4suxStYPqLU9JTtr1kMO7ThM
         JpXI+tWTfEj/MC0jJQP5HOxEjjt34njLalz5jBG5/wzjAIZjShhC4oNjPlJbvtuvA2
         QT5p07Y7/SwhilSRZIXtbJGIsYhmv6nx9DqHfWGPvAYrJ+3ORMdPC4fsc3SimGS5XJ
         sg8Ejes4GrVcw==
Received: from vitor-VirtualBox.internal.synopsys.com (soares-e7470.internal.synopsys.com [10.107.19.128])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B6CE56FE;
        Tue, 13 Nov 2018 06:10:49 -0800 (PST)
From:   Vitor Soares <vitor.soares@synopsys.com>
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
        joao.pinto@synopsys.com
Subject: [PATCH v4 3/3] MAINTAINERS: Add myself as the dw-i3c-master module maintainer
Date:   Tue, 13 Nov 2018 14:09:53 +0000
Message-Id: <1542118193-24925-4-git-send-email-vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
References: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Change in v4:
- Change email soares@synopsys.com to vitor.soares@synopsys.com

Change in v3:
- Remove dummy characters

Change in v2:
- None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 293c863..39910b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6930,6 +6930,12 @@ F:	drivers/i3c/
 F:	include/linux/i3c/
 F:	include/dt-bindings/i3c/
 
+I3C DRIVER FOR SYNOPSYS DESIGNWARE
+M:	Vitor Soares <vitor.soares@synopsys.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	drivers/i3c/master/dw*
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.7.4


