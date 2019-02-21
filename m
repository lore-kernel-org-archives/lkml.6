Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDBC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550769304;
	bh=HaOKFKizGHvAyhrdvqRVdv17Ig46LRL+thA4wKAheeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TTmsIiEwNOZEY5cdVUgYGM9WCNLBboEKdziOAA02VDM5eibuvepzfOy5w0D6CrKih
	 IOXl0/C6k/ggUZ0f8g8K+l2dercmKLBJzojEu/Q1T63BzD4xro4ZQpxCQ2UXdEE1ZT
	 6U3oXxeNRN5hZwJdczBvJKVCNR7zp1oI9nU0u9mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBURPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBURPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:15:02 -0500
Subject: Re: [GIT PULL] arm64: late fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550769301;
        bh=HaOKFKizGHvAyhrdvqRVdv17Ig46LRL+thA4wKAheeY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lpdGnxYmqv/BAUCAvhimoOBgcUspXJMiZbqZd1njSwjde/Tr0K1fwJOaWTq7TVUoS
         2vIj0QCdM3aEXevdfdFzz8Vuw1QRuqKs+6nDKP72GkBA6XyHiuC0PbWNdvZ0OmiP54
         DFYYLadLkH60JA+vumltF+hLlgZyErAJZ8R5UWL0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190221151517.GB13320@fuggles.cambridge.arm.com>
References: <20190221151517.GB13320@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190221151517.GB13320@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 74698f6971f25d045301139413578865fc2bd8f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6622d913a637bce224f74425a9dfe734f946358
Message-Id: <155076930188.22690.7679110477710991642.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Feb 2019 17:15:01 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Feb 2019 15:15:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6622d913a637bce224f74425a9dfe734f946358

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
