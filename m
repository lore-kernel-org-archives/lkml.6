Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676FEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F0E20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545961537;
	bh=y/b1RjI7T18JcEasCjjyqAqtj4CnRtEcQoi802QjPN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CTUUuYw35y/F8NOf8llClAOIlwhM1PUDyLzd1nHw2rqgMKz0NCNcm5027nwjZ4bFs
	 UqjtB6b+3WRzWwt5PD2Avhd8Q3Cj7VlncuWw0ETF6rpFl94LWlAVk/X68Xp7CHGvaV
	 Py0PdLgYcTbE6REjLL7rxbgfrKuEZpRwLxvlKYF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeL1Bpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbeL1BpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:45:04 -0500
Subject: Re: [GIT PULL] ext4 updates for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545961503;
        bh=y/b1RjI7T18JcEasCjjyqAqtj4CnRtEcQoi802QjPN8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M/LWo63h7XfBoDbfU91tboK1pEJoD0Q9Gn93UWnkSvohLYV7BC0tvO20lhhWjuy2X
         TmZCqkngJ6NF+zYuIqd8aq4p4csTSmFe3VSLiwpyPv0NSNHsawecAuHdNNpAmRU/rJ
         4OwHhAkXnn1clFnKrmwo9nIG+tVF3xOu+m88SFWA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224045334.GA20828@mit.edu>
References: <20181224045334.GA20828@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224045334.GA20828@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 18f2c4fcebf2582f96cbd5f2238f4f354a0e4847
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6b1495fba0b66cfa05efa0ca2370513b79b45b6
Message-Id: <20181228014503.3597.52246.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 28 Dec 2018 01:45:03 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Dec 2018 23:53:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6b1495fba0b66cfa05efa0ca2370513b79b45b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
