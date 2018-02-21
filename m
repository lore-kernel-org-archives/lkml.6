Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeBUTSl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:18:41 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:34016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeBUTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:18:40 -0500
Date: Wed, 21 Feb 2018 14:18:38 -0500 (EST)
Message-Id: <20180221.141838.385638704106855180.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180219181020.GA19154@embeddedgus>
References: <20180219181020.GA19154@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 19 Feb 2018 12:10:20 -0600

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1465362 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
