Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2E1218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548349805;
	bh=/89s9jdiEUnWA/nUnWxsTWspXF81hXPui2aFkfQ1p9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ji3bkyOAh2W+R5nkyBYcJCT5irp4J/gvkM4B06iCH9aa39S3OrCcS9NShWDDTp/O6
	 UTkEGf25xLF28fxxb+VZxjpx0zpJ6Q9lbCoP7GEOn8zwedlfZBHVg8qjNURw5cc0RY
	 TKUbGp3DXIodyN5ohd8w7F7xROaDw9LXR6vovCis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfAXRKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfAXRKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:10:03 -0500
Subject: Re: [GIT PULL] Inotify fix for v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548349802;
        bh=/89s9jdiEUnWA/nUnWxsTWspXF81hXPui2aFkfQ1p9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LOAN5E88HzQ2oMwZG/onjAPyO2evwgjGtJvynLNiHTx6FkOpbiuRXEsmXA5suiCnx
         Ni4kjtJ+JzBRqoFDx+rymKbwRGqs8KDGKldEEqB+s7UUpMgwetQRSxYyssUuXj+4/z
         NfW1fJwdTD5WGJ72EHSnNRa8UviMXoFWG6/8XEzA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190124163527.GA10165@quack2.suse.cz>
References: <20190124163527.GA10165@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190124163527.GA10165@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.0-rc4
X-PR-Tracked-Commit-Id: 125892edfe69915a227d8d125ff0e1cd713178f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c04e2a780caf7073c31c4289c4b7c3d62f9c0130
Message-Id: <154834980253.21465.15078994796922770763.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jan 2019 17:10:02 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jan 2019 17:35:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c04e2a780caf7073c31c4289c4b7c3d62f9c0130

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
