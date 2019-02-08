Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2117C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F4920863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBHRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:03:25 -0500
Received: from foss.arm.com ([217.140.101.70]:54168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfBHRDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:03:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8D1180D;
        Fri,  8 Feb 2019 09:03:22 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC643F719;
        Fri,  8 Feb 2019 09:03:21 -0800 (PST)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Julien Grall <julien.grall@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Remove reference of TIF_USEDFPU on arch not using it
Date:   Fri,  8 Feb 2019 17:03:11 +0000
Message-Id: <20190208170315.10762-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This small patch series remove reference of TIF_USEDFPU on nds32, arm and
arm64 as the flag is not inuse.

Cheers,

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org

Julien Grall (3):
  nds32: Removed unused thread flag TIF_USEDFPU
  arm: Remove documentation about TIF_USEDFPU
  arm64: Remove documentation about TIF_USEDFPU

 arch/arm/include/asm/thread_info.h   | 1 -
 arch/arm64/include/asm/thread_info.h | 1 -
 arch/nds32/include/asm/thread_info.h | 2 --
 3 files changed, 4 deletions(-)

-- 
2.11.0

