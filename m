Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeC0Hzl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:55:41 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:40213 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeC0Hzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:55:39 -0400
X-Google-Smtp-Source: AG47ELsjPLlzm9jbZnYNWbXB9y4JveZwA53RI3Rg/pHd01vrdWUDtRcc+aT2iaIfjJIF+Z/SdLFUIg==
Date: Tue, 27 Mar 2018 15:55:22 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: linux-next: manual merge of the imx-mxs tree with the arm-soc
 tree
Message-ID: <20180327075520.GA3245@dragon>
References: <20180327091026.3facbb9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327091026.3facbb9d@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 09:10:26AM +1100, Stephen Rothwell wrote:
> Hi Shawn,
> 
> Today's linux-next merge of the imx-mxs tree got a conflict in:
> 
>   arch/arm/configs/mxs_defconfig
> 
> between commit:
> 
>   e3e583e7a293 ("ARM: mxs_defconfig: Re-sync defconfig")
> 
> from the arm-soc tree and commit:
> 
>   8bc2c29b550c ("ARM: mxs_defconfig: Re-sync defconfig")
> 
> from the imx-mxs tree.
> 
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, Stephen.  We will sort this out on arm-soc tree.

Arnd,

You pulled "[GIT PULL 6/6] i.MX defconfig updates for 4.17" [1]?
I thought you did not pull it, and updated it with v2 to address your
comment.  Let me know which one you want to send upstream.  Thanks.

Shawn

[1] https://patchwork.ozlabs.org/patch/886191/
