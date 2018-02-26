Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeBZPh1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:37:27 -0500
Received: from foss.arm.com ([217.140.101.70]:51872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBZPhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:37:25 -0500
Date: Mon, 26 Feb 2018 15:37:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 06/12] arm64: fpsimd: include <linux/init.h> in
 fpsimd.h
Message-ID: <20180226153720.knpw7a4fncixdb4a@salmiak>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-7-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519657500-15094-7-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:04:54PM +0000, Will Deacon wrote:
> fpsimd.h uses the __init annotation, so pull in linux/init.h
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Having skimmed through, this looks like all we need.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/fpsimd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 8857a0f0d0f7..fc3527b985ca 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -22,6 +22,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/cache.h>
> +#include <linux/init.h>
>  #include <linux/stddef.h>
>  
>  /*
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
