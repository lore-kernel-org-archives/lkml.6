Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeCFOBV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbeCFOBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:01:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6CC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Mar 2018 11:01:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Wang YanQing <udknight@gmail.com>, jolsa@redhat.com,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Provide libtraceevent with a kernel symbol
 resolver
Message-ID: <20180306140117.GB10176@kernel.org>
References: <20180115044732.GB20373@udknight>
 <20180208122031.GA30130@krava>
 <20180306073658.GA7964@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306073658.GA7964@udknight>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 03:36:58PM +0800, Wang YanQing escreveu:
> On Thu, Feb 08, 2018 at 01:20:31PM +0100, Jiri Olsa wrote:
> > On Mon, Jan 15, 2018 at 12:47:32PM +0800, Wang YanQing wrote:
> > > So that beautifiers wanting to resolve kernel function addresses to
> > > names can do its work, and when we use "perf report" for output of
> > > "perf kmem record", we will get kernel symbol output.
> > > 
> > > Signed-off-by: Wang YanQing <udknight@gmail.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Hi! Arnaldo Carvalho de Melo
> 
> What is the status of this patch now?
> Does the patch sanked to the bottom of your mailbox?

It looks ok, but you forgot to add a before and after output of tools
affected by the patch.

Reading the patch one can try and figure out how to test your patch, but
if you show how the output is changed, providing the exact command line
used to produce the output, then you will make it easier for reviewers
to reproduce your results, testing your patch.

I try to do this for every patch, so it all adds up, please help me with
reviewing your patch :-)

- Arnaldo
