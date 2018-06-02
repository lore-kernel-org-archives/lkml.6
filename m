Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeFBO7p (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:59:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeFBO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:59:41 -0400
X-Google-Smtp-Source: ADUXVKIaaw+YD2/sHnaWOz0EIJL+QTqMMKDAH2f/Citoxc1BS5tN0ZZHIOUMjT20iJZnnC8oS9PU/Q==
Date: Sat, 2 Jun 2018 16:59:37 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, riel@redhat.com,
        pasha.tatashin@oracle.com, jschoenh@amazon.de,
        Kate Stewart <kstewart@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
        yang.s@alibaba-inc.com, Minchan Kim <minchan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Change return type to vm_fault_t
Message-ID: <20180602145936.hsrcq2tptmlrc4on@ltop.local>
References: <20180529143126.GA19698@jordon-HP-15-Notebook-PC>
 <20180529145055.GA15148@bombadil.infradead.org>
 <CAFqt6zaxt=wXjvKV0qA+OwU1iUyoBdW2cJSLFqXupVWRpKdqEA@mail.gmail.com>
 <20180529173445.GD15148@bombadil.infradead.org>
 <CAFqt6zZCX7Ai2w9dV3OvUn=V4Z02H=+FBirjHT3QSU1Fuz+uLQ@mail.gmail.com>
 <20180530111602.GB17450@bombadil.infradead.org>
 <CAFqt6zbGyDktxBe0t4W-G8bicA4P8-vDm6fOk+kTod7SHoxvZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbGyDktxBe0t4W-G8bicA4P8-vDm6fOk+kTod7SHoxvZA@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 08:25:29PM +0530, Souptick Joarder wrote:
>   CHECK   mm/gup.c
> mm/gup.c:394:17: error: undefined identifier '__COUNTER__'
> mm/gup.c:439:9: error: undefined identifier '__COUNTER__'
> mm/gup.c:441:9: error: undefined identifier '__COUNTER__'
> mm/gup.c:443:9: error: undefined identifier '__COUNTER__'
> mm/gup.c:508:17: error: undefined identifier '__COUNTER__'
> mm/gup.c:716:25: error: undefined identifier '__COUNTER__'
> mm/gup.c:826:17: error: undefined identifier '__COUNTER__'
> mm/gup.c:863:17: error: undefined identifier '__COUNTER__'
> mm/gup.c:865:17: error: undefined identifier '__COUNTER__'
> mm/gup.c:882:25: error: undefined identifier '__COUNTER__'
> mm/gup.c:883:25: error: undefined identifier '__COUNTER__'
> mm/gup.c:920:25: error: undefined identifier '__COUNTER__'
> ./include/linux/hugetlb.h:239:9: error: undefined identifier '__COUNTER__'

It seems you're using a rather old version of sparse.
Please use something more recent like v0.5.1 or v0.5.2.

Regards,
-- Luc
