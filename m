Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C27C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4FA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4FA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeJAQme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:42:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46144 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbeJAQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:42:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D9D57A9;
        Mon,  1 Oct 2018 03:05:32 -0700 (PDT)
Received: from filthy-habits.Emea.Arm.com (filthy-habits.emea.arm.com [10.4.13.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0AE3F5B3;
        Mon,  1 Oct 2018 03:05:31 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] irqdomain debufs fixes for 4.20
Date:   Mon,  1 Oct 2018 11:05:20 +0100
Message-Id: <20181001100522.180054-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a couple of fixes for the irqdomain debugfs feature that I
wrote while working on some unrelated irqchip over the weekend.

If nobody screams, I'll queue them for 4.20.

Thanks,

	M.

Marc Zyngier (2):
  genirq/debugfs: Reset domain debugfs_file on removal of the debugfs
    file
  genirq/debugfs: Reinstate full OF path for domain name

 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0

