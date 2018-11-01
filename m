Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CF520820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CF520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeKAOaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:30:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36891 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbeKAOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:30:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08029076|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.DBaNG7Q_1541050107;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DBaNG7Q_1541050107)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 01 Nov 2018 13:28:27 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren1983@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [GIT PULL] fixup dtb Kbuild for C-SKY(csky) Port
Date:   Thu,  1 Nov 2018 13:28:25 +0800
Message-Id: <1541050105-14469-1-git-send-email-ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull this to fixup dtb Kbuild rules for csky subsystem.

The following changes since commit ac435075892e3e651c667b4a9f2267cf3ef1d5a2:

  Merge tag 'csky-for-linus-4.20' of https://github.com/c-sky/csky-linux (2018-10-29 08:25:00 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-4.20-fixup-dtb

for you to fetch changes up to e8d0c9a726cd1eae410148fcc6a1db23019f0334:

  csky: use common dtb build rules (2018-11-01 10:52:27 +0800)

----------------------------------------------------------------
csky: dtb Kbuild fixup patches for linux-4.20-rc1

These patches are complementary to "C-SKY(csky) Port for Linux 4.20" and
fixup dtb Kbuild to follow the new Devicetree dtb build rules.

Link: https://lore.kernel.org/lkml/CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com/
Signed-off-by: Guo Ren <ren_guo@c-sky.com>

----------------------------------------------------------------
Guo Ren (2):
      csky: remove builtin-dtb Kbuild
      csky: use common dtb build rules

 arch/csky/Kconfig.debug     | 10 +---------
 arch/csky/Makefile          | 13 +------------
 arch/csky/boot/dts/Makefile | 10 ----------
 3 files changed, 2 insertions(+), 31 deletions(-)
