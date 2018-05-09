Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965697AbeEIVz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:55:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35451 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965163AbeEIVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:55:58 -0400
Date: Wed, 9 May 2018 23:55:56 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH REPOST] rbtree: include rcu.h because we use it
Message-ID: <20180509215555.sihdfmijkx4nd6y2@linutronix.de>
References: <20180504103159.19938-1-bigeasy@linutronix.de>
 <20180508160437.aa262315a98eaa0d3631bb27@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508160437.aa262315a98eaa0d3631bb27@linux-foundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 16:04:37 [-0700], Andrew Morton wrote:
> On Fri,  4 May 2018 12:31:59 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Since commit c1adf20052d8 ("Introduce rb_replace_node_rcu()")
> > rbtree_augmented.h uses RCU related data structures but does not include
> > them. It works as long as gets somehow included before that and fails
> > otherwise.
> 
> c1adf20052d8 was two years ago.  Are there any actual real build errors
> arising from this?  If so, backporting the patch might be needed?
I've seen them only in -RT. No backporting needed.

Sebastian
