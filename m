Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0920645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfAOPnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:43:35 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:33936 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:43:34 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 10:43:33 EST
Received: from [192.168.0.111] (223.166.104.240) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Tue, 15 Jan
 2019 23:44:15 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v8 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
 <20190115094911.75f4edc9@xps13>
Message-ID: <18ad7184-3bbe-4bd1-826a-fce5d31c215c@amlogic.com>
Date:   Tue, 15 Jan 2019 23:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190115094911.75f4edc9@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2019/1/15 16:49, Miquel Raynal wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sun, 16 Dec 2018
> 23:17:41 +0800:
> 
>> These two patches try to add initial NAND driver support for Amlogic Meson
>> SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.
>>
>> Changes since V6 at [8]
>>  - fix bitflips checking for blank pages
>>  - trace the latest commit with nand/next branch
>>  - checking the return of meson_nand_op_get_dma_safe_*input/output*_buf
>>  - add .detach_chip for free meson_nand.data_buf/info_buf
>>
> 
> Can you send a v9 with the build failre (object_is_on_stack pb) fixed
> and the Kconfig entry updated (the Meson common clock thing) as
> suggested by Martin?
I sent v9 just now, object_is_on_stack build fail is fixed and Kconfig is updated as Martin suggested.
Thank you for your time.
> 
> 
> Thanks,
> Miquèl
> 
> .
> 

