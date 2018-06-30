Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2211AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2CD2546A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVKcfjpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2CD2546A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeF3RfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeF3RfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:35:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C4F2255E;
        Sat, 30 Jun 2018 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530380107;
        bh=Nb4K5MCtZ9WiofmQocg5Z4VEZ9GYIJncE+T6Nx+XZ1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVKcfjpgzgfWnOMlFyfimbatO704RMJNtZvtUi4ePnFZ7eRoNJzs7PNahdyccDo+O
         yl7bNxVcQtOUDfuox9RxbyHxyw5JJoYiZxssbJiLCiHm5fY5fu72t1qcsKJvC89r0t
         ydt1rMqAroh/lNo77WgXhmNv0uyB6C1Wk9x6BkZU=
Date:   Sat, 30 Jun 2018 18:35:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: hx711: add maintainer for driver
Message-ID: <20180630183500.051452f0@archlinux>
In-Reply-To: <20180625151845.GA6392@arbeit>
References: <20180625151845.GA6392@arbeit>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 17:18:45 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add a maintainer for driver hx711
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
I applied this one before (not certain I emailed to say that)
so please drop from future versions of the patch set.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225d443a..cfb8a08777ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2535,6 +2535,13 @@ S:	Maintained
>  F:	drivers/auxdisplay/
>  F:	include/linux/cfag12864b.h
>  
> +AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +F:	drivers/iio/adc/hx711.c
> +
>  AX.25 NETWORK LAYER
>  M:	Ralf Baechle <ralf@linux-mips.org>
>  L:	linux-hams@vger.kernel.org

