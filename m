Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C392146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C392146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeIRTWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:22:50 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57365 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbeIRTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:22:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3195665|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CsTnkzN_1537278572;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CsTnkzN_1537278572)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 18 Sep 2018 21:49:33 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] irqchip: add C-SKY SMP interrupt controller
Date:   Tue, 18 Sep 2018 21:49:29 +0800
Message-Id: <cover.1537276562.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren (2):
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc

 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++++
 drivers/irqchip/Kconfig                            |  16 ++
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-csky-mpintc.c                  | 196 +++++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4

