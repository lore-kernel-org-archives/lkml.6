Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46892081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46892081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeKCTwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:52:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeKCTwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:52:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9BD980D;
        Sat,  3 Nov 2018 03:41:22 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66B13F6A8;
        Sat,  3 Nov 2018 03:41:21 -0700 (PDT)
Date:   Sat, 3 Nov 2018 10:41:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 2nd round of updates for 4.20
Message-ID: <20181103104115.7imtevbiauvd3qls@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. Thank you.

The following changes since commit 4debef5510071032c6d5dace31ca1cc42a120073:

  arm64: KVM: Guests can skip __install_bp_hardening_cb()s HYP work (2018-10-19 15:37:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 966866892cf89d606544bca22d584ba2ef9ec208:

  arm64: kprobe: make page to RO mode when allocate it (2018-11-02 18:15:07 +0000)

----------------------------------------------------------------
arm64 2nd round of updates for 4.20:

- Fix W+X page (mark RO) allocated by the arm64 kprobes code

- Makefile fix for .i files in out of tree modules

----------------------------------------------------------------
Anders Roxell (1):
      arm64: kprobe: make page to RO mode when allocate it

Victor Kamensky (1):
      arm64: makefile fix build of .i file in external module case

Yangtao Li (1):
      arm64: kdump: fix small typo

 arch/arm64/Makefile                |  2 ++
 arch/arm64/kernel/crash_dump.c     |  2 +-
 arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
Catalin
