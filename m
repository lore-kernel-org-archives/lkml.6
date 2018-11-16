Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83216C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE82087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDE82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keep-it-simple.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKQAfX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:35:23 -0500
Received: from martinlund.org ([173.255.130.145]:51037 "EHLO
        slmp-550-86.slc.westdc.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbeKQAfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:35:23 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36607)
        by slmp-550-86.slc.westdc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <martin.lund@keep-it-simple.com>)
        id 1gNf1D-00ECRf-NV
        for linux-kernel@vger.kernel.org; Fri, 16 Nov 2018 07:22:47 -0700
Received: by mail-ot1-f45.google.com with SMTP id k98so21454399otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:22:47 -0800 (PST)
X-Gm-Message-State: AGRZ1gJxxJmJTQfJJr2Hx/RQFBEwDGhpy/PrE0vh+9CfyvCucuSsvGjC
        A+gfGDOLyOAWDYH6u31eNXVR8jdhqKRf8B1j4JI=
X-Google-Smtp-Source: AJdET5e8pa88IjE92X3SGicSUF8VSKByqpHlLCVpHqFD7GdwGfiWMJof8Nj34UmPyqfH6VbpNt/qmsLZe34ibyEMuyg=
X-Received: by 2002:a9d:599a:: with SMTP id u26mr6778004oth.11.1542378167289;
 Fri, 16 Nov 2018 06:22:47 -0800 (PST)
MIME-Version: 1.0
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
 <6ce1726a-f24d-17b8-d839-0a51c424a850@xilinx.com> <MWHPR02MB26231009A82C0372F62B5292AFDD0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB26231009A82C0372F62B5292AFDD0@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Martin Lund <martin.lund@keep-it-simple.com>
Date:   Fri, 16 Nov 2018 15:22:35 +0100
X-Gmail-Original-Message-ID: <CAB7pii2XYoP8bejamD2Rp0gtu6u07De+io0Yh3p1b=B-wE1_Fw@mail.gmail.com>
Message-ID: <CAB7pii2XYoP8bejamD2Rp0gtu6u07De+io0Yh3p1b=B-wE1_Fw@mail.gmail.com>
Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
To:     nagasure@xilinx.com
Cc:     michals@xilinx.com, Martin Lund <martin.lund@keep-it-simple.com>,
        naga sureshkumar <nagasuresh12@gmail.com>,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - slmp-550-86.slc.westdc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - keep-it-simple.com
X-Get-Message-Sender-Via: slmp-550-86.slc.westdc.net: authenticated_id: martin.lund+keep-it-simple.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: slmp-550-86.slc.westdc.net: martin.lund@keep-it-simple.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the clk_ prefix is kind of unnecessary. Though, all the
clock-names in zynqmp.dtsi are still using the prefix - hopefully that
will eventually be cleaned out.

Either way, we just need to make sure the device tree doc clock-names
are consistent with whatever is used by the driver.

Br, Martin
On Fri, Nov 16, 2018 at 2:50 PM Naga Sureshkumar Relli
<nagasure@xilinx.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Michal Simek [mailto:michal.simek@xilinx.com]
> > Sent: Friday, November 16, 2018 6:04 PM
> > To: Martin Lund <martin.lund@keep-it-simple.com>; Naga Sureshkumar Relli
> > <nagasure@xilinx.com>
> > Cc: boris.brezillon@bootlin.com; miquel.raynal@bootlin.com; richard@nod.at; David
> > Woodhouse <dwmw2@infradead.org>; Brian Norris <computersforpeace@gmail.com>; Marek
> > Vašut <marek.vasut@gmail.com>; naga sureshkumar <nagasuresh12@gmail.com>; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org; robh@kernel.org
> > Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree binding
> > documentation
> >
> > On 16. 11. 18 12:50, Martin Lund wrote:
> > > Hi Naga,
> > >
> > > I've been working on running up the latest kernel (v4.20-rc2) on our
> > > custom Xilinx hw board so that I can test the v12 version of your
> > > Arasan nand driver.
> > >
> > > I've managed to get the driver successfully up and running and ready
> > > for testing with a Micron MT29F64G08AFAAAWP device. However, setting
> > > it up I've found a few inaccuracies in the documentation of the device
> > > tree bindings.
> > >
> > > This is the device configuration that ended up working for me with
> > > linux v4.20-rc2:
> > >
> > >        nfc: nand@ff100000 {
> > >             compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10";
> > >             reg = <0x0 0xff100000 0x0 0x1000>;
> > >             clock-names = "clk_sys", "clk_flash";
> > >             clocks = <&clk200>, <&clk100>;
> > >             interrupt-parent = <&gic>;
> > >             interrupts = <0 14 4>;
> > >             #address-cells = <1>;
> > >             #size-cells = <0>;
> > >
> > >             nand@0 {
> > >                 reg = <0>;
> > >                 nand-ecc-mode = "hw";
> > >             };
> > >         };
> > >
> > > Compared with the example you will notice that "clock-name" should be
> > > "clock-names". reg was missing a "0x0".
> >
> > clock-names and even that names - you are right it is not correct and should be fixed.
> Clock-names I will change from "clock-name" to "clock-names".
> But I got some review comments previously, to use "sys" instead of  "clk_sys" and "flash" instead of "clk_flash".
> And I have to change this in driver.
> I will update that.
>
> Thanks,
> Naga Sureshkumar Relli
>
> >
> > Missing 0x0 in reg doesn't matter because it depends on address/size cells.
> >
> > > I think it is helpful to provide a real-world working example, so you
> > > might also consider changing the example "clocks" configuration to
> > > clk200/clk100 since there is no clk_misc among the clock sources of
> > > any of the xilinx zynqmp board device tree configurations.
> >
> > Real example is the best normally just c&p from existing dts is the way to go.
> > But in connection to clocks it doesn't matter what exactly should be there and I don't think
> > there is any consistency in that. Hopefully this will be removed by yaml conversion.
> >
> > Thanks,
> > Michal
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
