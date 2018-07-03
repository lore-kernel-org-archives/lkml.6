Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11889C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48CA245A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48CA245A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbeGCOFr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:05:47 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:20175 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbeGCOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:05:46 -0400
Received: from [192.168.90.66] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul 2018
 22:04:56 +0800
Subject: Re: [PATCH v2 2/2] clk: meson-axg: add clocks required by pcie driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180702213118.19222-1-yixun.lan@amlogic.com>
 <20180702213118.19222-3-yixun.lan@amlogic.com>
 <1530609862.2900.187.camel@baylibre.com>
 <7c8b47a9-67bc-b685-8c90-084299631fb0@amlogic.com>
 <1530615672.2900.205.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Jianxin Qin <jianxin.qin@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <f23be559-4a64-7fbd-a7f7-4bdc2b6aabac@amlogic.com>
Date:   Tue, 3 Jul 2018 22:05:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1530615672.2900.205.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

On 07/03/2018 07:01 PM, Jerome Brunet wrote:
> On Tue, 2018-07-03 at 18:17 +0800, Yixun Lan wrote:
>> I'm seeing you already applied this patch, so would you like to
>> fix/amend the patch for me, or want me send another patch version?
>>
>> thanks
> 
> It means that I amended your patch before applying it.
> 
> .
> 

Sorry, I'm asking..

because as I checked the clk-meson[1] tree, branch  - next/drivers,
it's not updated which it's still my original version..

Yixun


[1]
https://github.com/BayLibre/clk-meson/commit/cd1c7b71d14f197c404533c085b83817c08bf516#diff-c9327329286e3a07f2ddbe69649ec963R714

