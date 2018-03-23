Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCWOPv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbeCWOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:15:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A65B21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 10:15:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH] mm, vmscan, tracing: Use pointer to reclaim_stat struct
 in trace event
Message-ID: <20180323101548.1f091c93@gandalf.local.home>
In-Reply-To: <20180323135225.GV23100@dhcp22.suse.cz>
References: <20180322121003.4177af15@gandalf.local.home>
        <20180323134200.GT23100@dhcp22.suse.cz>
        <20180323094753.760b2c86@gandalf.local.home>
        <20180323135225.GV23100@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 14:52:25 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Fri 23-03-18 09:47:53, Steven Rostedt wrote:
> > 
> > The one solution is to pull the tracing file
> > include/trace/events/vmscan.h into mm/ and have a local header to store
> > the reclaim_stat structure that both vmscan.h and vmscan.c can
> > reference.  
> 
> I guess we can live with the public definition as well.
> 

Yes, that would be easier. Thanks!

Then if Andrey's patches are not pulled, then this patch will be good
to go.

-- Steve
