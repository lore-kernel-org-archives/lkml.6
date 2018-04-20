Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeDTJtt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:49:49 -0400
Received: from foss.arm.com ([217.140.101.70]:47226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754255AbeDTJts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:49:48 -0400
Date: Fri, 20 Apr 2018 10:49:44 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Stefan Agner <stefan@agner.ch>
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        torvalds@linux-foundation.org, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: use PHYS_ADDR_MAX to avoid type casting
 ULLONG_MAX
Message-ID: <20180420094943.25erqjuco7ern2sy@armageddon.cambridge.arm.com>
References: <20180419214204.19322-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419214204.19322-1-stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:42:04PM +0200, Stefan Agner wrote:
> With PHYS_ADDR_MAX there is now a type safe variant for all
> bits set. Make use of it.
> 
> Patch created using a sematic patch as follows:
> 
> // <smpl>
> @@
> typedef phys_addr_t;
> @@
> -(phys_addr_t)ULLONG_MAX
> +PHYS_ADDR_MAX
> // </smpl>
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm64/mm/init.c               | 6 +++---

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
