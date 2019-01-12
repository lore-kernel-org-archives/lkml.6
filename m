Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454A7206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318709;
	bh=lL+E6+wi4i3WSKxx6DrB+vlrIHzjNGX5kVlqnwjpYlY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oUge+R+2KuUZipyrC/MayAbWZevfnSMg6GJx08A8HRcNn3Dx2QewDLcSKIOw3a+gR
	 AOITJ26ZP8TfxCzHXlgrdhB0IXKseZWbGMfGdB9Okx2PfDwQYCfTEOkFaGPTi7/h59
	 2nU9NGE479tDXnKYTRAXi4nEos0HTGjQ/Ytob60E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfALSpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfALSpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:45:02 -0500
Subject: Re: [PULL] drm-fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318702;
        bh=lL+E6+wi4i3WSKxx6DrB+vlrIHzjNGX5kVlqnwjpYlY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KtheN62fVDywExVIrScIQfdxEPb/aQ2jDl5eMCUgj6bRWi8JNn52mpPe39gDJauuF
         NLXgDBgeuYT3lJkKXdi+AHel35wGHlDu3Vz7DNCkNIkWupgDX0SQu0Ytvo9Ue9vxqt
         I3YHYHotUmQaceK/jbOu4S7B0VJ59IAGwqdv7f5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190111230648.GA18543@phenom.ffwll.local>
References: <20190111230648.GA18543@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190111230648.GA18543@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-01-11-1
X-PR-Tracked-Commit-Id: e2d3c414ec0f9d1557c8c5ff2c32166e68bbc4ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b5c8f5226bd0eb77da8a055f43b2f1a06e92ba8
Message-Id: <154731870230.17522.5266752045302273030.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jan 2019 18:45:02 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jan 2019 00:06:48 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b5c8f5226bd0eb77da8a055f43b2f1a06e92ba8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
