Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4AC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E2121A08
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E2121A08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGGKCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:02:06 -0400
Received: from foss.arm.com ([217.140.101.70]:46018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbeGGKCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:02:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC68180D;
        Sat,  7 Jul 2018 03:02:04 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8A03F5AD;
        Sat,  7 Jul 2018 03:02:03 -0700 (PDT)
Date:   Sat, 7 Jul 2018 11:02:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.18-rc4
Message-ID: <20180707100159.bs52kdpykof4wumz@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 patches below. Thanks.

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 1a381d4a0a9a0f999a13faaba22bf6b3fc80dcb9:

  arm64: remove no-op -p linker flag (2018-07-05 19:12:48 +0100)

----------------------------------------------------------------
arm64 LDFLAGS clean-up:

- use aarch64elf instead of aarch64linux
- move endianness options to LDFLAGS instead from LD
- remove no-op '-p' linker flag

----------------------------------------------------------------
Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Masahiro Yamada (1):
      arm64: add endianness option to LDFLAGS instead of LD

Paul Kocialkowski (1):
      arm64: Use aarch64elf and aarch64elfb emulation mode variants

 arch/arm64/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
Catalin
