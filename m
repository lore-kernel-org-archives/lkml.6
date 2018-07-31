Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD0AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbeHAAQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:16:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40900 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbeHAAQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:16:17 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so14421454iob.7;
        Tue, 31 Jul 2018 15:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUi7EKquHvJ3g6za1/zjw7Q107dmvKFQhrJJZZaiMTg=;
        b=CQOvVvPFDN3Y9mRvCWXEKqFW8NHpUuuIzyhV6hBR88t7cIqa4fFpwDlpSyvs10n+Xq
         sYSszKQjQ1LC3/XMRxzDdpdltuid5fV6J3p18EY9PBDQsu7jutD1+Kk/IjOKQl6ERmv6
         /Otv6JAEG7JNugDHpPVjt/knYC0biXd20IG7h7oQ0vUeLlCHvBCBtEruC2UWn8bRweGk
         Z8vlb0HDLeJraOmF4RlvdeT9yvvNGHHeQDT0fIIBZ0BVduwgUUL+p23/QnP2nFEyq7ot
         SXs2+UcR63uyRdV9qdjy8ICi9LdAfIawzCr0xWxMXeQaLBLsI/JPXpd6/90T9ufKvd/L
         80sA==
X-Gm-Message-State: AOUpUlFcCIFboTRj5Me9Eo9wA49yRc1ZZIX/lGw0/UZ59ffqbEc/m0Lw
        SLyeuzVl2nzVh0H10KCj0cUUPuJXNw==
X-Google-Smtp-Source: AAOMgpdAph6YFD+vLHDasMijvtUj2lsIqYVXWHyiIoDUBYDkAoFkk1EXyBRsCjlmc56LUVf7w/XsfQ==
X-Received: by 2002:a6b:6e19:: with SMTP id d25-v6mr1406744ioh.55.1533076426865;
        Tue, 31 Jul 2018 15:33:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f204-v6sm2050256itc.13.2018.07.31.15.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:33:46 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:33:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding
 document
Message-ID: <20180731223345.GA23086@rob-hp-laptop>
References: <20180725054059.19506-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725054059.19506-1-john@phrozen.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 07:40:57AM +0200, John Crispin wrote:
> This patch adds the binding documentation for the HS/SS USB PHY found
> inside Qualcom Dakota SoCs.

Qualcomm

> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../bindings/phy/phy-qcom-ipq4019-usb.txt           | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
> new file mode 100644
> index 000000000000..362877fcafed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
> @@ -0,0 +1,21 @@
> +Qualcom Dakota HS/SS USB PHY
> +
> +Required properties:
> + - compatible: "qcom,usb-ss-ipq4019-phy",
> +	       "qcom,usb-hs-ipq4019-phy"

<vendor>,<soc>-<block> is the usual order.

> + - reg: offset and length of the registers
> + - #phy-cells: should be 0
> + - resets: the reset controllers as listed below
> + - reset-names: the names of the reset controllers
> +	"por_rst" - the POR reset line for SS and HS phys
> +	"srif_rst" - the SRIF reset line for HS phys

'_rst' is redundant.

> +Example:
> +
> +hsphy@a8000 {

usb-phy@...

> +	compatible = "qcom,usb-hs-ipq4019-phy";
> +	phy-cells = <0>;
> +	reg = <0xa8000 0x40>;
> +	resets = <&gcc USB2_HSPHY_POR_ARES>,
> +		 <&gcc USB2_HSPHY_S_ARES>;
> +	reset-names = "por_rst", "srif_rst";
> +};
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
