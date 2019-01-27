Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5827C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392C20881
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548609907;
	bh=By9OtlWBCO/2nkIRWNFElytRojfVTbzLlVj4mdE4RSA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uGzza8X8+05Ii6F5cPkuvtMIgwlZI/uKqq+T4hI9Yb8WJ4lq8UaQ98+KyPdIncWyU
	 +txm3c2iQ9Izyo24b9dVzil4cx4WnUFKuOIg0nXCHHbY3p52PL/9lA3wozSZaeJRoJ
	 F8MnDIQnsYH9D+h4KkknuraYZfwe01SgLwcPpNVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfA0RZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfA0RZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:25:05 -0500
Subject: Re: [git pull] Input updates for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548609904;
        bh=By9OtlWBCO/2nkIRWNFElytRojfVTbzLlVj4mdE4RSA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MNVEL16L2HFyqo3xqWWBZzUzVaWRgxuh1fkCg9nUL6hH0nD4ncMsZJZH0ooZT3WZf
         E6Dtxkho5HLstm4SOLbf9Upoi2BNdXgKD1uMIO9DJkYnMqY8Lx1HUSQTBu4eGFVgUO
         Ht2YZo36Ldv5v5G+kG8ZghrjGGGroLBvT5DC053w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190126011113.GA23858@dtor-ws>
References: <20190126011113.GA23858@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190126011113.GA23858@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 141e5dcaa7356077028b4cd48ec351a38c70e5e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78e372e6509bc2412e86afb11be65185f4c9c568
Message-Id: <154860990465.19009.15601039563890389947.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Jan 2019 17:25:04 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 17:11:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78e372e6509bc2412e86afb11be65185f4c9c568

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
