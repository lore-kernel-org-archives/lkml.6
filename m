Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64242184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548544508;
	bh=kBIvEop13QMFPbuyp/nwO/4xvfGIG17iP+Cldb518MU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qx1jkC0XkxwjVh0UyrueWZNuLvLY4yE8736Y+FEZm7FGZ6XA/KCv66hF/boDRjZhm
	 QYewny1Udiaf/GJNTTD88GqYBVBJYeF1lwKrjnkB/DZew/PHXXtt1wNOeQUGudqqXO
	 aHIa0Imi0SKPT9i+1ZqE/4H5e9ugQfqMoiWjI87w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAZXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfAZXPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 18:15:04 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548544503;
        bh=kBIvEop13QMFPbuyp/nwO/4xvfGIG17iP+Cldb518MU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GaiBQcMSbBTCCeM6HfVwzBM461Gm3851VePI5FyFRksYMi3IkRptHRfdo4pGoWXHU
         zhkR1E2ErHbkdqav82AA6i8oPpu5j4cJA3EwkSc1d0jxqAdBAjBon35cuBKOeE5o45
         fKvhP5F/7uU3Cs3eaOPGhgs16Yna2ji0clewOxpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1548454506.3212.26.camel@HansenPartnership.com>
References: <1548454506.3212.26.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1548454506.3212.26.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d67247566450cf89a693307c9bc9f05a32d96cea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7930851ef10c137c1035d1ef2addfdb3c53a1273
Message-Id: <154854450368.25415.2953905535171484031.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Jan 2019 23:15:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 14:15:06 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7930851ef10c137c1035d1ef2addfdb3c53a1273

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
