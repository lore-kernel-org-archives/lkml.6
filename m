Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966649AbeEYLln (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:43 -0400
Received: from ozlabs.org ([203.11.71.1]:53703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966618AbeEYLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:40 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 85aa4b98419d74dd5cc914e089349800ac4997ee
In-Reply-To: <20180423193638.10535-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/mm/radix: use do/while(0) trick for single statement block
Message-Id: <40skqR2pvmz9s4V@ozlabs.org>
Date: Fri, 25 May 2018 21:41:39 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-23 at 19:36:38 UTC, Mathieu Malaterre wrote:
> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
> disable_radix") an `if` statement was added for a possible empty body
> (prom_debug).
> 
> Fix the following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/85aa4b98419d74dd5cc914e0893498

cheers
