Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967594AbeBNLtl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:49:41 -0500
Received: from ozlabs.org ([103.22.144.67]:52069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967378AbeBNLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:49:40 -0500
Date: Wed, 14 Feb 2018 22:49:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        narmstrong@baylibre.com, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
Message-ID: <20180214224937.3f2feb80@canb.auug.org.au>
In-Reply-To: <20180214092558.5846-1-progyanb@acm.org>
References: <20180214092558.5846-1-progyanb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Progyan,

On Wed, 14 Feb 2018 14:55:58 +0530 Progyan Bhattacharya <bprogyan@gmail.com> wrote:
>
> Last two lines of code was repreated and was causing build error.
> 
> Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  scripts/Makefile.kasan | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index b7b9ecef44cc..69552a39951d 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -45,7 +45,3 @@ endif
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
>  
>  endif
> -
> -CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> -
> -endif
> -- 
> 2.16.1
> 

This file in linux-next and Linus' tree does not have the repeated
lines.  What tree did you see this in?

-- 
Cheers,
Stephen Rothwell
