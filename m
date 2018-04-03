Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeDCMlW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:41:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeDCMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:41:21 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180403154122.00d76d61@canb.auug.org.au>
References: <20180403154122.00d76d61@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29193.1522759279.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 13:41:19 +0100
Message-ID: <29194.1522759279@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> +	wait_var_event(&rxnet->nr_calls, !atomic_read(&rxnet->nr_calls));

I would prefer == 0 to ! as it's not really a true/false value.

But apart from that, it's looks okay and you can add my Reviewed-by.

David
