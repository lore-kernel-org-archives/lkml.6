Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202421902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549527007;
	bh=iHVFLCLRzwX4ad54mByndtbDkp/qaDFIFsdVKQKvu7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rytyv6T1DTEngZ3qi435tgDFpvI5dPFJBUwTeYjXta3zYiS74oDOJDH/mJsZKikYv
	 Kzobc6J/Tbs76sIYo+HkIyi9VS8gwM1kxZc2IDF6itGgDH0WUhRtwDplx71zQqewLs
	 umVEXZvJDd7IjbFxf/eWP6AfoLfJitkq8PfLM9OA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBGIKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfBGIKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:10:02 -0500
Subject: Re: [GIT PULL] fuse fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549527001;
        bh=iHVFLCLRzwX4ad54mByndtbDkp/qaDFIFsdVKQKvu7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zrMv5qHyCuL6hxIck3b2xZOtmg+PgNO6ulwa+6JzIPp4+eyWa3dMFDwdkmUMQQP6k
         ehMdR0RQYdBQ4GkSSAVy5QXBqoUA3mvlkSV0XfZ0xbNpSvuqSb9tDhTINrCxpF3XhR
         XJCzdOrTACteIPsR+h5SpLe10OzfA3pWok6Woq5w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190206150742.GC19821@veci.piliscsaba.redhat.com>
References: <20190206150742.GC19821@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190206150742.GC19821@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.0-rc6
X-PR-Tracked-Commit-Id: a2ebba824106dabe79937a9f29a875f837e1b6d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 076a3f553743cca32ff261d4bea29a4e92d936dd
Message-Id: <154952700178.18479.1093528961297624583.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 08:10:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Feb 2019 16:07:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/076a3f553743cca32ff261d4bea29a4e92d936dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
