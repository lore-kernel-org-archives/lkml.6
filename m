Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EFE21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbeLTPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:16:51 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:34254 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbeLTPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:16:51 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id EFGp1z00D3XaVaC01FGpAE; Thu, 20 Dec 2018 16:16:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ga049-00005g-7g; Thu, 20 Dec 2018 16:16:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ga049-0006tg-50; Thu, 20 Dec 2018 16:16:49 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [git pull] m68k fixes for 4.20
Date:   Thu, 20 Dec 2018 16:16:47 +0100
Message-Id: <20181220151647.26469-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 58c116fb7dc6703a557fe79c6e6ebab1450082b3:

  m68k/sun3: Remove is_medusa and m68k_pgtable_cachemode (2018-08-31 09:30:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v4.20-tag2

for you to fetch changes up to bed1369f51901b17108a4bb4f7210aab183bea42:

  m68k: Fix memblock-related crashes (2018-12-19 17:24:12 +0100)

----------------------------------------------------------------
m68k fixes for 4.20

  - Fix memblock-related crashes.

This is a fix for regressions introduced in v4.19.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: Fix memblock-related crashes

 arch/m68k/kernel/setup_mm.c | 2 --
 arch/m68k/mm/motorola.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
