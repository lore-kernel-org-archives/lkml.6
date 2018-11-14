Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B0F2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B0F2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeKOGEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeKOGEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:04:39 -0500
Subject: Re: [GIT PULL] namespace fix for v4.20-rc3
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8291A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o9auiayt.fsf@xmission.com>
References: <87o9auiayt.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o9auiayt.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 1e9c75fb9c47a75a9aec0cd17db5f6dc36b58e00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e624c03043f544ab797ee073d958cfa57dbf51
Message-Id: <20181114200002.14496.40666.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 14 Nov 2018 20:00:02 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Nov 2018 09:15:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e624c03043f544ab797ee073d958cfa57dbf51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
