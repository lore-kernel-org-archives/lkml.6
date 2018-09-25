Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B123220833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIZBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:34:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43734 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeIZBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:34:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id s69-v6so2487914oie.10;
        Tue, 25 Sep 2018 12:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chMaRgeZJAvMYpfbdNzGK1cPZl4EyN95AHN/BIBsqsA=;
        b=PD5sY+nZQ1QO5Vhso+dU1g7bqy11IWiaWI7zBsPYVj8da2nCrFM9m034UaOqzkAvxv
         Hd3OcCmgVwXsRZSV2H7naq/vpbEmr6wmzWhNfqRAgV+K2GBZMLs6Q7204F6TUvHUsi0/
         MtPxrwzIymrX2n057eKl0u97JCdvJ9Jin99l52U6f3x0vdObXH5JprloP7d3e05P1gU2
         zjXGdcoYA8Lt0TniAUlCA3JFMEndMVDAibDMKyKsc1szQLKOvqXKzDE2OEUl21VfIXhy
         KEsen0BfJXIRjgvjZnx9MnBZe/85IZCPIuubup6Gun0Oe3yHZGtwOxsBOoDoRVpVhc5h
         84Xw==
X-Gm-Message-State: ABuFfohmXeFIBo1uCPXqdpw9vaynN8TDdIUkEZchA1vb2o3LJ352KOX3
        wU24bhrAhKifj1s1ouAuHsL1r+iYdk2W
X-Google-Smtp-Source: ACcGV63uaZW+FwNwbE/tBeC1Saf1jusJAveWsqWijUN+tjDvZnH2aXMrJ/hvDayLqO2Mzgwsouh8SA==
X-Received: by 2002:aca:da54:: with SMTP id r81-v6mr1489409oig.47.1537903509798;
        Tue, 25 Sep 2018 12:25:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r13-v6sm969219otk.26.2018.09.25.12.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:25:08 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:25:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Documentation for qcom,eud
Message-ID: <20180925192507.GA19360@bogus>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
 <1536096853-30473-2-git-send-email-pheragu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536096853-30473-2-git-send-email-pheragu@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:34:12PM -0700, Prakruthi Deepak Heragu wrote:
> Documentation for Embedded USB Debugger (EUD) device tree bindings.
> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> new file mode 100644
> index 0000000..a03021a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> @@ -0,0 +1,41 @@
> +* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
> +
> +The EUD (Embedded USB Debugger) is a mini-USB hub implemented
> +on chip to support the USB-based debug and trace capabilities.

Is it just for debug and normally bypassed? 

> +
> +Required properties:
> +
> + - compatible:  Should be "qcom,msm-eud"

Needs to be SoC specific (though a fallback is fine).

> + - interrupts:  Interrupt number
> + - reg: Should be address and size of EUD register space
> +
> +Driver notifies clients for VBUS attach/detach and charger enable/disable

Bindings are for h/w blocks, not drivers.

> +events. The link between client and EUD is established via a directed
> +graph. EUD driver has one endpoint of the graph link mentioning EUD as an
> +output link and clients registered for these notifications from the EUD
> +should have the other endpoint of the graph link as an input link. 

OF graph is for describing data flows (i.e. h/w connections), not 
clients wanting some event.

> Each of
> +these endpoints should contain a 'remote-endpoint' phandle property that
> +points to the corresponding endpoint in the port of the remote device.

You don't need to describe how the graph binding works. Just what the 
port assignments are.

I worry this is going to collide with using the graph binding for USB 
connectors.

> +
> +An example for EUD device node:
> +
> +	eud: qcom,msm-eud@88e0000 {
> +		compatible = "qcom,msm-eud";
> +		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x88e0000 0x4000>;
> +		port {
> +                	eud_output: endpoint {
> +                        	remote-endpoint = <&usb3_input>;
> +                        };
> +        	};
> +	};
> +
> +An example for EUD client:

What are possible clients? Could we want to switch clients at runtime?

> +
> +	usb3 {
> +		port {
> +                	usb3_input: endpoint {
> +                        	remote-endpoint = <&eud_output>;
> +                        };
> +        	};
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
