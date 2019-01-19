Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D4C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3512086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547935223;
	bh=uguOHBoBcerRn2Bgxsxa53BJMO4ZGwkn6Xy5USS4Jpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QRt4Dg8Eva6AMos9H5Qkm3T/EwvPs7UWNBbAO/92IPueX8fRjhRImno606/3bnt+e
	 l3IF7ZL8ntGCepBKODevePStRIYaOPTd+VziHWqZE0doqvsFuOi7HHC+oRoh8GS3sr
	 vd8m063T1MgFgyU8Q0cNPpjhKyapmEWXEYJmtA/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfASWAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfASWAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:00:02 -0500
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for 5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547935201;
        bh=uguOHBoBcerRn2Bgxsxa53BJMO4ZGwkn6Xy5USS4Jpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ghnSUQ5SytLz3ZrOllqlNCaJD+thYSoIAVOlpOFsuVwkbyWxVAdKGGwLsZJL3xlG6
         Ov2a/xQLHwfm/qwU5w7RZxmX4E0APt5bDwgg9xJYzBebjkt9Ycz87W2AANCd50kGJP
         DQ5afhgDxVuxT+Gdwb2xxNAnY7GKsPhDRlkM18pc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d64e31f9e6021428fc2d3765da01e5976f1a9923.camel@netapp.com>
References: <d64e31f9e6021428fc2d3765da01e5976f1a9923.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d64e31f9e6021428fc2d3765da01e5976f1a9923.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.0-2
X-PR-Tracked-Commit-Id: deaa5c96c2f7e8b934088a1e70a0fe8797bd1149
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0efca46b57071e4c281034f04d2b56edf79843d
Message-Id: <154793520147.21907.855863470763551924.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jan 2019 22:00:01 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 21:20:28 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0efca46b57071e4c281034f04d2b56edf79843d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
