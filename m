Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A84BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C412088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1N2YxDsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C412088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJHOkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:40:55 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B972087C;
        Mon,  8 Oct 2018 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538983835;
        bh=N76RzP5uj7XQ5yPZxLEOPRlnNr0jzp49JHrqka7w90Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1N2YxDsTYvaH3clmmraCAalBvqr3d0BSUf1zjpyArUX0NRjnEmYG3TU3EYpqF5CpP
         rRLCkR52ev0XYc0OJKPhAaaYZNbDwNAIPYskyl5l9It9BhUcA164cXD4GDRXx5e6MQ
         ltfZ9OF77sPj05pG2L2HmcpcXmR2SwmbwLDm6yOk=
Date:   Mon, 8 Oct 2018 15:30:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Message-ID: <20181008073010.GO3587@dragon>
References: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538918657-2032-1-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 09:24:17PM +0800, Dong Aisheng wrote:
> Due to newly added IMX SCU firmware support, let's add
> drivers/firmware/imx into maintainership.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052a..d1fb824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1462,6 +1462,7 @@ F:	arch/arm/mach-mxs/
>  F:	arch/arm/boot/dts/imx*
>  F:	arch/arm/configs/imx*_defconfig
>  F:	drivers/clk/imx/
> +F:	drivers/firmware/imx/

Please add include/linux/firmware/imx/ too.

Shawn

>  F:	drivers/soc/imx/
>  F:	include/soc/imx/
>  
> -- 
> 2.7.4
> 
