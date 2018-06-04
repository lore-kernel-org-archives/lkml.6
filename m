Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeFDOOY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:14:24 -0400
Received: from ozlabs.org ([203.11.71.1]:34767 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753698AbeFDOLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:03 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e6684d07e4308430b9b6497265781a6fb9fd87a0
In-Reply-To: <20180521042108.8318-2-ravi.bangoria@linux.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sandipan@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, matthew.brown.dev@gmail.com,
        paulus@samba.org, anton@samba.org, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Subject: Re: [1/3] powerpc/sstep: Introduce GETTYPE macro
Message-Id: <40zxg85MWNz9s5c@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-21 at 04:21:06 UTC, Ravi Bangoria wrote:
> Replace 'op->type & INSTR_TYPE_MASK' expression with GETTYPE(op->type)
> macro.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e6684d07e4308430b9b6497265781a

cheers
