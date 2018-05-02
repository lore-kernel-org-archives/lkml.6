Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEBCIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:08:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEBCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:08:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7303A6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date: Tue, 1 May 2018 21:08:33 -0500
From: Richard Kuo <rkuo@codeaurora.org>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org
Subject: [GIT PULL] Hexagon fixes
Message-ID: <20180502020833.GB7239@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following changes for Hexagon; they contain some small fixes
for module compilation.


Thanks,
Richard Kuo



The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 330e261c35dfb969c48f996dbbc8b334b5ee8d9d:

  hexagon: export csum_partial_copy_nocheck (2018-05-01 15:49:50 -0500)

----------------------------------------------------------------
Arnd Bergmann (2):
      hexagon: add memset_io() helper
      hexagon: export csum_partial_copy_nocheck

 arch/hexagon/include/asm/io.h | 6 ++++++
 arch/hexagon/lib/checksum.c   | 1 +
 2 files changed, 7 insertions(+)


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
