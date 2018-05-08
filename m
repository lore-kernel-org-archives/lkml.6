Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbeEHXEj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:04:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeEHXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:04:38 -0400
Date: Tue, 8 May 2018 16:04:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH REPOST] rbtree: include rcu.h because we use it
Message-Id: <20180508160437.aa262315a98eaa0d3631bb27@linux-foundation.org>
In-Reply-To: <20180504103159.19938-1-bigeasy@linutronix.de>
References: <20180504103159.19938-1-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 May 2018 12:31:59 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Since commit c1adf20052d8 ("Introduce rb_replace_node_rcu()")
> rbtree_augmented.h uses RCU related data structures but does not include
> them. It works as long as gets somehow included before that and fails
> otherwise.

c1adf20052d8 was two years ago.  Are there any actual real build errors
arising from this?  If so, backporting the patch might be needed?
