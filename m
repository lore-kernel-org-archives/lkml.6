Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2E0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4142087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4142087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeJLTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:07:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46854 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:07:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so9591123oia.13;
        Fri, 12 Oct 2018 04:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMF9JxxwnF02BDuTzrjwGSLZgli9mIzEuq/ibGfsLt8=;
        b=Wj+gV9RDC+hc3G3tuutvHMicEoNhbbfT/l7WzG9ce4Zhp7sfNmX69LkuEjfyUK8p6p
         2/Z/xv6aJnBFM8mCTJzQ956DJYSeefvwAo+upLtVRBm3oKW6QpjXM37EuW01GjAs9S6s
         fLJ2LtWbHoAm249YPns/zopmgsbKkDqmi9FJW+sOMZnK+aHeeVFrbeM9Si253wwlckJy
         ry17pHlZNfUVSjnCPmsL/2W920P7d2JlporY9Phrl1Moi6q5nsvFZqyRdnjpElYrOXsz
         8fPBwkGw4deXee2jn9VtEEmknZizWEwVmqcoq2gyxcw2iTw4VjhbBoKutg1XPyYUH99C
         2xkg==
X-Gm-Message-State: ABuFfojqlTNFikdUk1+JOvk67/IRxCyfKbe2Z/euF8q8q1Fix6+9dld3
        AjdW1zUhUNN0L5M66E2XltQUy/o=
X-Google-Smtp-Source: ACcGV63mORYfl9EvMDLoai+1MkA4QPBkeX+CYSkIHakG+mCioKZUDgSsdVmVzeTnfZD3TQAuL+UrtA==
X-Received: by 2002:aca:b504:: with SMTP id e4-v6mr3136011oif.25.1539344153047;
        Fri, 12 Oct 2018 04:35:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i42sm237886otb.4.2018.10.12.04.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:35:52 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:35:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V8 18/21] dt-bindings: csky CPU Bindings
Message-ID: <20181012113551.GA17917@bogus>
References: <cover.1539315390.git.ren_guo@c-sky.com>
 <1c77e479a1dc0119912ac146b1038963b3653381.1539315391.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c77e479a1dc0119912ac146b1038963b3653381.1539315391.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:42:53PM +0800, Guo Ren wrote:
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 
> diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> new file mode 100644
> index 0000000..ee3901d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> @@ -0,0 +1,70 @@
> +==================
> +C-SKY CPU Bindings
> +==================
> +
> +The device tree allows to describe the layout of CPUs in a system through
> +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +defining properties for every cpu.
> +
> +Only SMP system need to care about the cpus node and single processor
> +needn't define cpus node at all.
> +
> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +- cpus node
> +
> +        Description: Container of cpu nodes
> +
> +        The node name must be "cpus".
> +
> +        A cpus node must define the following properties:
> +
> +        - #address-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 1
> +        - #size-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be set to 0
> +
> +- cpu node
> +
> +        Description: Describes one of SMP cores
> +
> +        PROPERTIES
> +

What happened to compatible?

> +        - device_type
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "cpu"
> +        - reg
> +                Usage: required
> +                Value type: <u32>
> +                Definition: CPU index
> +        - status:

Drop this. It is implied.

> +                Usage: required
> +                Value type: <string>
> +                Definition: "ok"       means enable  the cpu-core
> +                            "disabled" means disable the cpu-core
> +
> +Example:
> +--------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			status = "ok";
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			reg = <1>;
> +			status = "ok";
> +		};
> +	};
> -- 
> 2.7.4
> 
