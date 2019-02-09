Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFFC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BC821934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549745108;
	bh=9z1y5rt8f9HB15Vdomy8rQYxvP8zeFzG33OI9CJbEX0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FnZmYO9jRBi9KH9HGPaPTn2W5fT3AxC7CQoaRmx0CIuHpF7oqEp72EqUyeYg8JjL2
	 7pT9La5uaxIIrjk/QaXGLhApxcmUNehr3xO6DqXlJnz2O3xBcJ+SA58+/Dfupe+vhb
	 9462fuR+SI3qrDS9Y4Y5pjEztMF73VGlj3o1mOvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBIUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfBIUpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:45:05 -0500
Subject: Re: [GIT PULL] xen: fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549745105;
        bh=9z1y5rt8f9HB15Vdomy8rQYxvP8zeFzG33OI9CJbEX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GEkMGHh+IHKRy+/7C0CtXOSFK3ZaBUg/lbO6sZ9Vk0upYtRYluZUwBliMBkqqfPQx
         XbjmEhhyd3BufQTvFDH1c7Un7iAp59LFiFjzoDk7FnqXJLn80/z1VLaSXdRIKbkP0g
         hzqIm8+ESw/O5gQo6ir9HzeMnQPHXnwO+PT6bCr4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190209143532.16751-1-jgross@suse.com>
References: <20190209143532.16751-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190209143532.16751-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.0-rc6-tag
X-PR-Tracked-Commit-Id: 9ab7d228e972b50d06ee28076ab5d0f93e862463
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e5e692fcd6ce0d63d8c9bd8677d9aaeec61d70e
Message-Id: <154974510500.20101.13753316690975334445.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 20:45:05 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  9 Feb 2019 15:35:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.0-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e5e692fcd6ce0d63d8c9bd8677d9aaeec61d70e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
