Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0142081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381418;
	bh=gnIp9IbXWDxafDxYDOeNvI3KIS7kOyxYn6DHYFH7ebg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PZ9yyoK26ylZhq4NjZPWo5MnImfx8oH1vpYFefDuiyWVgS5mEPoX/f3Gdjl/K2c7G
	 ZAa39wfYHbt/I22vWWvDlyZY7xYZ7kDKipmsAHRZN7clSdEd1K4pfrKIaxL1mf3Qbr
	 ej+OwyMFUVjZa4Ct4W9f2lErMQ50V3XPsf/p6ViM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0142081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLISuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeLISuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:03 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381403;
        bh=gnIp9IbXWDxafDxYDOeNvI3KIS7kOyxYn6DHYFH7ebg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DFOVzWJTABJ0Nwg/Hm2EByrtC08F+R2ROpoA9AwV/yH5MidsTwkyoQztn9PaxrxF+
         1lvbLqhBFD6jVigEUPLfe+wgwGDmaSkp6qhFzlc+p8UFFBiVhqUUkrYwy7fYy7he/M
         I4zow+riwxfrTEBqa0c9dr8Mt26tq80aZtcAAaog=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209111805.GA9885@kroah.com>
References: <20181209111805.GA9885@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209111805.GA9885@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-4.20-rc6
X-PR-Tracked-Commit-Id: dbde117c31263fb632a5bfcafe4fe769663e8991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0844895a2e5161d2fc1674e870a0fd8286a3e18b
Message-Id: <20181209185003.3376.74047.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 12:18:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0844895a2e5161d2fc1674e870a0fd8286a3e18b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
