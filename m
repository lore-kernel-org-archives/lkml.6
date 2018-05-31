Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756034AbeEaSxB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755877AbeEaSw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:52:58 -0400
Date: Thu, 31 May 2018 14:52:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
Message-ID: <20180531145253.02daa5d4@vmware.local.home>
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 11:46:38 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Steve,

Hi Tobin,

Sorry for the late reply, I'm currently at a conference and have had
little time to read email.

> 
> Could you please take a quick squiz at the final 2 patches if you get a
> chance.  I assumed we are in preemptible context during early_init based
> on your code (and code comment) and called static_branch_disable()
> directly if hw RNG returned keying material.  It's a pretty simple
> change but I'd love to get someone else to check I've not noob'ed it.

I can take a look, and perhaps do some tests. But it was Anna-Maria
that originally triggered the issue. She's on Cc, perhaps she can try
this and see if it works.

I'll still pull the patches and add some injections to see how it works.

Thanks!

-- Steve
