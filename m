Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UHLnKNhoHFvhOAAAmS7hNA
	; Sat, 09 Jun 2018 23:55:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 953E96074D; Sat,  9 Jun 2018 23:55:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9596B6014B;
	Sat,  9 Jun 2018 23:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9596B6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeFIXzv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 19:55:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49782 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbeFIXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 19:55:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRnhw-0003sU-Kj; Sat, 09 Jun 2018 23:55:44 +0000
Date: Sun, 10 Jun 2018 00:55:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180609235544.GI30522@ZenIV.linux.org.uk>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org>
 <CA+55aFxkUYXHNT+GtUFMSSdnNgYBoQu1tvxiWYNrwTJCLbi_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxkUYXHNT+GtUFMSSdnNgYBoQu1tvxiWYNrwTJCLbi_rw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 02:42:20PM -0700, Linus Torvalds wrote:
> Hmm.
> 
> So I had held off on pulling this in the hope that it would get more comments.
> 
> I like most of the vfs-level stuff - it gets rid of some of the
> hackery we had for overlayfs.
> 
> It does add some new hackery to replace it (like the file accounting), though.
> 
> And Christoph's copmmentary isn't really helping the situation.
> Christoph, I haven't seen the NAK history, can you elaborate?
> 
> And Al, can you please take a look?

Will post tonight...
