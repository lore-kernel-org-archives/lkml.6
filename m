Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6721874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfBKUU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:20:56 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53292 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBKUU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:20:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F156C9E7A81;
        Mon, 11 Feb 2019 20:20:53 +0000 (GMT)
Date:   Mon, 11 Feb 2019 20:20:50 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        johan@kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: add Plantower to the vendor
 prefixes
Message-ID: <20190211202050.56ca6132@archlinux>
In-Reply-To: <20190209173609.13220-3-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
        <20190209173609.13220-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:36:08 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add Plantower to the vendor prefixes.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore this.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 3cfe0c8b8250..fa391a650f3a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -300,6 +300,7 @@ phytec	PHYTEC Messtechnik GmbH
>  picochip	Picochip Ltd
>  pine64	Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> +plantower Plantower Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
>  plx	Broadcom Corporation (formerly PLX Technology)

