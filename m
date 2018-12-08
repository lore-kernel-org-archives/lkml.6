Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EF92081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544298605;
	bh=zEuGU13IArWWSbp134m1V8gYJwGnmeicLOpqnd6lQJA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=P6FNEyMRnf5qtn6xnT0rtYWiO6i9JNahG8r+fkh829iCz3qpyjXnpx8VBrK3jIg1e
	 NAO9VaCqnNnx0ERN3V+wJbOvTjE+uvL02V0ioOcdXY5DaDz9qynACckFMCglSDh2AO
	 gZPFlHM04+gSPX43cO2/0XFSLm65Cc9FNeNNu9XA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EF92081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLHTuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 14:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbeLHTuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 14:50:03 -0500
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544298602;
        bh=zEuGU13IArWWSbp134m1V8gYJwGnmeicLOpqnd6lQJA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cMx8YR2oUagBF1FUOL0POAcLyTQy7QUm08PTaQKUwKR6lWTIK4QN/+Uz+SVqMxB4v
         jPD1wMafiQRaWc9ByuxIxf0pKa7NGeEwwgK6gT+LKzfLo36HA9m3sgNyAyTAn2hJBC
         34vz8ZVN0t2YHarnRLefWoYL+YJBxFng3Jf9wiQk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181208163639.GR24487@magnolia>
References: <20181208163639.GR24487@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181208163639.GR24487@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-4.20-fixes-3
X-PR-Tracked-Commit-Id: 8f67b5adc030553fbc877124306f3f3bdab89aa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f896adc42d5399eb68c9900bd4fd471ccea895e4
Message-Id: <20181208195002.26881.60617.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 08 Dec 2018 19:50:02 +0000
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org, Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Dec 2018 08:36:39 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-4.20-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f896adc42d5399eb68c9900bd4fd471ccea895e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
