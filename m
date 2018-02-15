Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032916AbeBON4U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032283AbeBON4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:56:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B07C2175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 10:56:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 0/3] perf trace powerpc: Remove libaudit dependency for
 syscalls
Message-ID: <20180215135616.GE22818@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180215134336.GD22818@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215134336.GD22818@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 15, 2018 at 10:43:36AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 29, 2018 at 02:04:14PM +0530, Ravi Bangoria escreveu:
> > This is almost identical set of patches recently done for s390.
> > 
> > With this, user can run perf trace without libaudit on powerpc
> > as well. Ex,
> > 
> >   $ make
> >     ...     libaudit: [ OFF ]
> > 
> >   $ ./perf trace ls
> 
> Thanks, applied.

Ah, I already had to update the unistd.h copy to catch some new syscalls
for s/390 :-)

https://git.kernel.org/acme/c/b4ec64dc68da

- Arnaldo
