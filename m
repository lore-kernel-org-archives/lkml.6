Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB102086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeJMADQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:03:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36412 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbeJMADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:03:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so11525671otg.3;
        Fri, 12 Oct 2018 09:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bYQwtw22cnJ7iwjtT+IQ3U10JZ2JRf3gGbAWTrZMP+I=;
        b=Bh2sothJ3CX+8sAjKDj8JKuKDL1jnzZrglDB6MME06FL0kxZzLi00VQOXjlcb8mp7+
         FoXw8BKZxtp9vF3TJKbndJA9eMkF1WkUphcssMOH2MLScMtdPFEp3P0dkwtDiG6JT31P
         r9WpaDatzETeuctyseumobmY+cUYEoh8OQ+OXRefw7abmeZOddLQXIIWGBuWiz7LWT4e
         2EKrgAPC5Sf6AXj2A3teivfQ407NeZ+QvWV3BXY7fRRzGAdg4P40vAw6Xi7y/20llE+x
         HZhXVdoN2PLtNZx/fwfnBM3lnuf1INIKRVvZ3bZRhbqNngvNqbgp+jLTDxRGXIoILs5O
         uI5g==
X-Gm-Message-State: ABuFfohr8yTR5wTLeiXPVKTysZLnpss4Jdvcr3Kw/8lDTqy6Y0bnRhOx
        VfGWwjmPpHZ6VNPRUDGLjA==
X-Google-Smtp-Source: ACcGV61U+l03lCvXoaLixCNZIkF7MQ0yhBk9w+8y51LTSQfPN7GcqlQL75hY6E0gr2IWGVeafFrabQ==
X-Received: by 2002:a9d:805:: with SMTP id 5mr4178859oty.161.1539361797998;
        Fri, 12 Oct 2018 09:29:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t69sm468548ota.10.2018.10.12.09.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:29:57 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:29:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com,
        jollys@xilinx.com, rajanv@xilinx.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/4] dt: bindings: Add SD tap value properties
 details for 'xlnx,zynqmp-8.9a'
Message-ID: <20181012162956.GA7339@bogus>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
 <1537435845-6682-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537435845-6682-2-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:00:42PM +0530, Manish Narani wrote:
> Add documentation for MIO bank required property and Tap Delays optional
> properties in devicetree bindings.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 72769e0..6cc95fa 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -27,6 +27,7 @@ Required Properties for "arasan,sdhci-5.1":
>  
>  Required Properties for "xlnx,zynqmp-8.9a":
>    - xlnx,device_id: SD controller device ID. Must be either <0> or <1>.
> +  - xlnx,mio-bank: The value will be 0/1/2 depending on MIO bank selection.
>  
>  Optional Properties:
>    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
> @@ -44,6 +45,24 @@ Optional Properties:
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
>  
> +Optional Properties for "xlnx,zynqmp-8.9a":
> + - xlnx,itap-delay-sd-hsd: Input Tap Delay for SD HS.
> + - xlnx,itap-delay-sdr25: Input Tap Delay for SDR25.
> + - xlnx,itap-delay-sdr50: Input Tap Delay for SDR50.
> + - xlnx,itap-delay-sdr104: Input Tap Delay for SDR104.
> + - xlnx,itap-delay-sd-ddr50: Input Tap Delay for SD DDR50.
> + - xlnx,itap-delay-mmc-hsd: Input Tap Delay for MMC HS.
> + - xlnx,itap-delay-mmc-ddr52: Input Tap Delay for MMC DDR52.
> + - xlnx,itap-delay-mmc-hs200: Input Tap Delay for MMC HS200.
> + - xlnx,otap-delay-sd-hsd: Output Tap Delay for SD HS.
> + - xlnx,otap-delay-sdr25: Output Tap Delay for SDR25.
> + - xlnx,otap-delay-sdr50: Output Tap Delay for SDR50.
> + - xlnx,otap-delay-sdr104: Output Tap Delay for SDR104.
> + - xlnx,otap-delay-sd-ddr50: Output Tap Delay for DDR50.
> + - xlnx,otap-delay-mmc-hsd: Output Tap Delay for MMC HS.
> + - xlnx,otap-delay-mmc-ddr52: Output Tap Delay for MMC DDR52.
> + - xlnx,otap-delay-mmc-hs200: Output Tap Delay for MMC HS200.

type, values, units for all of these?

Perhaps combine to pairs of values for input and output delays?

> +
>  Example:
>  	sdhci@e0100000 {
>  		compatible = "arasan,sdhci-8.9a";
> -- 
> 2.1.1
> 
