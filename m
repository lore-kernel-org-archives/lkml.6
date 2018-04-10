Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDJPua (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:50:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDJPu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:50:29 -0400
Date: Tue, 10 Apr 2018 12:50:26 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        sandipan@linux.vnet.ibm.com
Subject: Re: [PATCH] tools: restore READ_ONCE() C++ compatibility
Message-ID: <20180410155026.GA11134@redhat.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
 <20180409171041.6qfabrccsqu4bdlc@lakrids.cambridge.arm.com>
 <20180409194032.GA7184@redhat.com>
 <20180410105515.oma5rzzh5y3ghhkx@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410105515.oma5rzzh5y3ghhkx@lakrids.cambridge.arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 10, 2018 at 11:55:15AM +0100, Mark Rutland escreveu:
> On Mon, Apr 09, 2018 at 04:40:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > Now 'make LIBCLANGLLVM=1 -C tools/perf' works, but I'll look at the
> > patch below, probably it will save some time in the future if we get to
> > include compiler.h from C++ code again...

> > Take a look at my perf/urgent branch, that I just asked Ingo to pull.
 
> Ah, that's great.
 
> Sorry for the noise!

No noise at all, your patch is valid and I'm applying it. At some point
some code will include compiler.h at some include chain from a C++ file
and clang will explode once more, better fix it now :-)

- Arnaldo
