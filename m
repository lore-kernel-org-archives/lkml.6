Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B25C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D721A21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D721A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbeKNQoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:44:18 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:13308 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKNQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:44:18 -0500
Received: from [10.18.29.185] (10.18.29.185) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 14 Nov
 2018 14:42:17 +0800
Subject: Re: [PATCH v6 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        <devicetree@vger.kernel.org>, Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1541090542-19618-1-git-send-email-jianxin.pan@amlogic.com>
 <20181111215745.07448b12@xps13>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <0aa11423-c442-771f-c061-0ac86aff733d@amlogic.com>
Date:   Wed, 14 Nov 2018 14:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181111215745.07448b12@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.185]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

I sorry to miss you in the CC list before, I will CC you in the next version.
Thank you very much.

On 2018/11/12 4:57, Miquel Raynal wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Fri, 2 Nov 2018 00:42:19
> +0800:
> 
>> These two patches try to add initial NAND driver support for Amlogic Meson
>> SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.
>>
> 
> Would you mind Cc:'ing me when you send NAND related patches? Otherwise
> there is a chance that it will take ages before I notice your series
> in the middle of the MTD patches flo
> 
> Thanks,
> Miquèl
> 
> .
> 

