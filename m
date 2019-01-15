Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F43C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F71620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfAOQy7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:54:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59645 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbfAOQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:54:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1BD0207A3; Tue, 15 Jan 2019 17:54:55 +0100 (CET)
Received: from xps13 (unknown [77.136.203.173])
        by mail.bootlin.com (Postfix) with ESMTPSA id A6F3F20AAA;
        Tue, 15 Jan 2019 17:54:44 +0100 (CET)
Date:   Tue, 15 Jan 2019 17:54:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v4 0/3] mtd: rawnand: add STM32 FMC2 NAND flash
 controller driver
Message-ID: <20190115175442.6b553a84@xps13>
In-Reply-To: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
References: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 14 Dec
2018 10:58:05 +0100:

> This patchset adds the support for the STMicroelectronics FMC2 NAND flash
> controller found on STM32MP SOCs.
> 
> This patchset supports:
>   - the command sequencer feature, a hardware accelerator for read/write
>     within a page
>   - the manual mode feature, useful for debug purpose
>   - a maximum 8k page size
>   - following ECC strength and step size
> 	- nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8)
> 	- nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
> 	- nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended
> 	  ecc based on HAMMING)
>     
> This patchset has been tested on Micron MT29F8G08ABACAH4 (8-bit SLC NAND)
> and MT29F8G16ABACAH4 (16-bit SLC NAND)

Series applied on nand/next.


Thanks,
Miquèl
