Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C19520818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549540506;
	bh=f8YO7V6Svg33ESgGNiJVH1MFoD2mCccDKYYh7X+qbG4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p/R16MnqULPjSDJc+NyRiJIrQr4CA4rqFOGzGWQ0mTSJBifgZxiQ50i4r+sdDvuj9
	 vDKu5SJbCct/bpBkBHQN667Khcrgxs/VUqmu6o23lVb6GhNhbyI4Pyba7i3mg07hJd
	 uybuRPo9G8vpOBnAfurb5JkmGpnA4wqlu5PZP0lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBGLzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGLzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:55:04 -0500
Subject: Re: [GIT PULL] HID fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549540504;
        bh=f8YO7V6Svg33ESgGNiJVH1MFoD2mCccDKYYh7X+qbG4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YZgBV/pD7wdYHOl4nNhEDyBKm0IAbortyZmF0QIRRNoIGDQC5M2+SxI9BH3NnZHyr
         mK7WeyW4cCUEoPUTGJkz8TAQgJalsESLVVq7pJFHMKB0hQQwmAMrOE411Fx/gnwTKX
         dme1P4CoqipYEB5evjBVDLnh75WsWrhIxwt6RS4M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1902071106510.11598@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1902071106510.11598@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1902071106510.11598@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 13054abbaa4f1fd4e6f3b4b63439ec033b4c8035
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d47e3da1759230e394096fd742aad423c291ba48
Message-Id: <154954050430.23568.17019251447925230289.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Feb 2019 11:55:04 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Feb 2019 11:09:31 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d47e3da1759230e394096fd742aad423c291ba48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
