Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeFAPzA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:55:00 -0400
Received: from ozlabs.org ([203.11.71.1]:36863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752669AbeFAPy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:54:57 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ac9816dcbab53c57bcf1d7b15370b08f1e284318
In-Reply-To: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, npiggin@gmail.com,
        ego@linux.vnet.ibm.com
Subject: Re: cpuidle/powernv : init all present cpus for deep states
Message-Id: <40y86R6lD6z9s1w@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:55 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 12:02:14 UTC, Akshay Adiga wrote:
> Init all present cpus for deep states instead of "all possible" cpus.
> Init fails if the possible cpu is gaurded. Resulting in making only
> non-deep states available for cpuidle/hotplug.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ac9816dcbab53c57bcf1d7b15370b0

cheers
