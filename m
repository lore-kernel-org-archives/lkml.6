Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeCLOLp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbeCLOLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:11:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C493208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 11:11:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf top: Fix top.call-graph works abnormal
Message-ID: <20180312141140.GD4882@kernel.org>
References: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 07:25:56PM +0800, Yisheng Xie escreveu:
> When try to add call-graph for top into .perfconfig file, like:
> 
>       [top]
>             call-graph = fp
> 
> find it cannot work for perf_top_config() do not parse this option.

Thanks, applied.

- Arnaldo
