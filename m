Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCVVVc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeCVVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:21:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145A521770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 17:21:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] mm, vmscan, tracing: Use pointer to reclaim_stat struct
 in trace event
Message-ID: <20180322172128.41959c1d@gandalf.local.home>
In-Reply-To: <20180322141022.f02476e1f76338ab9cecf62e@linux-foundation.org>
References: <20180322121003.4177af15@gandalf.local.home>
        <20180322141022.f02476e1f76338ab9cecf62e@linux-foundation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 14:10:22 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> Unfortunately this is not a good time.  Andrey's "mm/vmscan: replace
> mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint" mucks
> with this code quite a lot and that patch's series is undergoing review
> at present, with a few issues yet unresolved.
> 
> I'll park your patch for now and if Andrey's series doesn't converge
> soon I'll merge this and will ask Andrey to redo things.

No problem. I can easily update that patch on top, as it didn't take
much effort to write and test it. Just let me know if you do pull in
Andrey's work and I need to do the update.

Thanks!

-- Steve
