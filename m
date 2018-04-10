Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDJOdb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:33:31 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:36013 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753149AbeDJOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:33:28 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2561:2566:2682:2685:2692:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:7974:9010:9025:9040:10004:10400:10848:11232:11657:11658:11914:12043:12555:12681:12740:12760:12895:13071:13158:13228:13439:14096:14097:14180:14181:14659:14721:14818:21060:21080:21325:21433:21451:21627:21740:30019:30034:30054:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: hands07_756450818fa49
X-Filterd-Recvd-Size: 3146
Message-ID: <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host
 drivers
From: Joe Perches <joe@perches.com>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 07:33:25 -0700
In-Reply-To: <20180410141125.4477-1-wsa@the-dreams.de>
References: <20180410141125.4477-1-wsa@the-dreams.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 16:11 +0200, Wolfram Sang wrote:
> The number of I2C host controller drivers keeps increasing, and although
> I had some success acquiring specific driver maintainers, my bandwidth
> is by far not enough to act as a fallback for the rest of the drivers.
> To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
> host drivers, let the I2C list (= community) be the contact point, and
> mark this section as "Odd fixes".
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Joe: my tests worked fine with the file patterns; yet I'd appreciate if you
> had time to double check them. Thanks!

Hi Wolfram.

As far as I understand, all this seems correct to me.

You want to maintain the core files in drivers/i2c/
but not any files in any of algos/, busses/, or muxes/.

You might also want to specify which of the
include/linux/i2c-*.h files you actually want to oversee
as well.  It seems some are driver specific.

But the git entry for the drivers seems maybe a bit of
an issue.  Are you
intending to somehow pick up patches
approved by the i2c community?  If
not, no worries I
guess, someone might come along to provide help.

cheers, Joe

>  MAINTAINERS | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d296bdce328..2f7ccdcf76f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6580,15 +6580,23 @@ W:	https://i2c.wiki.kernel.org/
>  Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/i2c/
> +F:	Documentation/devicetree/bindings/i2c/i2c.txt
>  F:	Documentation/i2c/
> -F:	drivers/i2c/
> -F:	drivers/i2c/*/
> +F:	drivers/i2c/*
>  F:	include/linux/i2c.h
>  F:	include/linux/i2c-*.h
>  F:	include/uapi/linux/i2c.h
>  F:	include/uapi/linux/i2c-*.h
>  
> +I2C SUBSYSTEM DRIVERS
> +L:	linux-i2c@vger.kernel.org
> +W:	https://i2c.wiki.kernel.org/
> +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/i2c/
> +F:	drivers/i2c/*/
> +
>  I2C-TAOS-EVM DRIVER
>  M:	Jean Delvare <jdelvare@suse.com>
>  L:	linux-i2c@vger.kernel.org
