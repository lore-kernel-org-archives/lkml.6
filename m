Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C962C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBTKyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:54:06 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53950 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:54:06 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2B6AD9E749C;
        Wed, 20 Feb 2019 10:54:04 +0000 (GMT)
Date:   Wed, 20 Feb 2019 10:54:02 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: chemical: pms7003: extend
 supported sensors list
Message-ID: <20190220105402.04cb8de6@archlinux>
In-Reply-To: <20190217192213.15803-3-tduszyns@gmail.com>
References: <20190217192213.15803-1-tduszyns@gmail.com>
        <20190217192213.15803-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 20:22:13 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add other sensors to the compatible list.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied,  This will miss the coming merge window, so will be a while
before it hits mainline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/chemical/plantower,pms7003.txt           | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> index 7b5f06f324c8..c52ea2126eaa 100644
> --- a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> @@ -1,7 +1,13 @@
>  * Plantower PMS7003 particulate matter sensor
>  
>  Required properties:
> -- compatible: must be "plantower,pms7003"
> +- compatible: must one of:
> +   "plantower,pms1003"
> +   "plantower,pms3003"
> +   "plantower,pms5003"
> +   "plantower,pms6003"
> +   "plantower,pms7003"
> +   "plantower,pmsa003"
>  - vcc-supply: phandle to the regulator that provides power to the sensor
>  
>  Optional properties:

