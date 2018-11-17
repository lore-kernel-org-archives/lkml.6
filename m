Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62E720815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62E720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeKRBEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:04:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39507 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKRBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:04:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so21984832oii.6;
        Sat, 17 Nov 2018 06:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stsnSiQvOzo+ZNhcptAw6yqhVZJPir6cu3yTcMtukUM=;
        b=sg3ytPc9cTteZDRB2Tl8SwkQPuwg+5WJKLlY0Fhaat5ofDAN4uysIWAPHyeZQbe0YR
         v+QhLfe8LxU1u7tCxMSUwDttSJLnq2lVM6DgW2dJi+w7+AUJVkrbVKsVM1bt/qN99D//
         EE5CRrUu9En6GJY5MapshN/rfH+7pWcIH6tBIXRnGN7Tku7LdB0Ui1y/odknpcPjn3H3
         7aDTGEuuDQAolZSSFrwoA1BICuaLuwPG7Vy9u8kYfGjT5p1ojBQPxnffPo6SAODrSeqf
         G86yTlKn8eIjsORtyMHx2r8xXRPSta9jrLaHlSAZFzXs3bFjyYNAIw22POrH6iGfzZET
         rgbA==
X-Gm-Message-State: AGRZ1gJuwu/MLZGGKMnJpqTogWTqt4Sn7oU/nDZ2ue8Erv+W08c5LKqC
        v1vtpLn67tz3MdjMACQXs8Mbuoo=
X-Google-Smtp-Source: AJdET5ddZ0sDocnmXBHBCPryChPfZWIfOoGNlfXBMrDv5/D3Pk/MnCmwk/Bw+lI7WPo1eihXy3pSug==
X-Received: by 2002:aca:4d8f:: with SMTP id a137mr3443132oib.168.1542466027799;
        Sat, 17 Nov 2018 06:47:07 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id b82-v6sm12713282oif.50.2018.11.17.06.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 06:47:07 -0800 (PST)
Date:   Sat, 17 Nov 2018 08:47:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: Documentation for qcom,eud
Message-ID: <20181117144705.GA18155@bogus>
References: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
 <1542310374-18474-2-git-send-email-pheragu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542310374-18474-2-git-send-email-pheragu@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:32:53AM -0800, Prakruthi Deepak Heragu wrote:
> Documentation for Embedded USB Debugger (EUD) device tree bindings.

I asked questions on v2 which were never answered.

> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> new file mode 100644
> index 0000000..6d339e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> @@ -0,0 +1,43 @@
> +* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
> +
> +The EUD (Embedded USB Debugger) is a mini-USB hub implemented
> +on chip to support the USB-based debug and trace capabilities.
> +
> +Required properties:
> +
> + - compatible:  Should be "qcom,msm-eud"
> + - interrupts:  Interrupt number
> + - reg: Should be address and size of EUD register space
> +
> +EUD notifies clients for VBUS attach/detach and charger enable/disable
> +events. The link between client and EUD is established via a directed
> +graph. EUD has one endpoint of the graph link mentioning EUD as an
> +output link and clients of EUD should have the other endpoint of the
> +graph link as an input link.
> +
> +An example for EUD device node:
> +
> +	eud: qcom,msm-eud@88e0000 {
> +		compatible = "qcom,msm-eud";
> +		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x88e0000 0x4000>;
> +		usb_con: connector {
> +                compatible = "usb-c-connector";
> +                label = "USB-C";
> +                port {
> +                	    eud_usb_output: endpoint {
> +                        	    remote-endpoint = <&eud_usb3_input>;
> +                        };
> +        	    };
> +        };
> +	};
> +
> +An example for EUD client:
> +
> +	usb3 {
> +		port {
> +                eud_usb3_input: endpoint {
> +                        remote-endpoint = <&eud_usb_output>;
> +                };
> +        };
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
