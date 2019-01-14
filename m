Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34FAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857F620651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547490606;
	bh=oBHu7tgR5Vrwf6wTmpEjSwaI8CaUoFgwDyKqjv45Mxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ICT/W/7R+iiBlhWHkqMr75P34v00HhJELpJX3Q7At5EqSYBed2VCE9s1NKcwZsH4D
	 pmcMTFjM7OYf5U1S2AOujPk8JL/sBQ7jIa8B1sx+IZwdpvyJqFD/OTdCr6CXiT9v93
	 BJZVzlZihQdKXKa6jaH5n7bB52+YCIMXz5Gqqd/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfANSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfANSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:30:03 -0500
Subject: Re: [GIT PULL] Backlight for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547490602;
        bh=oBHu7tgR5Vrwf6wTmpEjSwaI8CaUoFgwDyKqjv45Mxs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z7MhHS5UHfNvI+ezgLnZDeS/zldRHcs4UFeC3GMkwopxwOO3tvBobbqGV8U5LfLMG
         AbjrrhxE8/smJvTYdwjL2dDbAL+5Ih1uJpXNeY5lqNObiWPqe+vs5YyiLrPUYg+oVb
         5Dbyt7UJOUVYIgGRbR+f7mKjTmf0RSLHLEwmf6AE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190109072252.GC27286@dell>
References: <20190109072252.GC27286@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190109072252.GC27286@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-4.21
X-PR-Tracked-Commit-Id: 3cee7a7d05b11038c8b5fa093e45c6f839ffc867
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a73e73a10a791344587103a1adbe0c5f02fedeb
Message-Id: <154749060284.22817.12828722077135760394.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Jan 2019 18:30:02 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Jan 2019 07:22:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a73e73a10a791344587103a1adbe0c5f02fedeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
