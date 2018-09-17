Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D38ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA52A214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA52A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeIQLtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:49:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32802 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeIQLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:49:33 -0400
Received: by mail-it0-f65.google.com with SMTP id j198-v6so10224146ita.0;
        Sun, 16 Sep 2018 23:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dSxjTum8wfTtXUQOOSIitCo9anmdohRMwlt1aHxfL/o=;
        b=IlmN0lQXwVELAHWZZkuRcbjt6xLhjJa9FOPRsdAfA98xE/bA8liwztNhWKB6A6+6yT
         aB0TvPAefUPbnUcAKR8lhDK1ZExSCIW7U/wxTGB4EMHCk+CVw626J0Bm2Z5OvKkf9U46
         e1c2+1u4dHffXFi8MjswuuxTKwfCPOSAF9iA8QT9EEnO0weL2JZWp9oHEv9G3PE641Ei
         MQasH/aigyTYghxNNhQst2e9F1W4CsuQbLFR/PT1yfjEYULUXSyFnaYREPS4UIXdVemd
         0eiVu8PJfkNu9xIUsVwIiOAFoUXzaoagiD8SQrJUrZJ6VjxTtSDuD36qDM929g30Gnjt
         P2hw==
X-Gm-Message-State: APzg51DujchFBYMAxMjcuSPV1sb+T760kVX5/PP8GrTthWRgRVOw+983
        qxdxoEeRdXxFjC0tyn96+A==
X-Google-Smtp-Source: ANB0VdZWk1ebct0k8my0n/WYcnjkEarogqkxCthYmGxbdMtMmb502w21mZ3AarR2/GYIQmLKjUhmDA==
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr11583443itf.113.1537165417733;
        Sun, 16 Sep 2018 23:23:37 -0700 (PDT)
Received: from localhost ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i2-v6sm4549144ioh.80.2018.09.16.23.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 23:23:37 -0700 (PDT)
Date:   Mon, 17 Sep 2018 02:23:36 -0400
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V5 2/3] dt-bindings: interrupt-controller: C-SKY APB intc
Message-ID: <20180917062336.GA20555@bogus>
References: <a70337117db84f6e1091d0b3fc28acb691ac9b35.1537087118.git.ren_guo@c-sky.com>
 <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162f7f98697cd9d806a1a843c6177bb943ea2b33.1537087118.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 04:50:03PM +0800, Guo Ren wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Needs a commit description.

> ---
>  .../interrupt-controller/csky,apb-intc.txt         | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> new file mode 100644
> index 0000000..be7c3d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> @@ -0,0 +1,70 @@
> +==============================
> +C-SKY APB Interrupt Controller
> +==============================
> +
> +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> +on the apb bus and we only use it as root irq controller.
> +
> + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
> + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.

Is there a relationship between csky,gx6605s-intc and csky,apb-intc?

> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +        Description: Describes APB interrupt controller
> +
> +        PROPERTIES
> +
> +        - compatible
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,apb-intc"
> +				    "csky,dual-apb-intc"
> +				    "csky,gx6605s-intc"
> +        - #interrupt-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be <1>
> +	- reg
> +		Usage: required
> +		Value type: <u32 u32>
> +                Definition: <phyaddr size> in soc from cpu view
> +        - interrupt-controller:
> +                Usage: required
> +        - support-pulse-signal:
> +                Usage: select
> +		Description: to support pulse signal flag

What is this for?

> +
> +Examples:
> +---------
> +
> +	intc: interrupt-controller@500000 {
> +		compatible = "csky,apb-intc";
> +		#interrupt-cells = <1>;
> +		reg = <0x00500000 0x400>;
> +		interrupt-controller;
> +	};
> +
> +	intc: interrupt-controller@500000 {
> +		compatible = "csky,apb-intc";
> +		#interrupt-cells = <1>;
> +		reg = <0x00500000 0x400>;
> +		interrupt-controller;
> +		support-pulse-signal;
> +	};

Not really worth 2 examples for just 1 property difference.

> +
> +	intc: interrupt-controller@500000 {
> +		compatible = "csky,dual-apb-intc";
> +		#interrupt-cells = <1>;
> +		reg = <0x00500000 0x400>;
> +		interrupt-controller;
> +	};
> +
> +	intc: interrupt-controller@500000 {
> +		compatible = "csky,gx6605s-intc";
> +		#interrupt-cells = <1>;
> +		reg = <0x00500000 0x400>;
> +		interrupt-controller;
> +	};
> -- 
> 2.7.4
> 
