Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeBHSsw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:48:52 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeBHSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:48:49 -0500
Date: Thu, 08 Feb 2018 13:48:47 -0500 (EST)
Message-Id: <20180208.134847.2294397519191048232.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Don't put crypto buffers on the stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <151810554726.19320.4571236293389358221.stgit@warthog.procyon.org.uk>
References: <151810554726.19320.4571236293389358221.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Feb 2018 15:59:07 +0000

> Don't put buffers of data to be handed to crypto on the stack as this may
> cause an assertion failure in the kernel (see below).  Fix this by using an
> kmalloc'd buffer instead.
 ...
> Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Jonathan Billings <jsbillings@jsbillings.org>

Applied, thanks David.
