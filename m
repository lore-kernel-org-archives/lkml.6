Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D06C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EC20868
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546806014;
	bh=un+ulheRuUsenlPYOeHu+uQOP0FS0QJDJm9Jvs5hHVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qpkc2AlLya2aRVR3JPhRMKEq6N+GMg7z7/mALoHhYKAKUOKk7nDHKBBbM2frUqt9P
	 i7elY1ZXCNm4Xxku35fVxBIe1/wFgp0VLoo1JojP7M/bKpYM64P52kGyxEyVw4q/rE
	 z+hBmsBJn4EyxuVT8dh6+enjGwGrhk1a99b2z0Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfAFUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:20:02 -0500
Subject: Re: [GIT PULL] hwspinlock updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546806002;
        bh=un+ulheRuUsenlPYOeHu+uQOP0FS0QJDJm9Jvs5hHVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wa4TBdZ8koYpz1+SO50D/vGuigPWCFJqFnf1BaiVfO6JL77FdLyG+HsbMWkJrLEik
         AQmMcKT6bRTZbd9TI/BFlcb6mBeAw5sKqFtkXDDbBMPVy8AYvTqN5kIP/6wMkc36re
         7QE65l4/D+4czX7SW4gpQSuD82Di+m1dUSUiTdR8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190103200259.GA1563@tuxbook-pro>
References: <20190103200259.GA1563@tuxbook-pro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190103200259.GA1563@tuxbook-pro>
X-PR-Tracked-Remote: git://github.com/andersson/remoteproc tags/hwlock-v4.21
X-PR-Tracked-Commit-Id: 4d5a91fd1f42a821d14b92b082b8e71be9911ba5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66e012f6188fb37b18c774277f34fb52278059c3
Message-Id: <20190106202002.19789.21538.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 20:20:02 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 12:02:59 -0800:

> git://github.com/andersson/remoteproc tags/hwlock-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66e012f6188fb37b18c774277f34fb52278059c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
