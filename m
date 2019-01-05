Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A70C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EC0213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546721703;
	bh=v3ELbVDQgrleucZV7rZ6C+WQDrw1AMSwhGfICzffeQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cb2oDX6vf2Fs4QDxQXtHNY2+TmH5X9jg6uD65oq8lOA+0CvDyNAMaVUwIgL8X39qa
	 oV5vdr4zOqfWdJ1L0JcUn4COFziBEWhY8W14ZN87lum9e378Es6KIuP+/Z2yBNNEb/
	 PmRcbTg7Afk14w/sYcrG+KTFagrvZ9QNL5XIoFS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfAEUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfAEUzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:55:02 -0500
Subject: Re: [GIT PULL] MIPS fixes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546721702;
        bh=v3ELbVDQgrleucZV7rZ6C+WQDrw1AMSwhGfICzffeQI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tiNqazLjTN+W7t//wFk94eeRRPgJtDb6d3F0dqz9ymWzyjF0Osc20eJTXdwhYKZvL
         zsOOAHHrLGyFn1Ey9TwNhrobEc05dfGNPGhgQiiPlVAcecUj9GivnmC6V6P1FNTJmA
         d+LrfAI6tjOAVfzIZZOnA3lfzn628U0cg6KrRppE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190105204153.e6unrbyttycye3wu@pburton-laptop>
References: <20190105204153.e6unrbyttycye3wu@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190105204153.e6unrbyttycye3wu@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_4.21_1
X-PR-Tracked-Commit-Id: edefae94b7b9f10d5efe32dece5a36e9d9ecc29e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47f3f4eb7834ea424b0704bffd0d3e3c8ffbc3a1
Message-Id: <20190105205502.7298.39017.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:55:02 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Jan 2019 20:41:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.21_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47f3f4eb7834ea424b0704bffd0d3e3c8ffbc3a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
