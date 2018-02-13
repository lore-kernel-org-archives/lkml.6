Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbeBMNpj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:45:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964792AbeBMNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:45:38 -0500
Date: Tue, 13 Feb 2018 14:45:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH 0/2] A couple of qspinlock fixes
Message-ID: <20180213134533.GK25201@hirez.programming.kicks-ass.net>
References: <1518528177-19169-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518528177-19169-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:22:55PM +0000, Will Deacon wrote:
> Hi all,
> 
> Here are a couple of fixes for qspinlock issues I've found by code
> inspection whilst investigating the possibility of enabling this for
> arm64. The first patch fixes a problem with unusual hardware re-ordering
> whilst the second fixes a problem with unusual compiler re-ordering.

Thanks Will!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
