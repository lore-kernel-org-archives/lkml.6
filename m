Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeERSYZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbeERSYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:24:24 -0400
Date: Fri, 18 May 2018 15:24:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf tests: Fix regex for record+probe_libc_inet_pton.sh
Message-ID: <20180518182420.GA5001@kernel.org>
References: <20180518072417.1498-1-sandipan@linux.vnet.ibm.com>
 <be181700-57a5-e4c8-7cd4-88a88b7a51f1@linux.ibm.com>
 <764aa7ae-dcbe-6311-19fd-3d31b18f1645@linux.vnet.ibm.com>
 <c14a2313-28af-15ef-0989-2ab8544de51b@linux.ibm.com>
 <20180518141445.GB32141@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518141445.GB32141@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 18, 2018 at 11:14:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, May 18, 2018 at 01:09:48PM +0200, Thomas-Mich Richter escreveu:
> > On 05/18/2018 12:29 PM, Sandipan Das wrote:
> > > Can you please apply these two patches as well and then re-test?
> 
> > > [1] https://lkml.org/lkml/2018/5/17/112
> > > [2] https://lkml.org/lkml/2018/5/17/113
> 
> > Ahhh, yes that helped. Must have missed it. Thanks for the pointer.
> 
> Cool, can I take that as a Tested-by: Thomas?

Actually I'll fold this patch into the patch that made this test break,
so that we keep the tree bisectable wrt that specific 'perf test' entry.

- Arnaldo
