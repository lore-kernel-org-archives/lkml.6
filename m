Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F538C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232F4207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655153;
	bh=8Zb4x73Erbe+DXYr9Gqz+aHQaaukaDI68NJH52JjP4c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j1LraJvvnCO2mQ0V71XcXIhrzfTJq5+bb2yuRhjplTeBLcQv4e234CWiltrzc7vTV
	 2g7lqmscOwESn150BXkRqXfpIkNbJGHB2YZT1qBlVDgTe0K5i+Jd0yKS09YEHiIx3A
	 zcfwSkb9qnIzisHk5yp3JbIzjJVSYUo2+XCHc9nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfBHTpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfBHTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:05 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655104;
        bh=8Zb4x73Erbe+DXYr9Gqz+aHQaaukaDI68NJH52JjP4c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CGtEZ5Q8i5NuYav384CB5LgolMGcyYy0n6YKfo3fO3bcKNGHK+W65u/PRU/QZbbPj
         jRVEVe4otBN+6XP2yQ0qug89nzhFwIlfY3cywPmGE3n1TW0HDCc6+HLQLX5zwYqjHr
         deYeblYs97xm8USKFqTnaNXT5FS41LFNM/xwYqRw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208083747.GA26787@kroah.com>
References: <20190208083747.GA26787@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208083747.GA26787@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc6
X-PR-Tracked-Commit-Id: a07ddce4df807e41a85245e769b6f6f14f0c6db0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00a159a0007b91fbce2a93e2666951c760ce6811
Message-Id: <154965510444.5511.4669008606400839639.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 09:37:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00a159a0007b91fbce2a93e2666951c760ce6811

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
