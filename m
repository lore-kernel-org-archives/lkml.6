Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEAEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4AF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547141103;
	bh=kY77pTN1gUwVunZBfUx3kcj1p2q4upupCoXAvQeq8ag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XuCu7ZGAFfajPr/lbT/fTcTwzfk9tWYcX0y71l3oKhLeQm+mZLpjkX4gnTgMl3+4f
	 Pm8pFLJF6r3x97lmmBeOSGZCxbDzuB5BTJeT8lVN8lLua0lcwDI/NUiFTPUByc97Or
	 L458bd3a0N38B9cFAW/jwLc1EuFhiWrfXUrHew9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfAJRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfAJRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:25:02 -0500
Subject: Re: [GIT PULL] mtd: Fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547141101;
        bh=kY77pTN1gUwVunZBfUx3kcj1p2q4upupCoXAvQeq8ag=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r+U771sSi3u8c3COa5DSSpahNVYA9E5JgIx6KmfYqBhXGu+6QeTJFx2rKhAN6Dcp6
         Ej0SNVcQWNXILkOHVoOX3LDEsqLGlj/LMGa+lFy3g0zBVeeqgu2yq6qo1ujMUCHQ1l
         MN54pdscdbaK1baZt2pZc/EtuY+7RmyZhPbr232E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190110092531.766738a0@bbrezillon>
References: <20190110092531.766738a0@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190110092531.766738a0@bbrezillon>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git
 tags/mtd/fixes-for-5.0-rc2
X-PR-Tracked-Commit-Id: 81d9bdf59092e4755fc4307c93c4589ef0fe2e0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7446be4468bb24c9e45a153bcc9f29ec0372a6f
Message-Id: <154714110151.8982.10047628866619191217.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Jan 2019 17:25:01 +0000
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Jan 2019 09:25:31 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7446be4468bb24c9e45a153bcc9f29ec0372a6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
