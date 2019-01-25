Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A4C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C2F218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458433;
	bh=p1D3zPvJ4sgpqWOsEQZDFXHltdY78uKWRxhaEHY5JVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fYzSY/ghJuRKmMJmKTzBFl+40nNy4YYE3Ep0LrglRR814KS1HCoS7K3fw1NsF3Qm5
	 w+AHohnp+LzbOarrt8FgvTOfKpAaGXp5F+2lVc/Y6RAqX9smtS8Hyw76zyxn6MUbwQ
	 WrUlcWM6OtBJuLyXjE9ECqafciIa5Ba+R3KgNOf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfAYXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbfAYXUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:05 -0500
Subject: Re: [GIT PULL] TTY/Serial fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458404;
        bh=p1D3zPvJ4sgpqWOsEQZDFXHltdY78uKWRxhaEHY5JVw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N2cRDojMdwb7I11Nh2c7RpoE9umGf9KQonnqAjnkkphMQjwqHnOnaRL7H1YSGl0Dh
         6N4vOsJhrJhILt4JmZYi5RwVWqzgRRjV9AmIg5I8D9c3qKmK2E89KvqbQr+KAK+7yD
         7cmLwcs7p25s4hmHor+0cPbw8HHU2kNHM/Jg50UM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125122244.GA7566@kroah.com>
References: <20190125122244.GA7566@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125122244.GA7566@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc4
X-PR-Tracked-Commit-Id: 815d835b7ba46685c316b000013367dacb2b461b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 473721f9c6494c04991b9a4cb787361d941d0d7d
Message-Id: <154845840471.30665.10061363919475186139.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 23:20:04 +0000
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

The pull request you sent on Fri, 25 Jan 2019 13:22:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/473721f9c6494c04991b9a4cb787361d941d0d7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
