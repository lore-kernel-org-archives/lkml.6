Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B132CC636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5A20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfATPGL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:06:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57208 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfATPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:06:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 54D372074A; Sun, 20 Jan 2019 16:06:08 +0100 (CET)
Received: from xps13 (unknown [77.136.42.183])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1A0C20654;
        Sun, 20 Jan 2019 16:06:06 +0100 (CET)
Date:   Sun, 20 Jan 2019 16:06:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller
 driver
Message-ID: <20190120160605.33689354@xps13>
In-Reply-To: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sun, 20 Jan 2019
01:02:35 +0800:

> Add entry for Amlogic NAND controller driver and its bindings[0].
> 
> [0] https://lore.kernel.org/lkml/1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com/
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>

If you are the author of the patch your Signed-off-by should come first.

Also, why is Liang the Maintainer? Why not you?

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0abecc5..7d976a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9628,6 +9628,13 @@ F:	drivers/media/platform/meson/ao-cec.c
>  F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
>  T:	git git://linuxtv.org/media_tree.git
>  
> +MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
> +M:	Liang Yang <liang.yang@amlogic.com>
> +L:	linux-mtd@lists.infradead.org
> +S:	Maintained
> +F:	drivers/mtd/nand/raw/meson_*
> +F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +
>  MICROBLAZE ARCHITECTURE
>  M:	Michal Simek <monstr@monstr.eu>
>  W:	http://www.monstr.eu/fdt/

Thanks,
Miquèl
