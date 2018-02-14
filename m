Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966992AbeBNJpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:45:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966503AbeBNJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:45:03 -0500
Date: Wed, 14 Feb 2018 10:44:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: mingo@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] Update lockdep doc and add section about annotations
Message-ID: <20180214094459.GX25181@hirez.programming.kicks-ass.net>
References: <20180213185519.18186-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213185519.18186-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 07:55:17PM +0100, Juri Lelli wrote:
> Hi,
> 
> a couple of patches to lockdep docs.
> 
> First one is a small fix for that fact that Peter made documentation
> stale (as usual :P).
> 
> Second one is an RFC. I thought that adding some info about lockdep
> asserts might help spread adoption even wider (mostly regarding
> lockdep_pin_lock stuff, which is pretty new and maybe got unnoticed
> outside of the scheduler?).

Thanks for writing that Juri!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
