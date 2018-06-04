Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeFDJPP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:15:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeFDJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:15:14 -0400
Date: Mon, 4 Jun 2018 11:15:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spectre mitigation doesn't seem to work at all?!
Message-ID: <20180604091509.GP12217@hirez.programming.kicks-ass.net>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
 <20180604081502.GE12258@hirez.programming.kicks-ass.net>
 <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:50:07AM +0200, Andreas Hartmann wrote:

> Ok, this means every program running on the machine has to care itself
> to be spectre v1 - safe.

Correct. Compiler and static analyser teams are looking hard at this to
help.

> A malicious program most probably won't care about that. Therefore, my
> next question is: which memory regions can be exploited by a malicious
> program? The complete physical memory or only the memory provided to the
> malicious program? Should be the latter if this approach should have any
> impact.

It affects the virtual memory of the target process.
