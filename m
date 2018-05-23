Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeEWHth (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:49:37 -0400
Received: from mail.us.es ([193.147.175.20]:54438 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754455AbeEWHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:49:12 -0400
Date: Wed, 23 May 2018 09:49:08 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] netfilter: uapi: includes linux/types.h
Message-ID: <20180523074907.rw5n2qyapc5m5jdk@salvia>
References: <20180523070326.15968-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523070326.15968-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 03:03:26PM +0800, YueHaibing wrote:
> gcc-7.3.0 report following warning:
> ./usr/include/linux/netfilter/nf_osf.h:27: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> includes linux/types.h to fix it.

Thanks.

There's already a fix for this in the nf-next queue.

commit 01cd267bff52619a53fa05c930ea5ed53493d21a
Author: Florian Westphal <fw@strlen.de>
Date:   Tue May 8 10:05:38 2018 +0200

    netfilter: fix fallout from xt/nf osf separation
