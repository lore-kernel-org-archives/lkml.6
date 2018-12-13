Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D11AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064520989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735704;
	bh=gwVmHcA5E9prsScFTkxQS/++JBttZ19T/NNGjS7L+dU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IRZlNsTLFJpgMFuO2BD4mSIJHKmmrnWewceSZkmo64YmlCAq3rXC4GqHnlxBZ5oEj
	 s++L7EJXB+QCG0HWixNcjTv3TxkZTkDruWD/mQxz4YCjjMfcvPHsVGqJAbeE+mL/BQ
	 o5mV8gHXzCP3QnlHc2TkV9RGrQJSbHWEc2b2wkLg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5064520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeLMVPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLMVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:02 -0500
Subject: Re: [GIT PULL] overlayfs fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735701;
        bh=gwVmHcA5E9prsScFTkxQS/++JBttZ19T/NNGjS7L+dU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R1sD5xl4KTv9jZUOXA3BPQbueyXBxUgfreWKwhaVMCGf+rFoyLjnmuCV4xFkfuG+y
         7GlrjX80WIkpbrSoOtlf/eJNMkoB0OtBx4naYt4KduPg/mwYtR/WZINPDUuxBg00Kt
         NyoVlDlHrqt+hFAVHFOioPPNU9PHkCY6Ief/1XOk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181212094518.GB15517@veci.piliscsaba.redhat.com>
References: <20181212094518.GB15517@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181212094518.GB15517@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-4.20-rc7
X-PR-Tracked-Commit-Id: ec7ba118b9407c9b4d998b8065167afae5ed04be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6333d72cb373239400969f5d10204c094a9712a
Message-Id: <20181213211501.3163.59029.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Dec 2018 10:45:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6333d72cb373239400969f5d10204c094a9712a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
