Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D04C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6182196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422205;
	bh=2xsfev7/RGVCSlBVIVTZFZbfJsvwpI1JhVzzYZ+VuXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LtlJ5CDD6hEIfq48/SUVAu9d/G9F8O+aPvPQhw2qJzXepdtjI0gV9t+yv2wCbFem2
	 57KszEfzPQ4LD1GBii/lY4PCklcm+ADE8db5EI+QjNXwOVzAIcZG+QwH4UmtgB8Ua4
	 lDcaI6rFoKN5o8awBLxfAPXpIp0erV6TIBhJP+cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBQQuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfBQQuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:02 -0500
Subject: Re: [GIT PULL V3] csky fixes for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422202;
        bh=2xsfev7/RGVCSlBVIVTZFZbfJsvwpI1JhVzzYZ+VuXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dHsHHz21jB+rOFtCPMo3UbUzmkB5QLS+ucdh1C8udKmAxO8Hp84VmMUvwBQCFSjL+
         P8qcBMtMfAqx7xfLOToyZ8w/he8Hs9zsVYVBFvTyanrggm/cL2YUI/IrtdU2bN7Mvs
         pB4NkitVqRTsKU5A4lUJaHrMhUvQ7divAxvQf6Yk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1550041628-19985-1-git-send-email-guoren@kernel.org>
References: <1550041628-19985-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1550041628-19985-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: git@github.com:c-sky/csky-linux.git
 tags/csky-for-linus-5.0-rc6
X-PR-Tracked-Commit-Id: 131aee8b9807bc98379fa5a0270389dbc7dcec90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0513ebc33ed6b590bfbaaf21cd7b3d571c20edb9
Message-Id: <155042220216.16506.594342102190348541.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:02 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Feb 2019 15:07:08 +0800:

> git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0513ebc33ed6b590bfbaaf21cd7b3d571c20edb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
