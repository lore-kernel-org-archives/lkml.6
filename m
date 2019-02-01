Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18FC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59008218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549046109;
	bh=KFp8jUpJMnvMgTTal96Eja9bo11UBhQwG+sTr57KJ+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qyDVRiXqWd0GkU1Wuy57yIi7IzF/mtVuNOkJB0RbBUHCJ/EIGTnLj/n+823/1fqnJ
	 vj+kKnGTCqZ97c4qdGz/JUDN3oU9wF/rWzv86beki7Tikv98fTzmlUGvk7lmFujknH
	 sFMSPaPqk4rcJ4JILF++JynqMxEjbCrqwmnMDKNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfBASfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfBASfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:05 -0500
Subject: Re: [GIT PULL] iomap: more fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549046104;
        bh=KFp8jUpJMnvMgTTal96Eja9bo11UBhQwG+sTr57KJ+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=req9555XTzLkQm7wPmk50VzjS2A0RU+wub2PsOHgR4BprQx4kCfTnxR1cvyNa+eHJ
         K8OEEy2OEYQZ8XwRcawu8NouMr3/nIJ0xiuDBrfl1NO6TmrALyNPE6iAhTp8vRJpEL
         3M0+7exlCsLnTVNN29FqqgSU+fBsiB8T+ZWirISc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201165616.GG5761@magnolia>
References: <20190201165616.GG5761@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201165616.GG5761@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.0-fixes-1
X-PR-Tracked-Commit-Id: 4ea899ead2786a30aaa8181fefa81a3df4ad28f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ace868a17d875ee18f9127d0f456be6dd88fa47
Message-Id: <154904610448.32661.15336442920973313949.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 18:35:04 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 08:56:16 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.0-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ace868a17d875ee18f9127d0f456be6dd88fa47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
