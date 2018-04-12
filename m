Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDLRUv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeDLRUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:20:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8955121785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 12 Apr 2018 14:20:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com
Subject: Re: [PATCH] perf tests: Disable breakpoint accounting test for
 powerpc
Message-ID: <20180412172047.GE9818@kernel.org>
References: <20180412162140.2992-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412162140.2992-1-sandipan@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 12, 2018 at 09:51:40PM +0530, Sandipan Das escreveu:
> We disable this test as instruction breakpoints (HW_BREAKPOINT_X)
> are not available for powerpc.

Thanks, applied.

- Arnaldo
