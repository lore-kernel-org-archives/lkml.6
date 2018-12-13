Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342D020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735737;
	bh=w2QviF4AkcHAJBXiCPyJZEXyDK9h0VMLbaMNyU3ku+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EX3ciRVu+HU7lHciUBBEazcb7NcnTIq1FAyzV8MgW2F0NcSf5Pv0oOdWOoiLMRmaf
	 fCKvsD/v9FMfRwgWvw5tC1CZp+SCYng/H/p5P4bPYeuQa+1ke6EG+uDi/Wb/ibQdvk
	 nCYbIuC10GUHx5ErOpjzhEjyfdxlT/tmDjqxJOD8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342D020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeLMVPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLMVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:02 -0500
Subject: Re: [GIT PULL] fuse fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735701;
        bh=w2QviF4AkcHAJBXiCPyJZEXyDK9h0VMLbaMNyU3ku+4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hWzBg2oUCR6YpfyQMYGWwAWGXEfJ3lStSyuwygHuLqUtm71oPGSL2brtg2l4+VtT+
         xVYxPzHOjeLqsHvWt8epQ9xAjMwb8he1WMn8saz/Ipngqsq7qFCeH2ht92NL8Hfcas
         5d3lKaFRxgIcThsvCAsqDcJUf4FjIJs+djMsuPE4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181212093317.GA15517@veci.piliscsaba.redhat.com>
References: <20181212093317.GA15517@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181212093317.GA15517@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-4.20-rc7
X-PR-Tracked-Commit-Id: 2e64ff154ce6ce9a8dc0f9556463916efa6ff460
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70f4828201e3bc9a5ac52d1f7ede06e56194268a
Message-Id: <20181213211501.3163.28358.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Dec 2018 10:33:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70f4828201e3bc9a5ac52d1f7ede06e56194268a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
