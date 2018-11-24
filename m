Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B972C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B23A2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B23A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeKXXZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:25:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34148 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeKXXZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:25:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 444373898;
        Sat, 24 Nov 2018 04:36:44 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117D23F5AF;
        Sat, 24 Nov 2018 04:36:42 -0800 (PST)
Date:   Sat, 24 Nov 2018 12:36:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.20-rc4
Message-ID: <20181124123637.matxo4anfxj5q5vm@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4f9f49646a5733c0c2bd49940673dde89a9c5add:

  arm64: cpufeature: Fix mismerge of CONFIG_ARM64_SSBD block (2018-11-23 18:44:16 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix wrong conflict resolution around CONFIG_ARM64_SSBD

- Fix sparse warning on unsigned long constant

----------------------------------------------------------------
Sergey Matyukevich (1):
      arm64: sysreg: fix sparse warnings

Will Deacon (1):
      arm64: cpufeature: Fix mismerge of CONFIG_ARM64_SSBD block

 arch/arm64/include/asm/sysreg.h | 4 ++--
 arch/arm64/kernel/cpufeature.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin
