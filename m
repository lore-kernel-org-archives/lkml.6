Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCZOU7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeCZOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:20:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEDC20C48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 26 Mar 2018 11:20:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf check-headers.sh: Fix check-headers.sh opts
 assignment
Message-ID: <20180326142043.GC18897@kernel.org>
References: <20180321140515.2252-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321140515.2252-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 21, 2018 at 03:05:15PM +0100, Jiri Olsa escreveu:
> Currently opts variable is not zero-ed and we keep
> on adding to it, ending up with:
> 
>   $ check-headers.sh 2>&1
>   + opts=' "-B"'
>   + opts=' "-B" "-B"'
>   + opts=' "-B" "-B" "-B"'
>   + opts=' "-B" "-B" "-B" "-B"'
>   + opts=' "-B" "-B" "-B" "-B" "-B"'
>   + opts=' "-B" "-B" "-B" "-B" "-B" "-B"'

Thanks, tested and applied.

- Arnaldo
