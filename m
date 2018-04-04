Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeDDPGb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:06:31 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeDDPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:06:29 -0400
Date: Wed, 04 Apr 2018 11:06:23 -0400 (EDT)
Message-Id: <20180404.110623.1227186154122913076.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Fix undefined packet handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <152270949946.20618.15535005483715424318.stgit@warthog.procyon.org.uk>
References: <152270949946.20618.15535005483715424318.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Apr 2018 23:51:39 +0100

> By analogy with other Rx implementations, RxRPC packet types 9, 10 and 11
> should just be discarded rather than being aborted like other undefined
> packet types.
> 
> Reported-by: Jeffrey Altman <jaltman@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thank you.
