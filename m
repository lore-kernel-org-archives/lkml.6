Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38133C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02006204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484722;
	bh=HzwKMgvrWlbz6iYNHrMLNKqWZam4sVHiKwGLDYhtSOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1isVXPC81C4NFgMPxroUuTwBG4pAglxu0JQU+Di6LnHP8xejAS4ZE+veM0AqDyVR6
	 KSvrFNM676GU7Kh0xKcKfB3ayeGH5qQmD++sOl5EivJQp9io+IwJ9U76eG8xBAS0pw
	 b+V2lTTu1dzbMWp0czJZpIs82fQbWzxwgQY8szF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfACDFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfACDFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:05 -0500
Subject: Re: [GIT PULL] UML changes for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484705;
        bh=HzwKMgvrWlbz6iYNHrMLNKqWZam4sVHiKwGLDYhtSOc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZI1JmpJUPeGP0Vr8bL1JKytqn21UqAO6yG+k9T0RYzSTDb9yVzUBHyL42jVrsUt3E
         vLwAFhyZNRdSgdV9qffEVzQLPYBd6ISeg1cV5f4zRAX7lALu9Y3gM2CH3+90obvAka
         9FQFXotWtGJdAarYYP5ySUn267fCxfjLHDrFdayI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1590974.xBRWhrZ5gH@blindfold>
References: <1590974.xBRWhrZ5gH@blindfold>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1590974.xBRWhrZ5gH@blindfold>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 for-linus-4.21-rc1
X-PR-Tracked-Commit-Id: 940b241d9050fc354f68c182e99fc3da1ff36bc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aa293d8ff0939802a6c86cee6cd152c1b0a7a0d
Message-Id: <20190103030505.10885.2666.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:05 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds@linux-foundation.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 02 Jan 2019 23:52:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aa293d8ff0939802a6c86cee6cd152c1b0a7a0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
