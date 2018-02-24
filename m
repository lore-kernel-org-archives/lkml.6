Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBXSwC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:52:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbeBXSwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:52:01 -0500
Date: Sat, 24 Feb 2018 19:51:41 +0100
From: Borislav Petkov <bp@suse.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Gustavo Leite <gustavoleite.ti@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, Randy Dunlap <rdunlap@infradead.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH] linux/kernel.h: break long lines
Message-ID: <20180224185141.GC29374@pd.tnic>
References: <20180224181003.29604-1-gustavoleite.ti@gmail.com>
 <20180224183044.GB29374@pd.tnic>
 <20180224184530.GC31264@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180224184530.GC31264@thunk.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 01:45:30PM -0500, Theodore Ts'o wrote:
> static inline int __must_check
> kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)

Yeah, had already typed that one in the reply but then opted for not
mentioning it because it is a bit controversial with maintainers. :)

> Which yes, is still longer than 80 characters.  But this is where
> blindly following coding guidelines as if they are fundamentalist
> biblical doctrine is not really a great idea.  The goal is to make the
> code easier to read, and very often it's important to apply _judgement_.
> (Which is one of the reasons why I generally don't really like newbies
> trying to apply checkpatch.pl to existing source files.)

That's basically what I was trying to say but your formulation is much
better.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
