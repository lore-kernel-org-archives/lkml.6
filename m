Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeBMDEw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:04:52 -0500
Received: from ozlabs.org ([103.22.144.67]:51557 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933254AbeBMDEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:04:51 -0500
Date: Tue, 13 Feb 2018 14:04:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@rvc.renesas.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: linux-next: build warning after merge of the libata tree
Message-ID: <20180213140449.35e337cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

After merging the libata tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/ata/sata_rcar.c: In function 'sata_rcar_init_controller':
drivers/ata/sata_rcar.c:821:16: warning: unused variable 'base' [-Wunused-variable]
  void __iomem *base = priv->base;
                ^~~~

Introduced by commit

  da77d76b95a0 ("sata_rcar: Reset SATA PHY when Salvator-X board resumes")

-- 
Cheers,
Stephen Rothwell
