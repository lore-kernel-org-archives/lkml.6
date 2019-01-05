Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2DDC43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E4322342
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719615;
	bh=ycV8mFn1D5rPXS1M7KCg9sRlIHPxqjg0ZsVTe4r3sP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BONlAAv+t0TNqWwr2udGvUJ63GWJTFv2IypgmIeiE+U/KX2enx+7ziRnGcd70kqcc
	 MrfegmyUvht5tVFFDqJwVsF1xUnFp02VilsVfhlrrYrEsJxKi5pQZcSvjxFZy04Wfx
	 uQk/fq4zYJrILcVlmiRXMJ1yWHPiYo7rH900DAqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfAEUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEUUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:14 -0500
Subject: Re: [GIT PULL] arm64: fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719610;
        bh=ycV8mFn1D5rPXS1M7KCg9sRlIHPxqjg0ZsVTe4r3sP0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x4E/YpxB5m7r/FhZ/9/dWsMDOSnvkzAsicyOUYuZMKykm175MF3bqvXLAnRI2bT2x
         Nww1YqZr90ADsdyXAx9j+iirNTrH/Gdl1aqV8vauCJBFoh4rRBQ2zKULz8ebLNpS7t
         nFIheBLuNJcOhnsetDo5tDLYhh8YA4Ate1acHeP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190104182427.GD6299@fuggles.cambridge.arm.com>
References: <20190104182427.GD6299@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104182427.GD6299@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7e0b44e870cf265bb4a73fd25e0508c7363fcbd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 078a5a4faf64fefaf13478a9091782432cad33fa
Message-Id: <20190105202004.12651.2681.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:04 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Jan 2019 18:24:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/078a5a4faf64fefaf13478a9091782432cad33fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
