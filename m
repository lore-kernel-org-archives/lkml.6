Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD39C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A782081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A782081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKCCGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:06:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeKCCGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35241A78;
        Fri,  2 Nov 2018 09:58:17 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BE33F718;
        Fri,  2 Nov 2018 09:58:16 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     torvalds@linux-foundation.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        punitagrawal@gmail.com, linux-kernel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] mailmap: Update email for Punit Agrawal
Date:   Fri,  2 Nov 2018 16:57:52 +0000
Message-Id: <20181102165751.17948-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-ARM-No-Footer: FoSSMail
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I'll no longer be working with Arm, add a mailmap entry so any mail
directed towards me reaches the appropriate mailbox.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a76be45fef6c..28fecafa6506 100644
--- a/.mailmap
+++ b/.mailmap
@@ -159,6 +159,7 @@ Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
+Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
-- 
2.19.1

