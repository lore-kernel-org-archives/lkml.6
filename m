Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56980C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E92133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546727554;
	bh=Tj8WtWMZNEPpdp5fhAGE/8NQMUvRHqZQ1nRJLohQvcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wKQDyRekEuOvrveRivecE7dPE3f6naMha5Il+rnyEbWuh37crE3XQQXDc7b7qeaTe
	 cCb0WE5/dfYFMCT7EsimFI538xgowC/GjNawCPIEDYNlQS1DynVofBu0K6g3sNgca+
	 6u+9cfqMbWIde/d7d7F0RYIHMqqShftEJ+Ox2d9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfAEWc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfAEWcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:32:15 -0500
Subject: Re: [GIT PULL] Ceph updates for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546726501;
        bh=Tj8WtWMZNEPpdp5fhAGE/8NQMUvRHqZQ1nRJLohQvcc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sq6N1zsonACae/0q1JqXMrqHi6I4a6VBzvFBtHHIMfEqEcEkj9xlimaEvQDmv1Oni
         5ZedEKHoNNPedcOKSrFQyQsZv1n7U5aAWFI6Lfsk+m05IqhfcFnxR4iKBd8sw3HnGQ
         6d3LTTDf7p62YxB4rAPKPUeQriahzsMDv9lICQOE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190103153926.15596-1-idryomov@gmail.com>
References: <20190103153926.15596-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190103153926.15596-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-4.21-rc1
X-PR-Tracked-Commit-Id: 5ccedf1ccd710ba32f36986b49eeb764e53e7ef1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7eaf342ecb164d79275a6c1c93aef19293a4aaf
Message-Id: <20190105221501.6651.19179.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 22:15:01 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Jan 2019 16:39:26 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7eaf342ecb164d79275a6c1c93aef19293a4aaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
