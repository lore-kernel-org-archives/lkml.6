Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9F5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E21218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046106;
	bh=4UfUeXvoHD1tvthOqIMbThqgry4q+5Rii9qBPFrYe4s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T5oplE70OEkZ7IMXldYZgkNwFchhIeCcTUL/rijJsEen7nmtjqLmeyyiEoSj4GM53
	 SVZSyHQxCokfjNGbcuz46VxoELg+7SMvKghmsHpjQTnymKasJdgAHZBOqDsnjr1EHL
	 oyti7kZhst/TMmCRPERUZp6/DSMyKkrqBRdqAMOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfBASfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfBASfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:04 -0500
Subject: Re: [GIT PULL] i3c: Fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046103;
        bh=4UfUeXvoHD1tvthOqIMbThqgry4q+5Rii9qBPFrYe4s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gENWpO4+8/agfVqrCjhUf6rbjnSLma4aZ4l6WumHkFrQASpCpT2mUM6UJeSqDXT7E
         +f446mbSlzEne1ozVwQizwpr3JEVO9WhlFMgU0PmAIUn2fFRBrETfvHSDDlLQU7sCM
         pNqPc9EOCCcQlrfIgo6vbnsHVxnICvMr1/gNsE9k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201094058.74f3cb6a@bbrezillon>
References: <20190201094058.74f3cb6a@bbrezillon>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201094058.74f3cb6a@bbrezillon>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 tags/i3c/fixes-for-5.0-rc5
X-PR-Tracked-Commit-Id: f36c1f9a8dfd6a78e6c3fe7aff5e722b84307597
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 520fac05b65106f0f3a488776f759baccc600f2a
Message-Id: <154904610329.32661.14766825386214617909.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:35:03 +0000
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-i3c <linux-i3c@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 09:40:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/520fac05b65106f0f3a488776f759baccc600f2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
