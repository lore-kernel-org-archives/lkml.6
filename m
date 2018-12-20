Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA40206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322269;
	bh=tdU4JOVhVYCY4bVTZIH1e9gxvGbLmLdyIzheiZ5aQus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NIIZnBhVcJ1y8QlWn4yhFUt+xhC02QKYKDuDzE/944PXfpfh1urJIY4kvszyrsY+H
	 rbO3b8KuMQbqtE8TVVNyeDdDh2ADLMHnuuB+YvRpfdXOUO/e8z2OEo6qLMKwBjNjef
	 eXedmMzS+DTUZmF2d0RKnXzuQVl6Lp1Ut14lKU+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeLTQLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbeLTQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Subject: Re: [GIT PULL] USB driver fixes for 4.20-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322201;
        bh=tdU4JOVhVYCY4bVTZIH1e9gxvGbLmLdyIzheiZ5aQus=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UBBxQy94XNq5K5cimVm+/Y8Y4R702ENCGRefmfUdYbuTvT8w0diTgxNOPPmc5QOQg
         m8BgCPT65hQe2xoAFvbKUacDL+DBafYwtBU84RDrU71/YxOn9UUXAYCsjLZ4P68H6p
         srOrdfw7gOWp6RgHPQwlhMJbBNZeVuU+xaYodsck=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220123838.GA18210@kroah.com>
References: <20181220123838.GA18210@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220123838.GA18210@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
 tags/usb-4.20-rc8
X-PR-Tracked-Commit-Id: 2419f30a4a4fcaa5f35111563b4c61f1b2b26841
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 177c459b08a34dcf004aa9a4c1f1d8be682ff3af
Message-Id: <20181220161001.12746.39892.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Dec 2018 13:38:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/177c459b08a34dcf004aa9a4c1f1d8be682ff3af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
