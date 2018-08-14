Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B1FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EB221729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EB221729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbeHNTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:07:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34880 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNTHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:07:07 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so20506049itf.0;
        Tue, 14 Aug 2018 09:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wu0u5+L2FWkAqOLjAJr1rOJVtyvI+3PxkN20bqYSQYA=;
        b=JU+p5deDJzF164JxzZZfVJOPE8LUXPoGdUPbAljsbPYaoKRIc8axWz+SQEiCpb436n
         fKtQ31r+HsD0vZ0z3/IqV3ZFlGgX4FhBhYeDs53IV3eSIFgWrm0rWLyyY2GXedFieRY2
         sYd10snP9EUEhXJlNyG3S9xyNxxBk1HNOsYt5zQwc0in/3rlEjJJ6o3TF4rChxfBot8p
         qqlSAl+pyIFRRrFR1x3Je6DH4iWkM1YB2qHt8r+G++2wziotKxrqzcKrWRXIgwdSoW3i
         bL9VUFfUS7zxW/EfjwmNc9RgKmy5L/mDRc7FeV8YRK7Y6v6eGVNW2dZVIygSDtrksclx
         whwg==
X-Gm-Message-State: AOUpUlHeB2eGhrfzvm2OVxqWkcyC2WGPgoRwpUvhLyJkNwPjAU4jLUck
        IbKJxjLbRUwxGOyDwYBPww==
X-Google-Smtp-Source: AA+uWPyioNCoScpRTpD1iw5Xs074+moRgX4iNo1znjAW8KCFMpE9eshjt6luITeneyrKo8sj5jrIpA==
X-Received: by 2002:a24:ef43:: with SMTP id i64-v6mr14842887ith.47.1534263558476;
        Tue, 14 Aug 2018 09:19:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id r13-v6sm7250829ioc.71.2018.08.14.09.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 09:19:17 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:19:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, atull@opensource.altera.com,
        moritz.fischer@ettus.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        appanad@xilinx.com, chinnikishore369@gmail.com,
        Nava kishore Manne <navam@xilinx.com>
Subject: Re: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Message-ID: <20180814161917.GA26926@rob-hp-laptop>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 03:34:56PM +0530, Nava kishore Manne wrote:
> New bindings document for zynqmp fpga manager.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..0eac747747f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,9 @@
> +Xilinx Zynqmp FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	pcap: pcap@00 {
> +		compatible = "xlnx,zynqmp-pcap-fpga";

How is this accessed? Via firmware interface? If so, need to define it 
is a child of the firmware node.

> +	};
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
