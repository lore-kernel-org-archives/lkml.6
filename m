Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AD520878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547239214;
	bh=m9Ul3B7N93UFqYinGHKk2n1E+3XsbewUdmO63FEB1n0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ed+7InX2OlHI6lxYJ2Zg6t5G0oTJapbOYYkQRcQvRt9qF6l1VOJ2e1Z3pc3EksXfE
	 uD+XZ4Zg4558N1SeIHEJNpd9ckUhoStO3lUWJzPxMdQfncPSRJvi1Jr5m1Q6nEl1cl
	 7DDmwooRSE6mIgEDvs9Vas0NcHFtzT3aSFsBRakM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAKUkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfAKUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:40:02 -0500
Subject: Re: [GIT PULL] arm64: fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547239201;
        bh=m9Ul3B7N93UFqYinGHKk2n1E+3XsbewUdmO63FEB1n0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S44j6YjEQ3P4UKWcY87kcKQgKAX6fRVKiyzWuBk8X4gsYXbELLJX0X5qM4jxSRbJj
         7Di7H2zslPq148CI+VbjEwLdfBUNshlMnDoAwYzNpqOqEjWGNpSwZl9Ncw4XMKXgfR
         gpCVoqMQAIkH9G+1W856g+OCILRSkOG8GuHzX9wQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111182057.GB32645@fuggles.cambridge.arm.com>
References: <20190111182057.GB32645@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111182057.GB32645@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 279667212ab2a4f36c3b0347657ddcc11f9cfa25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3405d689974555532c12a4f3a5e72dedc660c0b
Message-Id: <154723920158.6200.7472731315707078708.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 20:40:01 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 18:20:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3405d689974555532c12a4f3a5e72dedc660c0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
