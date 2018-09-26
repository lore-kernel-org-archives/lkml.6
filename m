Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB1CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DFF20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWzZBOHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DFF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeIZTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeIZTbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:31:31 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD1220843
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537967915;
        bh=yQtcc+aTXBNC4ba9dXvAna97pxX7USC0nPRZ8rSKF0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LWzZBOHDx7+yYncvtoCKbUZnLxLvqtekdO4NPXVepzw9sA/fQrAE9Wc8yH5IMCHJZ
         WWmdg5Z9+1vCITFjTAv+4LTF6tifLMWyPViyQOmZyJbf1i13wc5G2kYB4YJ9GJ4es3
         sDcpEQupfwwm6bouz2d77/JukdH1tcLwVPpJvK4s=
Received: by mail-wm1-f43.google.com with SMTP id y13-v6so2314253wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:18:34 -0700 (PDT)
X-Gm-Message-State: ABuFfojfiL4CbXuHA0TdYuKWQpHGoOan6g1VVBaaFgGweHO6ojxPvILD
        Dx4Yumsixful+isqRRkPrnnNlRsnhfQwJUFf8hHSfw==
X-Google-Smtp-Source: ACcGV620iuz8HN2Bno4i8O2EyPkIkYCZnhBwkl2pZe3BCDo0NUQEEEtf7U5rOMBLeXM3W91xkHeTyXD1jr6M6Vcy43o=
X-Received: by 2002:a1c:820d:: with SMTP id e13-v6mr4467881wmd.91.1537967913387;
 Wed, 26 Sep 2018 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1537878031-22253-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1537878031-22253-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Sep 2018 08:18:21 -0500
X-Gmail-Original-Message-ID: <CABGGiszo3BO9LrSPT7tRey9g6jMZkB_0oXJA7ebsk-toud0EGw@mail.gmail.com>
Message-ID: <CABGGiszo3BO9LrSPT7tRey9g6jMZkB_0oXJA7ebsk-toud0EGw@mail.gmail.com>
Subject: Re: [LINUX PATCH v11 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
To:     naga.sureshkumar.relli@xilinx.com
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        michals@xilinx.com, nagasuresh12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings should be sent to DT list.

On Tue, Sep 25, 2018 at 7:21 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:
>
> This patch adds the dts binding document for arasan nand flash controller
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v11:
>  - Updated compatible description as suggested by Boris
>  - Removed arasan-has-dma property
> Changes in v10:
> - None
> Changes in v9:
> - None
> Changes in v8:
> - Updated compatible and clock-names as per Boris comments
> Changes in v7:
> - Corrected the acronyms those should be in caps
> Changes in v6:
> - Removed num-cs property
> - Separated nandchip from nand controller
> Changes in v5:
> - None
> Changes in v4:
> - Added num-cs property
> - Added clock support
> Changes in v3:
> - None
> Changes in v2:
> - None
> ---
>  .../devicetree/bindings/mtd/arasan_nand.txt        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> new file mode 100644
> index 0000000..546ed98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> @@ -0,0 +1,33 @@
> +Arasan NAND Flash Controller with ONFI 3.1 support
> +
> +Required properties:
> +- compatible:          Should be "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> +- reg:                 Memory map for module access
> +- interrupt-parent:    Interrupt controller the interrupt is routed through

Drop this. It is implied.

> +- interrupts:          Should contain the interrupt for the device
> +- clock-name:          List of input clocks - "sys", "flash"
> +                       (See clock bindings for details)
> +- clocks:              Clock phandles (see clock bindings for details)
> +
> +Required properties for child node:
> +- nand-ecc-mode: see nand.txt
> +
> +For NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +       nfc: nand@ff100000 {
> +               compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10"

Missing ;

> +               reg = <0x0 0xff100000 0x1000>;
> +               clock-name = "sys", "flash"

Missing ;

> +               clocks = <&misc_clk &misc_clk>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 14 4>;
> +               #address-cells = <1>;
> +               #size-cells = <0>

Missing ;

> +
> +               nand@0 {
> +                       reg = <0>

Missing ;

> +                       nand-ecc-mode = "hw";
> +               };
> +       };
> --
> 2.7.4
>
