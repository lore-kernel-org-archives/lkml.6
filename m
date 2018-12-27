Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C1B21901
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948365;
	bh=l60h5F5ZoBR+CY25BrXM4gcEfYGouW5Bbsv1+IqSIB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uO13nKiqa3/AZBcJrNcv5T5mxnC8Qd9cTNCl28RQfFqjumx5u1PdHajZa/zOMPvy+
	 2hyZgKZbXRU3asZYwrCCOSSzR2mgOujVExiE6BjRE/Mj7v6fv9FVEzHQKMoU6pQziw
	 FyfS61le5vvGy30mG4tldBgsf7gvbkgA/26Hfs5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeL0WGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbeL0WFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:04 -0500
Subject: Re: [GIT PULL] printk for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948303;
        bh=l60h5F5ZoBR+CY25BrXM4gcEfYGouW5Bbsv1+IqSIB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FX7V7y28FQPXhnwFA3J5BFXBM4zfZwHxJRkBtcmHqNz1XbxI3mOsjJh3LeJv1w8/7
         6Cwy0qqw6weMqDWZYZ07j8QYYAuPH6f6ZfK2j5t4cQe2+7d5zWj+rD/WBOin5FEzED
         QkwypKK0PXnrhDXTlA0IVh06GCqHva5brAWe/zpU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220132740.pl2apy5nmfhwmbqy@pathway.suse.cz>
References: <20181220132740.pl2apy5nmfhwmbqy@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220132740.pl2apy5nmfhwmbqy@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-4.21
X-PR-Tracked-Commit-Id: 07c17732bd687567802aaa5fa5c101c2776565d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3b5c1065f3fb934a87dd07d23def99916023d6f
Message-Id: <20181227220503.24636.87400.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:03 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 14:27:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3b5c1065f3fb934a87dd07d23def99916023d6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
