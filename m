Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46572C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D2220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D2220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLGSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:35:07 -0500
Received: from foss.arm.com ([217.140.101.70]:51754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbeLGSfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:35:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6436AEBD;
        Fri,  7 Dec 2018 10:35:05 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543A13F5AF;
        Fri,  7 Dec 2018 10:35:04 -0800 (PST)
Date:   Fri, 7 Dec 2018 18:35:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.20-rc6
Message-ID: <20181207183459.GA30569@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b4aecf78083d8c6424657c1746c7c3de6e61669f:

  arm64: hibernate: Avoid sending cross-calling with interrupts disabled (2018-12-07 15:52:39 +0000)

----------------------------------------------------------------
- Avoid sending IPIs with interrupts disabled

----------------------------------------------------------------
Will Deacon (1):
      arm64: hibernate: Avoid sending cross-calling with interrupts disabled

 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Catalin
