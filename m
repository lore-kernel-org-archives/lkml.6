Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3qsmFdYZHVv5JgAAmS7hNA
	; Sun, 10 Jun 2018 12:30:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 35997608BA; Sun, 10 Jun 2018 12:30:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyya5+hb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AA9CC60791;
	Sun, 10 Jun 2018 12:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA9CC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeFJMaJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeFJMaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:30:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD5C2089C;
        Sun, 10 Jun 2018 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528633806;
        bh=r+meuC0uX3i0Q5of/LutMJigiFULkM7c3PoA930Ud4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eyya5+hbMcfAAYNBeCyh1+Hg686P5AoLSWqZtMeOgqCKNelcfWyELfHwak5dAwMbQ
         mGQa202BgU0GWUTckkDLpCmJKcX7GGgZLA8rtrjrNidAvw1wqVqK0XxnEj9qhCpNwZ
         zACsKSiz5mSE8YWUUTcEvn6ilxDmSLPoxXqq1Tds=
Date: Sun, 10 Jun 2018 13:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 1/9] MAINTAINERS: add generic resistive touchscreen
 adc
Message-ID: <20180610133000.35bf0344@archlinux>
In-Reply-To: <1526975559-18966-2-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:52:31 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add MAINTAINERS entry for generic resistive touchscreen adc
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied to the togreg branch of iio.git after a rebase brought
in the missing fix that was stalling this.  Note these are
now going to be heading upstream at the next merge window,
not the one currently open.

Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Changed source file name
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bdc260..ce9720f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5943,6 +5943,12 @@ F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
>  F:	Documentation/devicetree/bindings/power/power_domain.txt
>  
> +GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
> +M:	Eugen Hristev <eugen.hristev@microchip.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touchscreen/resistive-adc-touch.c
> +
>  GENERIC UIO DRIVER FOR PCI DEVICES
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  L:	kvm@vger.kernel.org
