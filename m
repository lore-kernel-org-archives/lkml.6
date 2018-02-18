Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBRIze (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 03:55:34 -0500
Received: from ozlabs.org ([103.22.144.67]:46933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBRIzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 03:55:32 -0500
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c1e150ceb61e4a585bad156da15c33bfe89f5858
In-Reply-To: <1518610667-23406-1-git-send-email-clabbe@baylibre.com>
To: Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org,
        paulus@samba.org, nfont@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: powerpc: add empty update_numa_cpu_lookup_table for !CONFIG_NUMA
Message-Id: <3zkgh34GJZz9sWK@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 12:17:47 UTC, Corentin Labbe wrote:
> When CONFIG_NUMA is not set, build fail with:
> arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4: error: déclaration implicite de la fonction « update_numa_cpu_lookup_table » [-Werror=implicit-function-declaration]
> 
> So we have to add update_numa_cpu_lookup_table as an empty function when CONFIG_NUMA is not set.
> 
> Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c1e150ceb61e4a585bad156da15c33

cheers
