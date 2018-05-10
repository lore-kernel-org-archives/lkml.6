Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEJVoN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:44:13 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37728 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeEJVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:44:12 -0400
Date: Thu, 10 May 2018 17:44:09 -0400 (EDT)
Message-Id: <20180510.174409.1976187532131291998.davem@davemloft.net>
To: joe@perches.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, lirongqing@baidu.com,
        acme@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: remove define INET_CSK_DEBUG and
 unnecessary EXPORT_SYMBOL
From: David Miller <davem@davemloft.net>
In-Reply-To: <0424e034b4640359bbe1ae50229b9fbc25b06181.1525932412.git.joe@perches.com>
References: <0424e034b4640359bbe1ae50229b9fbc25b06181.1525932412.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Wed,  9 May 2018 23:24:07 -0700

> INET_CSK_DEBUG is always set and only is used for 2 pr_debug calls.
> 
> EXPORT_SYMBOL(inet_csk_timer_bug_msg) is only used by these 2
> pr_debug calls and is also unnecessary as the exported string can
> be used directly by these calls.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to net-next.
