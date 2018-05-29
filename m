Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966446AbeE2TUt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:20:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60200 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966061AbeE2TUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:20:47 -0400
Date: Tue, 29 May 2018 15:20:42 -0400 (EDT)
Message-Id: <20180529.152042.1409181673423984189.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: ast@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bpfilter: fix a build err
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525101757.13756-1-yuehaibing@huawei.com>
References: <20180525101757.13756-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 25 May 2018 18:17:57 +0800

> gcc-7.3.0 report following err:
> 
>   HOSTCC  net/bpfilter/main.o
> In file included from net/bpfilter/main.c:9:0:
> ./include/uapi/linux/bpf.h:12:10: fatal error: linux/bpf_common.h: No such file or directory
>  #include <linux/bpf_common.h>
> 
> remove it by adding a include path.
> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
