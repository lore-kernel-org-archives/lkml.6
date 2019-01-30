Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C2320882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfA3JVP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:21:15 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:40303 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfA3JVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:21:12 -0500
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9DDE3100015;
        Wed, 30 Jan 2019 09:21:09 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:21:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add the IRC channel to the MTD entry
Message-ID: <20190130102108.4fe9a58d@xps13>
In-Reply-To: <20190130085845.6790-1-bbrezillon@kernel.org>
References: <20190130085845.6790-1-bbrezillon@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <bbrezillon@kernel.org> wrote on Wed, 30 Jan 2019
09:58:45 +0100:

> The #mtd channel (on OFTC servers) is being used to discuss MTD related
> topics. Add it to the MTD entry.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..7b39ba46384a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9805,6 +9805,7 @@ M:	Richard Weinberger <richard@nod.at>
>  L:	linux-mtd@lists.infradead.org
>  W:	http://www.linux-mtd.infradead.org/
>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
> +C:	irc://irc.oftc.net/mtd
>  T:	git git://git.infradead.org/linux-mtd.git master
>  T:	git git://git.infradead.org/linux-mtd.git mtd/next
>  S:	Maintained

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
