Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43664C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1234C206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545322235;
	bh=jwLtnDlARolXmrF/NipA+2S6EFUQe3LkfZOFAOvvG08=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l7dsZOI4yqOWFC/sFwEodUuBgJbwMQ+zFEpB+FbuEivOA5hmeFK3OCs+kJjUjnqKB
	 8q/hCa8hC24pd8YjPXLukx01TU8K9Ai8s5BQ/XPmzFtywP87jg4AHQrR9UEwpz4903
	 k0SoTnxh5FbdUB1/ysU9qwGjUvKslvF4mliK5onk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeLTQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732040AbeLTQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:02 -0500
Subject: Re: [GIT PULL] TTY/Serial fixes for 4.20-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545322202;
        bh=jwLtnDlARolXmrF/NipA+2S6EFUQe3LkfZOFAOvvG08=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZOkPUe93UmXRV6tudPEj03dizC4o0xcMOoZHIA5aJNMlNFPrxo+AOL3e9Clt3Som1
         wctG6bqvAFr6u+lCI/06BQ9lqqB8N+iBAR8DwY3O7Qabp7IBTCOM6mVBFsq2S6XReT
         Mamg+2D+/Y1bizhHu4xqsfiqDi3laSCaEFQI0IDI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181220123910.GA18277@kroah.com>
References: <20181220123910.GA18277@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181220123910.GA18277@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 tags/tty-4.20-rc8
X-PR-Tracked-Commit-Id: 3c9dc275dba1124c1e16e7037226038451286813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfd7bd5b49c84aac9068bff7635e94ce038475ec
Message-Id: <20181220161002.12746.71717.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 20 Dec 2018 16:10:02 +0000
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

The pull request you sent on Thu, 20 Dec 2018 13:39:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfd7bd5b49c84aac9068bff7635e94ce038475ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
