Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0BA218AF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546307105;
	bh=4ccfoIcz8hHSH7I7quI0FKMtMyXrm/XaZtyvm2MXxTA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jB/33hl8+Wgi6vOzT711U8T0Nt1IkZzeTMke9n5W/Ou0M2fw7vdRqey+lqTQs1BVi
	 /vI8VUGt56K0HSbTSW1YUEtwln9UGp+GbBGDQZtDcDeBrFliggzxvkS8jNEwOszWdG
	 k2Ey3Pm8tWqnJ6oKrIUEl53x5rUNv/XmLIS8kklY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfAABpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbfAABpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:45:04 -0500
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546307104;
        bh=4ccfoIcz8hHSH7I7quI0FKMtMyXrm/XaZtyvm2MXxTA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aSaN3hCzU2fkaG5ivvoNVzElBwteoPoRKYC3gCjRtlTQ/yvgCym9PZqCK9YTd4nlO
         iFfxzMTRVM2mAPpjxppb3k+nY/kp30benIjWUU8Baf1lUOssTufWwjVvdmIfC4U5Sf
         b7T/sd4U5YjmR1B7xTz1De091uOja6qmeXZih4p0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-2-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: cac1fc8fb561ac766468394d49c3dd11a2b8cb44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0922275ef157ba8ac93e7e7857087eb0442d5397
Message-Id: <20190101014503.19922.77591.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 01 Jan 2019 01:45:04 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Dec 2018 13:46:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0922275ef157ba8ac93e7e7857087eb0442d5397

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
