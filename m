Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032561AbeCSWXU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:23:20 -0400
Received: from ozlabs.org ([103.22.144.67]:44399 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032545AbeCSWXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:23:03 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d79a02b3e03b103d84536fb19ae7a73828dba856
In-Reply-To: <20180228224406.7049-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
Message-Id: <404rDN5nYRz9sBv@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:59 +1100 (AEDT)
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

https://git.kernel.org/powerpc/c/d79a02b3e03b103d84536fb19ae7a7

cheers
