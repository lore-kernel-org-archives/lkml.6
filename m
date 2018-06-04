Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeFDO7K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:59:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753743AbeFDO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:59:09 -0400
Date: Mon, 4 Jun 2018 09:59:02 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>, Joe Perches <joe@perches.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
        damian <damian.tometzki@icloud.com>
Subject: Re: [PATCH 00/29] objtool sync up for the stable 4.9.y tree
Message-ID: <20180604145809.3uqin3jvooefd2bg@treble>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 02:26:23PM +0200, Greg Kroah-Hartman wrote:
> There are pros and cons of dealing with tools in the kernel directory.
> The pros are the fact that development happens fast, and new features
> can be added to the kernel and the tools at the same times.  The cons
> are when dealing with backported kernel patches, it can be necessary to
> backport parts of the tool changes as well.
> 
> For 4.9.y so far, we have backported individual patches.  That quickly
> breaks down when there are minor differences between how backports were
> handled, so grabbing 40+ patch long series can be difficult, not
> impossible, but really frustrating to attempt.
> 
> To help mitigate this mess, this patch series works to sync up the
> objtool code with the version that is currently in 4.14.47.  This
> required a number of objtool old patches to be backported, a single big
> "sync the world" patch, and a lot of include file updates to get
> everything all working properly as well as some minor fixes for build
> warnings.
> 
> And at the end of this series, is a set of backported objtool patches
> for gcc-8 that was the main reason this whole patch series was created.
> They applied just fine, being the identical version that goes into the
> 4.14.y stable tree, so it feels like the backport was successful.
> 
> This has survivied my limited testing, and as the codebase is identical
> to 4.14.47, I'm pretty comfortable dropping this big change in here in
> 4.9.y.  Hopefully all goes well...
> 
> If anyone has any objections to this patch series, or finds anything I
> messed up on, please let me know.

Thanks Greg.  Looks good to me.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
