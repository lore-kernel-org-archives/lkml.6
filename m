Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935459AbeBMOmN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:42:13 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:39950 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935370AbeBMOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:42:11 -0500
X-Google-Smtp-Source: AH8x227YQa+IPl4oeO3BkVN2XKBXzEHi4/CFiyjS0upZU6aK9Po7L246jpmMsFQyrbqapmo+a51fZg==
Date: Tue, 13 Feb 2018 06:42:07 -0800
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@rvc.renesas.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: linux-next: build warning after merge of the libata tree
Message-ID: <20180213144207.GO695913@devbig577.frc2.facebook.com>
References: <20180213140449.35e337cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213140449.35e337cb@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:04:49PM +1100, Stephen Rothwell wrote:
> Hi Tejun,
> 
> After merging the libata tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> drivers/ata/sata_rcar.c: In function 'sata_rcar_init_controller':
> drivers/ata/sata_rcar.c:821:16: warning: unused variable 'base' [-Wunused-variable]
>   void __iomem *base = priv->base;
>                 ^~~~
> 
> Introduced by commit
> 
>   da77d76b95a0 ("sata_rcar: Reset SATA PHY when Salvator-X board resumes")

Just applied Geert's patch to remove the warning.

Thanks.

-- 
tejun
