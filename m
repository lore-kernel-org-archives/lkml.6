Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED45C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6AA20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6AA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeKKFVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeKKFVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:21:06 -0500
Subject: Re: [GIT PULL] namespace fixes for v4.20-rc2
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pnvcls3n.fsf@xmission.com>
References: <87pnvcls3n.fsf@xmission.com>
Message-Id: <20181110193502.26034.39127.pr-tracker-bot-1de4f2ef216dade3b5bd5f5247c4c750a953f51c@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 10 Nov 2018 19:35:02 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Nov 2018 12:12:12 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1de4f2ef216dade3b5bd5f5247c4c750a953f51c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
