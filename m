Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E7206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeJFEfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:35:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:22685 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbeJFEfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:35:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 14:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,346,1534834800"; 
   d="scan'208";a="95031259"
Received: from fplordan-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.6.57])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2018 14:34:27 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 492E221D11; Sat,  6 Oct 2018 00:34:26 +0300 (EEST)
Date:   Sat, 6 Oct 2018 00:34:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/3] [media] imx214: device tree binding
Message-ID: <20181005213425.5mcafszioz4wxun5@kekkonen.localdomain>
References: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Oct 05, 2018 at 02:49:37PM +0200, Ricardo Ribalda Delgado wrote:
> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
> 
> Document bindings for imx214 camera sensor
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> new file mode 100644
> index 000000000000..421a019ab7f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
> @@ -0,0 +1,53 @@
> +* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
> +
> +The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
> +an active array size of 4224H x 3200V. It is programmable through an I2C
> +interface. The I2C address can be configured to 0x1a or 0x10, depending on
> +how the hardware is wired.
> +Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
> +throughput of 1.2Gbps/lane.
> +
> +
> +Required Properties:
> +- compatible: value should be "sony,imx214" for imx214 sensor

should -> shall ?

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
