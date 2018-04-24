Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDXRQz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:16:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37408 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeDXRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:16:54 -0400
Date: Tue, 24 Apr 2018 13:16:50 -0400 (EDT)
Message-Id: <20180424.131650.2276839479783300009.davem@davemloft.net>
To: amsalam20@gmail.com
Cc: dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/2] ipv6: sr: add a per namespace sysctl to control
 seg6 flowlabel
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524519420-1612-1-git-send-email-amsalam20@gmail.com>
References: <1524519420-1612-1-git-send-email-amsalam20@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abdelsalam <amsalam20@gmail.com>
Date: Mon, 23 Apr 2018 23:36:59 +0200

> This patch adds a per namespace sysctl, named 'seg6_flowlabel', to be used
> by seg6_do_srh_encap() to control the behaviour of setting the flowlabel
> value of outer IPv6.
> 
> The currently support behaviours are as follows:
> -1 set flowlabel to zero.
>  0 copy flowlabel from Inner paceket in case of Inner IPv6 (0 for IPv4/L2)
>  1 Compute the flowlabel using seg6_make_flowlabel()
> 
> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>

There really isn't a reason to make this a separate patch.

Adding a sysctl that nothing refers to doesn't add much value.

So please combine patches #1 and #2.
