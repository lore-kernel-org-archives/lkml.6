Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeBAWzp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:55:45 -0500
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:57241 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752027AbeBAWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:55:37 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3867:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:9025:9388:10004:10049:10400:10848:11232:11257:11658:11914:12043:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: fact55_6b2154ec42d05
X-Filterd-Recvd-Size: 1575
Message-ID: <1517525734.7489.83.camel@perches.com>
Subject: Re: [PATCH] proc: condemn myself to MAINTAINERS
From: Joe Perches <joe@perches.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2018 14:55:34 -0800
In-Reply-To: <20180201224508.GA12914@avx2>
References: <20180201224508.GA12914@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 01:45 +0300, Alexey Dobriyan wrote:
> I'll regret it.

probably.

Does this mean you want to track change to proc
uses as well?

If so, maybe add an N: entry like

N:	\b(?:remove_)?proc_(?:\w+_?){1,3}\s*\(

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  MAINTAINERS |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11045,6 +11045,14 @@ W:	http://wireless.kernel.org/en/users/Drivers/p54
>  S:	Obsolete
>  F:	drivers/net/wireless/intersil/prism54/
>  
> +PROC FILESYSTEM
> +R:	Alexey Dobriyan <adobriyan@gmail.com>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Maintained
> +F:	fs/proc/*
> +F:	include/linux/proc_fs.h
> +
>  PROC SYSCTL
>  M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
>  M:	Kees Cook <keescook@chromium.org>
