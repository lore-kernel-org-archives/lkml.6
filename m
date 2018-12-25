Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E5AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86508218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780056;
	bh=k82h5LkdPundWrpDutiA0CX5FQP3aLjgaug0REQCZHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DcWvYuyNQTYEoZz1ftwf/ARWBm46TZ5IiAk2blK3PrsXhjWkFpajRAf2Oque8l3BQ
	 JJ9s3zd41Mjn9Gf84I2i8uAjm+kn1R55Q05ld7RD0COynTUjsUkDyqCL05bfevfBqV
	 26Bm3vL1+R2Gkx5NVf1vbH/vMSz8/+1Rla+2EUQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLYXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeLYXUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:06 -0500
Subject: Re: [GIT PULL] Device properties framework updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780006;
        bh=k82h5LkdPundWrpDutiA0CX5FQP3aLjgaug0REQCZHk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fadso3H3AgaeOnhK2sZ1cupdBS3Tt7y3bTU4zdPNKRjTul1/s90pK2v1DOYCbBbYf
         9O2NlQ/q3SVm6UkjtfY7piW0c4RD2PR+vtfHT+BQkRr3G3qedPglTNSmUxeoVfiBv/
         e81YY76FMVEba6Yu3OiNlW52mdUKBiKOSp+Yxkeo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ja-twfG-0a7=JewPeyQxc2FmqPaN8Vi5ZVTNDjcFCX8g@mail.gmail.com>
References: <CAJZ5v0ja-twfG-0a7=JewPeyQxc2FmqPaN8Vi5ZVTNDjcFCX8g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ja-twfG-0a7=JewPeyQxc2FmqPaN8Vi5ZVTNDjcFCX8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-4.21-rc1
X-PR-Tracked-Commit-Id: f569da8c994c2254a106bdb537aa271399e288ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8924c0d76aaa52e4811b5c64115d9a7f36cc73a
Message-Id: <20181225232006.23808.33216.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 12:10:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8924c0d76aaa52e4811b5c64115d9a7f36cc73a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
