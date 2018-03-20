Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeCTKPp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:15:45 -0400
Received: from ozlabs.org ([103.22.144.67]:40099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752269AbeCTKPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:15:32 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 78e5dfea84dc15d69940831b3981b3014d17222e
In-Reply-To: <20180228224406.7049-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
Message-Id: <40582V6byxz9sZ5@ozlabs.org>
Date: Tue, 20 Mar 2018 21:15:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 22:44:06 UTC, Rob Herring wrote:
> 'linux,stdout-path' has been deprecated for some time in favor of
> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
> Search and replace all the of occurrences with 'stdout-path'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78e5dfea84dc15d69940831b3981b3

cheers
