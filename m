Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934858AbeCEMgS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:36:18 -0500
Received: from ozlabs.org ([103.22.144.67]:34623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934793AbeCEMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:36:11 -0500
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 64c3f648c25d108f346fdc96c15180c6b7d250e9
In-Reply-To: <1519419359-19163-1-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: powerpc/boot: Fix random build errors
Message-Id: <3zvzsk1Px8z9sZf@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:09 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 20:55:59 UTC, Guenter Roeck wrote:
> Once in a while I see build errors similar to the following
> when building images from a clean tree.
> 
> Building powerpc:virtex-ml507:44x/virtex5_defconfig ... failed
> ------------
> Error log:
> arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
> 	libfdt.h: No such file or directory
> 
> Building powerpc:bamboo:smpdev:44x/bamboo_defconfig ... failed
> ------------
> Error log:
> arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
> 	libfdt.h: No such file or directory
> 
> arch/powerpc/boot/treeboot-currituck.c:35:20: fatal error:
>      libfdt.h: No such file or directory
> 
> Rebuilds will succeed.
> 
> Turns out that several source files in arch/powerpc/boot/ include
> libfdt.h, but Makefile dependencies are incomplete. Let's fix that.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/64c3f648c25d108f346fdc96c15180

cheers
