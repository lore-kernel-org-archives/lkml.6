Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432372147E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0V5Xa7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432372147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHYMGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYMGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:06:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C7A20C51;
        Sat, 25 Aug 2018 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535185678;
        bh=shXWuBZIO8DtjyhBkTYaZD4e3TbF1/vHvOg2VMR0HCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s0V5Xa7buqCcLnvB3yikRHaheNbEAKdnr+KKJE6zjGbO2/dmHAM+T1TPVe6lwX/5h
         LiwJK/9XY9hgy1uzsON1jjKbPznhge4UZgv6D1uVV8GQiO06QJBFQrcllds1JprTyR
         AGnYMgG4uQxRTwUDjhjtKY2tedTE32w4+MwtThKk=
Date:   Sat, 25 Aug 2018 09:27:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add entry for ltc1660 DAC driver
Message-ID: <20180825092754.109510f2@archlinux>
In-Reply-To: <20180821193126.15733-3-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
        <20180821193126.15733-3-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 21:31:26 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add entry for ltc1660 DAC driver and add myself as
> maintainer of this driver.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Notes:
>     v2:
>     	- rename enumerated files, ltc166x* -> ltc1660*
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9276da915d9d..3db1edaf68bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
>  S:	Maintained
>  F:	drivers/scsi/sym53c8xx_2/
>  
> +LTC1660 DAC DRIVER
> +M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> +F:	drivers/iio/dac/ltc1660.c
> +
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org

