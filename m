Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCLOcS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:32:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33345 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeCLOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:32:17 -0400
X-Google-Smtp-Source: AG47ELvLg/2C1EweV/bUkzqJrjaQcbRJ6o0SUMLRmWlZTjhxSgZCKz+ukr+fidnpKrMowaPRGsu9Vg==
Date: Mon, 12 Mar 2018 15:32:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com,
        gorcunov@openvz.org, luto@amacapital.net, keescook@chromium.org,
        willy@infradead.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        bp@suse.de, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ebiederm@xmission.com, jgross@suse.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312143212.77z2ptyqbsbqdll3@gmail.com>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
 <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> > We can of course bike shed / benchmark this once my desktop refresh
> > sports this feature, but ISTR this being one of the very first things
> > Ingo mentioned when we started this whole 5L thing.
> 
> I would rather not fix the problem that may not actually exist. :)

That 5 level pagetables involve more overhead is a realy problem.

By default we should only enable 5-level paging if memory mappings exist in
the memory map that require the extended physical memory space.

Thanks,

	Ingo
