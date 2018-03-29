Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeC2QC3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:02:29 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC2QC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:02:27 -0400
Date: Thu, 29 Mar 2018 12:02:26 -0400 (EDT)
Message-Id: <20180329.120226.667773214188824967.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] rxrpc: Tracing updates
From: David Miller <davem@davemloft.net>
In-Reply-To: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
References: <152219147024.24730.12727053395895392426.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 27 Mar 2018 23:57:50 +0100

> Here are some patches that update tracing in AF_RXRPC and AFS:
> 
>  (1) Add a tracepoint for tracking resend events.
> 
>  (2) Use debug_ids in traces rather than pointers (as pointers are now hashed)
>      and allow use of the same debug_id in AFS calls as in the corresponding
>      AF_RXRPC calls.  This makes filtering the trace output much easier.
> 
>  (3) Add a tracepoint for tracking call completion.
> 
> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	rxrpc-next-20180327

Pulled, thank you.
