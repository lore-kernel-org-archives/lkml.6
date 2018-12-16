Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A27C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E8217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeLPNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:15:30 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54776 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeLPNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:15:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 614FA9E74A2;
        Sun, 16 Dec 2018 13:15:28 +0000 (GMT)
Date:   Sun, 16 Dec 2018 13:15:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.brauchli@elementarea.net
Subject: Re: [PATCH v4 3/3] iio: chemical: sps30: add device tree support
Message-ID: <20181216131525.22e24839@archlinux>
In-Reply-To: <20181214182803.9006-4-tduszyns@gmail.com>
References: <20181214182803.9006-1-tduszyns@gmail.com>
        <20181214182803.9006-4-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 19:28:03 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add device tree support for Sensirion SPS30 particulate
> matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied with slight tweak to title to match dt-bindings: standard.

Thanks,

Jonathan

> ---
>  .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> new file mode 100644
> index 000000000000..6eee2709b5b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> @@ -0,0 +1,12 @@
> +* Sensirion SPS30 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "sensirion,sps30"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +sps30@69 {
> +	compatible = "sensirion,sps30";
> +	reg = <0x69>;
> +};

