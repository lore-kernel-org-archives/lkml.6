Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16BC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E82146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548615906;
	bh=ZKr5ruyGQNFYRl1FL9RwAgb1rafNdWYy0IcOLTtu1ZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ks2wCKEVWa701is+jSHhB5INDDMG47cydkoWI2F6+XFAex8pSB7enwUws9PpwxHWp
	 cgLdsUSzZxqVYESQoTwMAJwmXCSEunhKDTxqO8aq63aq4zAmy7N6bLD1rT7eFaXxwK
	 ad3I9QpZkrv2pIpDgTfLlLhPgdpWB5bXxZ2LnmHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfA0TFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfA0TFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:05:04 -0500
Subject: Re: [GIT PULL] EDAC fix for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548615903;
        bh=ZKr5ruyGQNFYRl1FL9RwAgb1rafNdWYy0IcOLTtu1ZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RKUjTKRGDNzBOFHVERYVbzVqIgPkSBtmnjtMk+F7cynUEtL47j3xob+b9VVJDmVfD
         AqC+1HbQwIDzzUUMjwqeSGGxdWL5YTMB8f6V0pK03KJfye+QQXj2bS+5j7Uuip6kdJ
         wBMK0oSSfRx9xKI7rHqY3g09B7idrVLfoe14zbBE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190127114154.GB3916@zn.tnic>
References: <20190127114154.GB3916@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190127114154.GB3916@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
 tags/edac_fix_for_5.0
X-PR-Tracked-Commit-Id: 245b6c6558128327d330549b23d09594c46f58df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 983542434e6beef911d5ae4488c49080a177e5e4
Message-Id: <154861590356.4831.1139036714488811530.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 19:05:03 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Jan 2019 12:41:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_fix_for_5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/983542434e6beef911d5ae4488c49080a177e5e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
