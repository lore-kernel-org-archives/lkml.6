Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D828AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B582064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547402703;
	bh=rYRu6Bq4/JDvYGfL+BUCJKvae7pf2efD3mk2+Eha+O8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K+hEAloHeiLAV9S8Lt58nvPSRPIsT/lZJC3qZ3Q8t3KLCkdYYD+yrFJ2l2eBp34F7
	 oFEi1Abeiv//oJ931HsEIOcNqeav3XI9cY53Q/aKelEaUBgMWfSPN2i2gBxifFsBhX
	 nIRcRglMMUIdmXAqcuwv8Hm3kvesRcRXFYjCtsLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfAMSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfAMSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:05:02 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547402701;
        bh=rYRu6Bq4/JDvYGfL+BUCJKvae7pf2efD3mk2+Eha+O8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=usm5eZl4XDFLEWKr0s5CaelU1hOCt0Pq2A2ZnjChC6UGq5WEuk2dLNVN7r+m42K4N
         QmMOjwBWNwpwM9Crf/DBZ0vLB6lD5lQqwYfAmVymSWrWvQCJ39wr0HtOZWpoQWNAS8
         xxjPQ32jNhvE65469mkFujchbnidNxwW9i3Hk5+w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113102252.GA12640@kroah.com>
References: <20190113102252.GA12640@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113102252.GA12640@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc2
X-PR-Tracked-Commit-Id: b9fcb0e6b7052b7e2d18fed1d673f8247060c32c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dd8a3f6c619723ab442d6a27247d2f2153f3b11
Message-Id: <154740270186.11831.2910900591500460739.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jan 2019 18:05:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 11:22:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dd8a3f6c619723ab442d6a27247d2f2153f3b11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
