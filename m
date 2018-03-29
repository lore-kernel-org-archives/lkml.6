Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeC2WZt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:25:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbeC2WZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:25:48 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180329.115956.476747368912393740.davem@davemloft.net>
References: <20180329.115956.476747368912393740.davem@davemloft.net> <152219064515.24098.9428175357244257284.stgit@warthog.procyon.org.uk>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] rxrpc: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30570.1522362346.1@warthog.procyon.org.uk>
Date: Thu, 29 Mar 2018 23:25:46 +0100
Message-ID: <30571.1522362346@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> David, this GIT URL has tons of unrelated changes.  It seems to bring in
> the parts of Linus's tree that haven't proagated to 'net' yet.

Sorry about that, I rebased on the wrong branch by accident.

I've got some more fixes.  Should I just give the lot to you to pull into your
net-next tree, given that the merge window may well open Sunday?

David
