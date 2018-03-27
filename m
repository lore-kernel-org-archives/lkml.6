Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeC0Oy4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:54:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0Oyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:54:55 -0400
Date: Tue, 27 Mar 2018 10:54:53 -0400 (EDT)
Message-Id: <20180327.105453.250045484228569543.davem@davemloft.net>
To: joe@perches.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: addrconf: Use normal debugging style
From: David Miller <davem@davemloft.net>
In-Reply-To: <40e88b53c25ddb95d36bb7a061806f2f95f5ccf2.1522078288.git.joe@perches.com>
References: <40e88b53c25ddb95d36bb7a061806f2f95f5ccf2.1522078288.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 26 Mar 2018 08:35:01 -0700

> Remove local ADBG macro and use netdev_dbg/pr_debug
> 
> Miscellanea:
> 
> o Remove unnecessary debug message after allocation failure as there
>   already is a dump_stack() on the failure paths
> o Leave the allocation failure message on snmp6_alloc_dev as there
>   is one code path that does not do a dump_stack()
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Remerged resend of http://patchwork.ozlabs.org/patch/826028/
> back in October 2017

Applied to net-next, thanks Joe.
