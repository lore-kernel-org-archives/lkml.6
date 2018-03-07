Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934289AbeCGU4R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:56:17 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:57194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGU4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:56:15 -0500
Date: Wed, 07 Mar 2018 15:56:14 -0500 (EST)
Message-Id: <20180307.155614.873104283081437904.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH v2] cxgb3: remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180307180333.GA13800@embeddedgus>
References: <20180307180333.GA13800@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 7 Mar 2018 12:03:33 -0600

> Remove VLA usage and change the 'len' argument to a u8 and use a 256
> byte buffer on the stack. Notice that these lengths are limited by the
> encoding field in the VPD structure, which is a u8 [1].
> 
> [1] https://marc.info/?l=linux-netdev&m=152044354814024&w=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Update the code as suggested by David Miller.
>  - Update changelog based on David's comments.
>  - Update subject.

Applied to net-next, thanks.
