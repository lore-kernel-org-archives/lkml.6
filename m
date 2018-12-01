Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E3B20660
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E3B20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLAOG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeLAOG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:06:27 -0500
Subject: Re: [GIT PULL] arm64 fixes for 4.20-rc5
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078F52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181130185455.GA24239@arrakis.emea.arm.com>
References: <20181130185455.GA24239@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181130185455.GA24239@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ea2412dc21cc790335d319181dddc43682aef164
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 868dda00b98ccc701a70b8c1b0168fc3bbfd595d
Message-Id: <20181201025502.16477.66940.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 01 Dec 2018 02:55:02 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Nov 2018 18:54:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/868dda00b98ccc701a70b8c1b0168fc3bbfd595d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
