Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030241AbeEYUhC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:37:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37544 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968220AbeEYUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:37:01 -0400
Date: Fri, 25 May 2018 16:37:00 -0400 (EDT)
Message-Id: <20180525.163700.2205201673384613648.davem@davemloft.net>
To: chenbo@pdx.edu
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too: Remove unnecessary netif_napi_del()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180524194835.14700-1-chenbo@pdx.edu>
References: <20180524194835.14700-1-chenbo@pdx.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>
Date: Thu, 24 May 2018 12:48:35 -0700

> The call to free_netdev() in __rtl8139_cleanup_dev() clears the network device
> napi list, and explicit calls to netif_napi_del() are unnecessary.
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

Since this is just unnecessary work and not a bug, applied to net-next.

Thanks.
