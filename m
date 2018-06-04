Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbeFDOSt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:18:49 -0400
Received: from ozlabs.org ([203.11.71.1]:53751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753163AbeFDOKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:32 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 92c8c16f345759e87c5d5b771d438ff18ec7593f
In-Reply-To: <20180406011720.7728-2-mgreer@animalcreek.com>
To: Mark Greer <mgreer@animalcreek.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Remi Machet <rmachet@nvidia.com>,
        Dale Farnsworth <dale@farnsworth.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>
Subject: Re: [1/5] powerpc/embedded6xx: Remove C2K board support
Message-Id: <40zxfb5H0xz9s2S@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-06 at 01:17:16 UTC, Mark Greer wrote:
> The C2K platform appears to be orphaned so remove code supporting it.
> 
> CC: Remi Machet <rmachet@nvidia.com>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> Acked-by: Remi Machet <remi@machet.us>
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/92c8c16f345759e87c5d5b771d438f

cheers
