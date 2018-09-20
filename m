Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB3BECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035C221525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035C221525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeITNru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:47:50 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48328 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbeITNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:47:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3465092|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.CtKy98T_1537430729;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtKy98T_1537430729)
          by smtp.aliyun-inc.com(10.147.41.187);
          Thu, 20 Sep 2018 16:05:29 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 0/2] clocksource: add gx6605s SOC system timer
Date:   Thu, 20 Sep 2018 16:03:40 +0800
Message-Id: <cover.1537412072.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Dt-bindings documentation
 - timer-gx6605s driver

Guo Ren (2):
  clocksource: add gx6605s SOC system timer
  dt-bindings: timer: gx6605s SOC timer

 .../bindings/timer/csky,gx6605s-timer.txt          |  42 ++++++
 drivers/clocksource/Kconfig                        |   8 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-gx6605s.c                | 150 +++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 drivers/clocksource/timer-gx6605s.c

-- 
2.7.4

