Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C13C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F7720989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095709;
	bh=U2xykrMePVHgqTNtbeEy72ybTY3+UzjU1DRholnBOuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mt0U3I7Zdk7o/906u04O5QT4IIbtXCzWpc02h6WtHRGm7Z1xKvtg6fZB2JMoGsovb
	 +v3gBDyl6VSnT/8zBCLH2KWDfcZx3pcK+vliuXdDJjc+GGltequtGp8oWPCBJiwBq4
	 FDKmePUEg3Bo3CkSPvfnHTgKx99FCFjzp4zoyUac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAUSfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfAUSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:02 -0500
Subject: Re: [GIT PULL] ARC updates for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095701;
        bh=U2xykrMePVHgqTNtbeEy72ybTY3+UzjU1DRholnBOuI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lb4x4odgTHv590Spqls/R7NIilewo90/FHX4J2kSUlcFxv+dQjtuuOB3oybUPngmF
         WKgrpAppOsudyBsF73Q5Lf/rYmRIae5w3SjrpkmcVy0ZnnWAu4QzGdajPMjqBjRxKa
         4ksnTFON0OReUaQSY06bBJHpdydk4uGHcn+E5rh0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0bc45ec8-3470-917b-fff6-6ddffafeda98@synopsys.com>
References: <0bc45ec8-3470-917b-fff6-6ddffafeda98@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0bc45ec8-3470-917b-fff6-6ddffafeda98@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.0-rc3
X-PR-Tracked-Commit-Id: e6a72b7daeeb521753803550f0ed711152bb2555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57ef300e4627db5bf41695b1932c24979efa600e
Message-Id: <154809570163.8142.1402464578100722266.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Jan 2019 18:35:01 +0000
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 16:26:29 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57ef300e4627db5bf41695b1932c24979efa600e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
