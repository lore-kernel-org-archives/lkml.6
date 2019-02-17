Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3BA21924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422239;
	bh=MFor3eqcdyEpErGV3JtBXyfUZ1yoW2tC2iUC191J8Mw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NseNmR+CDAettbvj+j4q3CmmFPbXR6y42iINo+9I9gvMAN6jlEcjhzIf1h2BvScML
	 emVawa/1MaKtC3CARfZCmCjyrCvAnAmD4XzQlTjZnsxx6Owu+vJlmv0xauENNQT6ee
	 go82L+/7gDt5fc6lnJJExc7FlFemG2mmRJJTiCio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBQQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfBQQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:03 -0500
Subject: Re: [GIT PULL] KVM changes for Linux 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422202;
        bh=MFor3eqcdyEpErGV3JtBXyfUZ1yoW2tC2iUC191J8Mw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qa/pXxul0Z9pKJ9ehsbFEQypzeG31zAKMYa0AaeOARSmpMifn15JjtknO4c213ME9
         hPkkKwEqvvUQohY2encBC4Txk1adfUZlHGzNaTo6tk6fw4cCZ7thwzvngVcJ9gkMLv
         /eMcdVNVCFNnQ/fQphpeToFMaI04kejrDLjxuetc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1550386817-50269-1-git-send-email-pbonzini@redhat.com>
References: <1550386817-50269-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1550386817-50269-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 98ae70cc476e833332a2c6bb72f941a25f0de226
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed0a0ec98ffcaa67f8cb3e6237cdf6f29acd9481
Message-Id: <155042220255.16506.18071668456594478568.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:02 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Feb 2019 08:00:17 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed0a0ec98ffcaa67f8cb3e6237cdf6f29acd9481

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
