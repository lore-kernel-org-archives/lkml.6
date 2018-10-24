Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF8C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442252075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442252075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbeJXMHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:07:03 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:20583 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726268AbeJXMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:07:03 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9O3fesm000512;
        Wed, 24 Oct 2018 11:41:40 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 24 Oct 2018
 11:40:11 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <zong@andestech.com>,
        <linux-pm@vger.kernel.org>, <alankao@andestech.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 0/1] nds32: Power management
Date:   Wed, 24 Oct 2018 11:40:06 +0800
Message-ID: <cover.1540349342.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9O3fesm000512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is power management porting for nds32.

Nickhu (1):
  nds32: Power management for nds32

 arch/nds32/Kconfig               |  10 +++
 arch/nds32/include/asm/suspend.h |  11 +++
 arch/nds32/kernel/Makefile       |   2 +-
 arch/nds32/kernel/pm.c           |  91 ++++++++++++++++++++++
 arch/nds32/kernel/sleep.S        | 129 +++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ativic32.c   |  29 +++++++
 6 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 arch/nds32/include/asm/suspend.h
 create mode 100644 arch/nds32/kernel/pm.c
 create mode 100644 arch/nds32/kernel/sleep.S

-- 
2.17.0

