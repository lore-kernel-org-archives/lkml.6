Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E705C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A33222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719619;
	bh=SCFwucDRfEVD0emuyQWH+fj0jhU4xg+/lAXSm8vkrEE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sVREXkYcCAtr+Wrh9HOoVAQSjSblP7oqHuPTCI/QCRBKDUeTt6euTOgr370uf8AG5
	 z3+jVQYI8Whi52MTSERW0NJNDZyrLFAe8mCWFfbyVH2awk2wrhg9zChlWFrbC/fBW3
	 ZpJlx1Y6sAiHCFDgUnYmyweXHJjoPucH6UgUbUNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfAEUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:17 -0500
Subject: Re: [GIT PULL] ARM: SoC late updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719616;
        bh=SCFwucDRfEVD0emuyQWH+fj0jhU4xg+/lAXSm8vkrEE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SavNC6LzGXuX046czZQ5DV5nTmXz+yCNlBQZX5DFYxoqXTz/8JfhRkYvQ3vrAnMnz
         soVYAwnC7LFkGdWmMnDscxrR/iHYxxwSaAfagqH/Prx7CwxDVyiLe2pab+SvFzcKxH
         mYvTS4niy1sG5ryZdlUP1NphaseyNh2xNO5AhlVY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104225107.hkl2nzdfdewg3lbu@localhost>
References: <20190104225107.hkl2nzdfdewg3lbu@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104225107.hkl2nzdfdewg3lbu@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-late
X-PR-Tracked-Commit-Id: 00f8ccd0c95f4e604297057a5bccec86c0903d14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23b0ea3708c3dec599966fc856836aca48835b9
Message-Id: <20190105202010.12651.61878.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:10 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 14:51:07 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23b0ea3708c3dec599966fc856836aca48835b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
