Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeEQUAF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbeEQUAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:00:00 -0400
Date: Thu, 17 May 2018 16:59:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] perf script: Show virtual addresses instead of
 offsets
Message-ID: <20180517195957.GD18538@kernel.org>
References: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 17, 2018 at 12:03:25PM +0530, Sandipan Das escreveu:
> When perf data is recorded with the call-graph option enabled,
> the callchain shown by perf script shows the binary offsets of
> the symbols as the ip. This is incorrect for kernel symbols as
> the ip values are always off by a fixed offset depending on the
> architecture. If the offsets from the start of the symbols are
> printed, they are also incorrect for both kernel and userspace
> symbols.
> 
> Without the call-graph option, the callchain shows the virtual
> addresses of the symbols rather than their binary offsets. The
> offsets printed in this case are also correct.
> 
> This fixes the inconsistency in perf script's output.

Thanks, tested and applied,

- Arnaldo
