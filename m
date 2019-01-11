Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D651C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7704720878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547229613;
	bh=u61SgAu3vAZnBiqDl8lgi9fEXxcWhrbJDh+AfYhjEbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=geohB/qDAVAc4ywoxTIXQsPPJwE6duJzsxRr/Cz83YjXqOB5aOb1op5L/m2jEJXbG
	 moO2HYYYARGNNkPJS5TBdDZUmSSMx6Hqu8IbY0BtBZpApYkj6ggVbv+v9Wfo8z0744
	 ztgxNVbIisAEoBF8ZWeYHjAso8yjDxVJlqJMoXRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfAKSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfAKSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:03 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547229602;
        bh=u61SgAu3vAZnBiqDl8lgi9fEXxcWhrbJDh+AfYhjEbA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H5NSj8Zu0zwtkbFGr5Dye1Xp7TYm5o730LLkh1Krg1EvLJtt7i6OFh23o8TmhSDFp
         11ygoPSaa/l40geO2EpdpD379ArOoHyp/NkI/cC7sPu7EB3b40xTSdFcLw8SXEJsM/
         47Iy5JqPpqjVct96D5bHkT+1OZCn387ILwI0BfV0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzYotNYEw4n+-+FDNchOMwJSqTz7Per=dwhghewSuJTRA@mail.gmail.com>
References: <CAPM=9tzYotNYEw4n+-+FDNchOMwJSqTz7Per=dwhghewSuJTRA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzYotNYEw4n+-+FDNchOMwJSqTz7Per=dwhghewSuJTRA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-01-11
X-PR-Tracked-Commit-Id: f34c48e06ddcc197f2cf7cbc006ceb74e28e1ccf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 385c59c7baaa4626f5c01888d50e86e5636e655e
Message-Id: <154722960257.6916.8180263571903240043.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 18:00:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 12:11:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-01-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/385c59c7baaa4626f5c01888d50e86e5636e655e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
