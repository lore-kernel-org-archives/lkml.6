Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3C020989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3C020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeLFFdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:33:03 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35466 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbeLFFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:33:03 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08148503|-1;CH=green;FP=1082754474687922107|1|1|1|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.DT.sRjv_1544074378;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DT.sRjv_1544074378)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 06 Dec 2018 13:32:58 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [GIT PULL] C-SKY update for 4.20-rc6
Date:   Thu,  6 Dec 2018 13:32:58 +0800
Message-Id: <1544074378-5878-1-git-send-email-ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull.

Best Regards
 Guo Ren

------------------------------------------>
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-4.20-rc6

for you to fetch changes up to 63e19c8216bb03a1b4d10f6637d1324ae7a2b612:

  csky: bugfix tlb_get_pgd error. (2018-12-03 10:49:11 +0800)

----------------------------------------------------------------
C-SKY fixes/update for 4.20-rc6

 - Bugfix tlb_get_pgd error.

 - Update MAINTAINERS file for C-SKY drivers.

----------------------------------------------------------------
Guo Ren (2):
      MAINTAINERS: add maintainer for C-SKY drivers
      csky: bugfix tlb_get_pgd error.

 MAINTAINERS                         | 7 ++++++-
 arch/csky/include/asm/mmu_context.h | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)
