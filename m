Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9127EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381406;
	bh=Dx6JezG1Lwny3jgSqbDeCwtnxYmUMrckoJY5Ly3CKR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uxSI+e8F6iVZhtlqdgOa+7xRtvl7Cd+Ceo5DQlJxpBcPIBhjccsDfnxVeDdZE5/xF
	 MCugPqzOpZia3f+jhNfq5N2Vd5ILE4QThr5fsG2M477sH5fQUwK3igmbkE8MXMsy9u
	 1k0BbwsmVjI/R5WnT73N7XtSbvHFL/gLBtaQv4YI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5389D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLISuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeLISuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:03 -0500
Subject: Re: [GIT PULL] TTY/Serial fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381402;
        bh=Dx6JezG1Lwny3jgSqbDeCwtnxYmUMrckoJY5Ly3CKR8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TghyZ3RvJIVIfsJwFcYoH1u7j9vDa0VbYQyTeQHZ1lB48IWEE2q2XGmbefFzx7HGM
         XlnW5jNiVfuxlb+bm8O8LzmnBL2dZQan6lCmYCHn+xbx/+ck7NSxo5ORLbS5u/a98T
         N/nV7e34cnkxJ5+txAyIy1mB5/c9lHt5ZY+8riwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209111717.GA9735@kroah.com>
References: <20181209111717.GA9735@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209111717.GA9735@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 tags/tty-4.20-rc6
X-PR-Tracked-Commit-Id: dada6a43b0402eba438a17ac86fdc64ac56a4607
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 822b7683fff11f152e74c404b3d915f6e5b13698
Message-Id: <20181209185002.3376.95142.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 12:17:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/822b7683fff11f152e74c404b3d915f6e5b13698

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
