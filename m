Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A317CC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5768420834
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 23:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5768420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeHMBr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:47:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34952 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeHMBr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:47:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fozTD-0002e7-IE; Sun, 12 Aug 2018 23:08:23 +0000
Date:   Mon, 13 Aug 2018 00:08:23 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git - a bit that should've been in misc branch
Message-ID: <20180812230823.GR6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I expected more fs/dcache.c cleanups this cycle, so that went into
a separate branch; said cleanups have missed the window, so in the
hindsight it could've gone into work.misc instead.  Decided not
to cherry-pick, thus the separate pull request.

PS: That's the last pull request for today; the only stuff not included
into those is dhowells' mount series.

PPS: Looking through the sent mail, this commit (pure removal of unused
function) is the only one not posted on fsdevel/l-k this cycle...

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 63a67a926e214dac94e29147c0f3d11499f655a1:

  kill dentry_update_name_case() (2018-06-23 17:16:44 -0400)

----------------------------------------------------------------
Al Viro (1):
      kill dentry_update_name_case()

 fs/dcache.c            | 27 ---------------------------
 include/linux/dcache.h |  2 --
 2 files changed, 29 deletions(-)
