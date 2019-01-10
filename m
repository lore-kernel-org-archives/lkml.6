Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4DD2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547141108;
	bh=o71MIV8mvmju2b/wQTdxsuqpwVDyFcbWuE/63YZzND4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZVHIstcW1JQPKAw5R6dkhcxA+aAVjZ6a97dljjFfp8Fulqd8QxFqYXHw5UqfmDK4k
	 ZtqJl+P0yKlcxXafpjwOgfLHHJSEACHee2SJHNg76I7G2CapNOHNRhTRLpE0CKhC4o
	 C9nj0Oa2tSAQeQTDHLzSTV9OKjLTXyzFo98Nrzv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfAJRZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729823AbfAJRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:25:02 -0500
Subject: Re: [GIT PULL] VFIO fixes for v5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547141101;
        bh=o71MIV8mvmju2b/wQTdxsuqpwVDyFcbWuE/63YZzND4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0KEwvuu+xzBd81VhuXDSYdg21bdmrweZuZH6Zq8jR3tzItUtmGxFj4tIvVjTsxxf/
         Lbbn8CyhOJPPNbP08s6W7GKXggnjrO0gCVtqHBuGLISOAaImAQ6QVHKnrCCPiB28Wt
         U/3O6Fo9Gi7sF7mpUVZ45A75wNtcMsgGqOcahe9E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190110094609.36eba080@x1.home>
References: <20190110094609.36eba080@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190110094609.36eba080@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.0-rc2
X-PR-Tracked-Commit-Id: 58fec830fc19208354895d9832785505046d6c01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bdbe227492075d058e37cb3d400e6468d0095b5
Message-Id: <154714110178.8982.1088202598885662869.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Jan 2019 17:25:01 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Jan 2019 09:46:09 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bdbe227492075d058e37cb3d400e6468d0095b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
