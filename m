Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9733F2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548609905;
	bh=eit9680lC1eafShGxEKdio9TbMxkp4PSHFh1NHWzKik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2iBb3FXhZ7NHObN14kjI6fmqpMQoVynud3jmOdfGVy2H3fFpa0pPMcHaEBV45XJ8e
	 OkvFfl4efeXJsYbOmAlNUc28LC7kKHJFUYNqhWGeZzQ7VUhQ5oYpxr3TI7pxF39T3r
	 mBN7/YYYTTL0Z4jmhk4SWalOwAkB1vI+Ik9FCh5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfA0RZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfA0RZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:25:04 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548609903;
        bh=eit9680lC1eafShGxEKdio9TbMxkp4PSHFh1NHWzKik=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EEAEgmgn5sxWOswQK74WosffaKh0+T5GkzEuSk21Y4F1zs+9XKvAyt8ERWrZ0xZju
         b1u03U7RF46m9S1UUmxCtgGpPqBO4F8qTKoOB1VDyUL0Tp2qnqZrPqZaqsz5+iz+z7
         n78uROnnicjHUH7fUCCbSyhXhREjvdzjMrYCnQu8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125.115827.1407196401514719611.davem@davemloft.net>
References: <20190125.115827.1407196401514719611.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125.115827.1407196401514719611.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: 517952756ed3027a9b776e331985320a829b9f62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abfd04f738c2625f63e04c8fc7cadb3b7a70d580
Message-Id: <154860990337.19009.7314292768917553777.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 17:25:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 11:58:27 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abfd04f738c2625f63e04c8fc7cadb3b7a70d580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
