Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6526FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F8C21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549910106;
	bh=eu9jWfZBauMJsUwPClEXcmK/S3hekkNY21iMU5zGPRw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T6VcJ3ayK4BmeXre8aS9VwSjgYVOjmaHowm5us9H7Z0gl03QMah38LGnG0Y1wedMJ
	 aMLRLOp9IusmhotnmbKmH4XcNigTHbN4cL/SUd5B3YTS+gBtrsBGyKgExySfyGB9CW
	 z2QHBzMedddaWbt391A+46n2rJNLY9z5fPH7ZHxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfBKSfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732548AbfBKSfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:35:03 -0500
Subject: Re: [GIT PULL] s390 patches for 5.0 #3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549910103;
        bh=eu9jWfZBauMJsUwPClEXcmK/S3hekkNY21iMU5zGPRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B86YH6+uvqvdOyDh5SrDgbA221/B4gM9w+T/a2eHqBbIiLAuluQyVqaUqc1nvHTRG
         d1fv7HAF5s8RSIxSbz5pNV9k1jhQuRhZFmol6BzdRc00mVW8ROXKZEs0n+PnkSAOKm
         5eIXBdu79Zu5+/LyE+tD2VCDDaAPYTEYAe2jBNLs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190211080436.13c3504f@mschwideX1>
References: <20190211080436.13c3504f@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190211080436.13c3504f@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-3
X-PR-Tracked-Commit-Id: 614db26954ff08fa8e92b04100e31ebc04b817cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb7453e61a2b6c29ab08f87b71e2647efe816526
Message-Id: <154991010298.27938.16808493466151764372.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Feb 2019 18:35:02 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Feb 2019 08:04:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb7453e61a2b6c29ab08f87b71e2647efe816526

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
