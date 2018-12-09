Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AB32081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544381428;
	bh=IRUADp0NBu+rIHKEZv8zwFgMMGwMjE+F+O49Z/hzCMs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bne131uPEM90f525osK4Z6QNv3tcjtJzx1jw3zMI1hP1sPYxTGJM6qmnUL2YKh6Wm
	 wnCrnisZYS+gk2jI419xAlEziApgp8h8zouvxFdCpsJxiRDXoxdmP7w+Up2ogCW2vB
	 GhXpznLR65HTf+A5E3odjNShT4B0mg1TGFbJsXyM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AB32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLISu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeLISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:50:02 -0500
Subject: Re: [GIT PULL] USB/PHY driver fixes for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544381402;
        bh=IRUADp0NBu+rIHKEZv8zwFgMMGwMjE+F+O49Z/hzCMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D3weIAA9ZX2e7ZOb4vQLj0fp3lZr5B3qt8h0+hNe1b3Z0wipOmhIcc2AaYM8XAzyc
         hqQRZfgta5jKllPSbTAXZ8MjgujjDUsG6Atlz3ndt0agbh+iheAgLj3QgK3a8z0ngz
         LIwcg5zm7Kt83J/K/KPDYTlsjyQpx+UNEn0gmKO4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181209111646.GB9556@kroah.com>
References: <20181209111646.GB9556@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181209111646.GB9556@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
 tags/usb-4.20-rc6
X-PR-Tracked-Commit-Id: 3caad34eab57e622dad48086af7f89c19001664e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50a5528a4b19b7324f0796ea2fedf32530a11ff8
Message-Id: <20181209185002.3376.32762.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 09 Dec 2018 18:50:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Dec 2018 12:16:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50a5528a4b19b7324f0796ea2fedf32530a11ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
