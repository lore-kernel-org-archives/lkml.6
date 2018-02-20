Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeBTSCC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:02:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47554 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBTSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:02:01 -0500
Date: Tue, 20 Feb 2018 13:01:57 -0500 (EST)
Message-Id: <20180220.130157.1101637718168743475.davem@davemloft.net>
To: santosh.shilimkar@oracle.com
Cc: gustavo@embeddedor.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
From: David Miller <davem@davemloft.net>
In-Reply-To: <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
References: <20180219181020.GA19154@embeddedgus>
        <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Date: Tue, 20 Feb 2018 09:54:09 -0800

> So coverity greps for commet as "fall through" for
> -Wimplicit-fallthrough build ?

>From what I understand, 'gcc' does in the latest versions.  Coverity
might as well, I don't know.
