Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEDOu5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEDOu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:50:56 -0400
Date: Fri, 4 May 2018 10:50:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: avagin@virtuozzo.com, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: Re: [v2] mm: access to uninitialized struct page
Message-ID: <20180504105052.429106ca@gandalf.local.home>
In-Reply-To: <CAGM2rebLfmWLybzNDPt-HTjZY2brkJ_8Bq37xVG_QDs=G+VuxQ@mail.gmail.com>
References: <20180426202619.2768-1-pasha.tatashin@oracle.com>
        <20180504082731.GA2782@outlook.office365.com>
        <CAGM2rebLfmWLybzNDPt-HTjZY2brkJ_8Bq37xVG_QDs=G+VuxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2018 12:47:53 +0000
Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> Hi Andrei,
> 
> Could you please provide me with scripts to reproduce this issue?
> 
>

And the config that was used. Just saying that the commit doesn't boot
isn't very useful.

-- Steve
