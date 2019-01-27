Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15FC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF20C2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548619820;
	bh=kfg1wMROla8RjXMjJQAGkN91sb76B+7O6fv0NIs5ZxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s4Ntv50pjah9U/wiVl07qLbULv6cGeEHETdugYqGD3szBLQlx6qhqpaGXtd6msT0T
	 Nmxn6iQMXvKwiBeWOKqnuXlWIaTV76NDdz76XGs2hmKA0jtSfzdp8DIb7xd8QoF4qe
	 /CKSG/DL8UGn2vRcOj5A6g3+Gg6+4y6/WHX04Zao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfA0UKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfA0UKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:10:06 -0500
Subject: Re: [GIT pull] x86 updates for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548619805;
        bh=kfg1wMROla8RjXMjJQAGkN91sb76B+7O6fv0NIs5ZxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oNXq2iYxgFXn2Zl19vTGvn2NzcaiTRbE8V5FCyiiXj7Uo8y/Y7VqKjk2b18kohVjW
         izZclUG8HtPTjZoi7eB16/3WH3dgZxJkd1uW9uYP3pgf7iI7yfbe/Ura0LneUV37Fn
         YU4ySS9sps+aFVPxcVcwsVhiJynQEXSM8RscPOsM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <154858670614.17124.16485685727984615731.tglx@nanos.tec.linutronix.de>
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
 <154858670614.17124.16485685727984615731.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154858670614.17124.16485685727984615731.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 625210cfa6c0c26ea422f655bf68288176f174e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a5f06056a25ac7dbca2b0505cc0fe8ffb6947c1
Message-Id: <154861980588.25513.11098797491242555839.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 20:10:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:05:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a5f06056a25ac7dbca2b0505cc0fe8ffb6947c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
