Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3954C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44E0207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655126;
	bh=hDlcDfM5BZZiLGB3PwqveXb4+vhSSIAEmI7yGc+lAjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OfwY1cSQUZ6RwM6jG7pQ4aKWXCZsIt7ifYhAtEng4g8zRGRHC/pkMfzSev2JyEWFG
	 chFyXKaMo8P55wYRFrttfQV3zA58xC++D5RGjb0s61runeIRZE1sErz+RZcvvQnFQp
	 0AobtAEBfK/wyZrTV7Ynp79GOhLS0meiB5Gq3btk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBHTpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfBHTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:06 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655106;
        bh=hDlcDfM5BZZiLGB3PwqveXb4+vhSSIAEmI7yGc+lAjk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wS7aqbB6iKL7rMfMzSBgFy5IbaW78HmqHhlM+Z1UNJVKnMCmsnMkh8nRxOl1Z1cKl
         sR63B4VclsACwLF3OTAO++JECBLmW/j6ylzApgc3ezLpeRxjYUx8oSkSPjrSDRZXFF
         I4+bC7lAQ3Y3Wh68wtpADIB0dZgINZzy4cGiCrf8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208.024209.1128027461809213325.davem@davemloft.net>
References: <20190208.024209.1128027461809213325.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208.024209.1128027461809213325.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: 39841cc1cbb69344539c98a1fa9d858ed124c7ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27b4ad621e887ce8e5eb508a0103f13d30f6b38a
Message-Id: <154965510597.5511.12942276792839154052.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Feb 2019 19:45:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Feb 2019 02:42:09 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27b4ad621e887ce8e5eb508a0103f13d30f6b38a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
