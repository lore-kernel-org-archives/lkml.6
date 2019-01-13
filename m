Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660982064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547402708;
	bh=/qdZ8pMA1wY1OqleipTZgM5qjSC2X0oxTcZFYnGDN/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=euzjRgrDyONYAZngYra2mYpBhv/lzpjf4H3Fm5ysrDU3vr8SY0EgXnQNpBQwzXggp
	 QUy4oAVSolpSwp56ek1+SIIL0IVsLy/SPdND804gTS5qk9s9Xau7jIidAYAfn2VVYr
	 4p7xR9V1I7Hf/nBW2wNkX3KeO6ljwxll2rQ1SNuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfAMSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfAMSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:05:02 -0500
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547402702;
        bh=/qdZ8pMA1wY1OqleipTZgM5qjSC2X0oxTcZFYnGDN/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sCXJlKJUTGvG89e15BXS6h1qnISop9l+V8WKYsau4DUc64Cok4G3VeylBYpuNhiwb
         f4CNUsUJp5uNdVQhHoCtOmwQMjJTsesEwq6h0AqGdhfT2iDpgMp3Y9UaWo5CMBV+Ah
         UwSx867wJ8f3CepMXoZrdq8ys1WdZEBDXg8pY+2A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113102316.GA17169@kroah.com>
References: <20190113102316.GA17169@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113102316.GA17169@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc2
X-PR-Tracked-Commit-Id: d3736d82e8169768218ee0ef68718875918091a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 437e878a6c48028273e4b06be7e09d235b189e62
Message-Id: <154740270208.11831.4173459838960263884.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jan 2019 18:05:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 11:23:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/437e878a6c48028273e4b06be7e09d235b189e62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
