Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032831AbeBONnk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031445AbeBONnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:43:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A160C217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 10:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 0/3] perf trace powerpc: Remove libaudit dependency for
 syscalls
Message-ID: <20180215134336.GD22818@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2018 at 02:04:14PM +0530, Ravi Bangoria escreveu:
> This is almost identical set of patches recently done for s390.
> 
> With this, user can run perf trace without libaudit on powerpc
> as well. Ex,
> 
>   $ make
>     ...     libaudit: [ OFF ]
> 
>   $ ./perf trace ls

Thanks, applied.

- Arnaldo
