Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1FC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36221019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548108009;
	bh=iz8SoDZ0gO4fcAZDUxYBFjX6ak0VMVOX+gZkVCGVpcw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YqItbmiAosI2VYW8GFCv9oTArjcmZk208woxFpDx3XYXwU3C4zCoKOouphIDpqYp7
	 uzP4kgBCNExfqmyrMD+y5OIdGqhXd+idhTwsyWC83gRgCJFSdQieMQWpcFki43p+xn
	 Veu3nJE5LA+QNJpMBzZppXc31Yxvv6/ho64pdclQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAUWAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfAUWAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:00:04 -0500
Subject: Re: [GIT PULL] gcc-plugin fixes for v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548108004;
        bh=iz8SoDZ0gO4fcAZDUxYBFjX6ak0VMVOX+gZkVCGVpcw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yrj0S7xcFH+7zfD5ZyUszYdLHqIhGrHiHL/I18mdYpdEx97by4Zx6ZkzsvqZsRXVo
         tVXU99uqlQwWZGnjVFDF+dCjX6I93hGDtxQeoVi1U6uXMNw7GwUvnLkHNmwkzOC5dK
         R+pfkyZ+98hQp6NXaAt+VPo0nQgcBOU9joLn0/9E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190120222056.GA35153@beast>
References: <20190120222056.GA35153@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190120222056.GA35153@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.0-rc4
X-PR-Tracked-Commit-Id: 2c88c742d011707b55da7b54b06a030c6f57233f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbcfc961939394152cbcf3f17144ff3df359f216
Message-Id: <154810800420.17432.12031507919177748402.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Jan 2019 22:00:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jan 2019 14:20:56 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbcfc961939394152cbcf3f17144ff3df359f216

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
