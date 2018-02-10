Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBJVUb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:20:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:49311 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752529AbeBJVU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:20:29 -0500
Date: Sat, 10 Feb 2018 22:20:06 +0100
From: Borislav Petkov <bp@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: trim clear_page.S includes
Message-ID: <20180210212006.GB21424@pd.tnic>
References: <20180113190648.GB23111@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113190648.GB23111@avx2>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2018 at 10:06:48PM +0300, Alexey Dobriyan wrote:
> After alternatives were shifted to the call site, only 2 headers are
> necessary.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/x86/lib/clear_page_64.S |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -1,6 +1,4 @@
>  #include <linux/linkage.h>
> -#include <asm/cpufeatures.h>
> -#include <asm/alternative-asm.h>
>  #include <asm/export.h>
>  
>  /*

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
