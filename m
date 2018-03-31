Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeCaOEC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:04:02 -0400
Received: from ozlabs.org ([103.22.144.67]:56333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753042AbeCaOEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:04:01 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 041413b88d6e9c66582d0a38d0e82f8933d42d9a
In-Reply-To: <20180317150617.26913-1-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: wii.dts: Add drive slot LED
Message-Id: <40D0b40XzBz9s1S@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:59 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-17 at 15:06:17 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Wii has a blue LED in the disk drive slot, which is controlled via a
> GPIO line. Add this LED to wii.dts, and mark it as a panic-indicator.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/041413b88d6e9c66582d0a38d0e82f

cheers
