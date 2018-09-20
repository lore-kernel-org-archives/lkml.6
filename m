Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B721526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B721526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeITOIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:08:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42688 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbeITOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:08:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3008231|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l01425;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CtLhhg-_1537431925;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtLhhg-_1537431925)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 20 Sep 2018 16:25:25 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, green.hu@gmail.com, arnd@arndb.de,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 0/2] irqchip: add C-SKY APB bus interrupt controller
Date:   Thu, 20 Sep 2018 16:25:18 +0800
Message-Id: <cover.1537412037.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Dt-bindings documentation
 - irq-csky-apb-intc driver

Guo Ren (2):
  irqchip: add C-SKY APB bus interrupt controller
  dt-bindings: interrupt-controller: C-SKY APB intc

 .../interrupt-controller/csky,apb-intc.txt         |  62 +++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-csky-apb-intc.c                | 260 +++++++++++++++++++++
 4 files changed, 331 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c

-- 
2.7.4

