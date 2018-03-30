Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeC3Bs1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:48:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeC3Bs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:48:26 -0400
Date: Thu, 29 Mar 2018 21:48:22 -0400 (EDT)
Message-Id: <20180329.214822.1871100263972510651.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] rxrpc: Fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <30571.1522362346@warthog.procyon.org.uk>
References: <20180329.115956.476747368912393740.davem@davemloft.net>
        <152219064515.24098.9428175357244257284.stgit@warthog.procyon.org.uk>
        <30571.1522362346@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 29 Mar 2018 23:25:46 +0100

> David Miller <davem@davemloft.net> wrote:
> 
>> David, this GIT URL has tons of unrelated changes.  It seems to bring in
>> the parts of Linus's tree that haven't proagated to 'net' yet.
> 
> Sorry about that, I rebased on the wrong branch by accident.
> 
> I've got some more fixes.  Should I just give the lot to you to pull into your
> net-next tree, given that the merge window may well open Sunday?

That's up to you.
