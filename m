Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163028AbeE1N7q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:59:46 -0400
Received: from imap.thunk.org ([74.207.234.97]:34992 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163002AbeE1N7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:59:40 -0400
Date: Mon, 28 May 2018 09:59:15 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
Message-ID: <20180528135915.GG4613@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:46:38AM +1000, Tobin C. Harding wrote:
> 
> During the versions of this set I have been totally confused about which
> patches go through which tree.  This version again puts all 4 patches
> together in the hope they will go through Andrew's tree.

I'm also happy to take the whole patch series through the random tree
if everyone else is OK with it.

Thoughts?

					- Ted
