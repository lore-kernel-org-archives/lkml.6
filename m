Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeFDShr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:37:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40474 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:37:46 -0400
Date: Mon, 4 Jun 2018 19:37:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] vfs, pile 4
Message-ID: <20180604183744.GM30522@ZenIV.linux.org.uk>
References: <20180604181813.GK30522@ZenIV.linux.org.uk>
 <CA+55aFw4ikYgcN-sYvQFmu--D60pSvbUjAPJrg5g3fCEdYykdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw4ikYgcN-sYvQFmu--D60pSvbUjAPJrg5g3fCEdYykdg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 11:24:38AM -0700, Linus Torvalds wrote:
> Trouble counting to five, Al?
> 
> I'm getting "one, two, many" vibes.

*blink*

FWIW, originally I considered combining the first two (they are
closely connected), but in the end decided to send them as two
separate pull requests.

So consider today's pile 4 as #5 and 5 - as #6 (or, better yet,
"->lookup() cleanups" and "most of aio stuff").  Sorry...
