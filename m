Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966778AbeEYLn5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:43:57 -0400
Received: from ozlabs.org ([203.11.71.1]:59269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966622AbeEYLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:42 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eed6964bce59294f293b1746a6e4a69fa709fa5b
In-Reply-To: <20180423194533.23487-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc/wii: Make hlwd_pic_init function static
Message-Id: <40skqS4tPKz9s4r@ozlabs.org>
Date: Fri, 25 May 2018 21:41:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-23 at 19:45:32 UTC, Mathieu Malaterre wrote:
> The function hlwd_pic_init can be made static, so do it. Fix the following
> warning treated as error (W=1):
> 
> ../arch/powerpc/platforms/embedded6xx/hlwd-pic.c:158:20: error: no previous prototype for ‘hlwd_pic_init’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eed6964bce59294f293b1746a6e4a6

cheers
