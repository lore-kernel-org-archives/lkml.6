Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF8AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F13E21901
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865844;
	bh=yixfeMh+1WZAk3bk1gfB0lxXTsSQrnDseygHTbWYjx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=h+XYni9BVHamFDso/NKJutKY/jiqtOYy3BUfxRKN5/VcHNMruTQGiBuqqsWn5ki/O
	 kPzl99Tq5QjKWH7HEHw9VnouCCGf09sDNoxMGcZ5yLGyYKjukDJEGF7FnTTAZzKr0i
	 7fy4eaMgW5r/ev59hmlo/0HYqHpX1zryBfFruHsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeLZXKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbeLZXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:10:02 -0500
Subject: Re: [GIT PULL] EFI changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865802;
        bh=yixfeMh+1WZAk3bk1gfB0lxXTsSQrnDseygHTbWYjx4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F5yxa4Bfy1H8BsqZ5EHS0aGfn5t6WdgaLE/AN2NQhJDsGpfVlYbR05M0NoPZ6B5Od
         mdR0NNeyzfZI/qIo5E8M2J2lDpLP2r1neo/VxVKI6F2HXGeXwutcM1sb91blOxWEna
         Uak1Uaq8i7oG1wNyikD7OfW1xr8gzjrBsB6w8198=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224222132.GA109386@gmail.com>
References: <20181224222132.GA109386@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224222132.GA109386@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: 1debf0958fa27b7c469dbf22754929ec59a7c0e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 684019dd1f0092b4ffce4958c84aff0891deac83
Message-Id: <20181226231002.2587.43635.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 26 Dec 2018 23:10:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 23:21:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/684019dd1f0092b4ffce4958c84aff0891deac83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
