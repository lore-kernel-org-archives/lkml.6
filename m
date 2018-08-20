Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333DB2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2Q8krdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333DB2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeHTVmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTVma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:42:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA6CF21473;
        Mon, 20 Aug 2018 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534789548;
        bh=34YhYK/+Buya1IaRI7bDK3XeUBdWNx86NaiZMPQ6UF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t2Q8krdjn+7g+OfEU9uy5gqGIt31pStmFhUwwXUZE+IYxWowDC6rUpxuim+kXd0Jt
         FnM8XcFeGrzLcQGWyHZIW9q/XMPXkoEytOKwdRr5NQ7dF7Kn5N1I6O/tejcN+01ihz
         WsH6oiBrFInlieV1ichkRMsOX0gKrJropx2zomtU=
Date:   Mon, 20 Aug 2018 19:25:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: potentiometer: mcp4018: use the correct
 MODULE_LICENSE
Message-ID: <20180820192544.44b2657f@archlinux>
In-Reply-To: <20180820100114.22966-2-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
        <20180820100114.22966-2-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 12:01:10 +0200
Peter Rosin <peda@axentia.se> wrote:

> The file is GPL v2 only.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/potentiometer/mcp4018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 320a7c929777..5ab74a839982 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -190,4 +190,4 @@ module_i2c_driver(mcp4018_driver);
>  
>  MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
>  MODULE_DESCRIPTION("MCP4018 digital potentiometer");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");

