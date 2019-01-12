Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E602086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318704;
	bh=C5ymzxxY7YY2rnXX5xr+loGxGQ6c1QHbvFVupptCn5w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dp+YjVE2BbH1hXIVrWLl1JLPk7HJccoToPRGzqTgm6gRE5dxP6m2WDM63HrNS881+
	 DImdUv/UN/m2BphsmKYlS5hHbGPi5eP8tKnGy7disI1jsIxx1hrpqLOheUZm53Sh9S
	 R75B/QN+9KTdepcshmJLl3z3lt1JWeiir+N4g7kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfALSpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfALSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:45:03 -0500
Subject: Re: [GIT PULL] KVM fixes for Linux 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318702;
        bh=C5ymzxxY7YY2rnXX5xr+loGxGQ6c1QHbvFVupptCn5w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nMKO7DTyQOGvfLL8KbBnwckjU8jKSQ1E0nIrKeoobp5TEtQIle/I96r1HNtZOdpkG
         5UhNtPVqU4eNvEDw/We2LvrAqoJLw7031QL6yRD4+7M1+EEHEA2vZ0vkBh+a1zkDdt
         QujSZlhLjQfPBPWhIHJCFfudxtODryDD7IVqkZcw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190112123031.GA2992@flask>
References: <20190112123031.GA2992@flask>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190112123031.GA2992@flask>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus
X-PR-Tracked-Commit-Id: 826c1362e79abcd36f99092acd083b5a2d576676
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 473348891c36ff6de3e224fefa0b3fc86a629178
Message-Id: <154731870255.17522.14938699654155221137.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jan 2019 18:45:02 +0000
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jan 2019 13:30:38 +0100:

> git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/473348891c36ff6de3e224fefa0b3fc86a629178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
