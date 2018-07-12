Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F9820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F9820C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeGLC7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:59:09 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8055 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeGLC7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:59:09 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 12 Jul
 2018 10:51:05 +0800
Subject: Re: [PATCH v2 2/3] clk: meson: add sub MMC clock dt-bindings IDs
To:     Rob Herring <robh@kernel.org>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-3-yixun.lan@amlogic.com>
 <20180711194546.GA7090@rob-hp-laptop>
CC:     <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <84511d9a-5d29-ae6f-de0b-4701bafe2ab7@amlogic.com>
Date:   Thu, 12 Jul 2018 10:51:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180711194546.GA7090@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 07/12/18 03:45, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 04:36:57PM +0000, Yixun Lan wrote:
>> Add two clock bindings IDs which provided by the MMC clock controller,
>> These two clocks will be used by MMC or NAND driver.
> 
> I count 3 ids.
I will update this

> 
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../dt-bindings/clock/amlogic,meson-mmc-clkc.h   | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> 
> This can go with the binding patch.
> 
sure

.


