Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCQRVR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:17 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35112 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCQRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:11 -0400
Date: Sat, 17 Mar 2018 17:52:41 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 14/36] fs: add ksys_mount() helper; remove in-kernel
 calls to sys_mount()
Message-ID: <20180317165241.GA2226@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyGtWEZFzUKJO5NZNxeh4Z624P0EOy6u-zisJT354eLeQ@mail.gmail.com>
 <20180316084653.GC4151@infradead.org>
 <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Christoph,

thanks for your review. On the basis of the goal of this patch series, I
will stick with the "mindless" conversion for the time being, but add the
following caveat to the commit message:

	In the near future, all callers of ksys_mount() should be converted to call
	do_mount() directly.

Could that be a compromise?

Thanks,
	Dominik
