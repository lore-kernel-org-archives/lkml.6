Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C099C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084C42720A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084C42720A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeF1KYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:24:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20765 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752335AbeF1KYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:24:42 -0400
X-UUID: d82c724f82a14309908b0790ab60c160-20180628
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1456950625; Thu, 28 Jun 2018 18:24:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 18:24:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 18:24:32 +0800
Message-ID: <1530181472.17448.37.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add mtk-systimer bindings
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 28 Jun 2018 18:24:32 +0800
In-Reply-To: <32d0da38-f014-c2c0-70ff-11cdf9ed0569@linaro.org>
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
         <1530086039-3763-2-git-send-email-stanley.chu@mediatek.com>
         <32d0da38-f014-c2c0-70ff-11cdf9ed0569@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 10:20 +0200, Daniel Lezcano wrote:
> Actually this binding already exists for mediatek timers, it is useless
> to add a new one.
> 
> I note the binding in
> 
> Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> 
> contains:
> 
>  clocks = <&system_clk>, <&rtc_clk>
> 
> However the existing driver does only use <&system_clk> AFAICT, I'm
> questioning if <&rtc_clk> is really needed.
> 
> So, I suggest you sort out and fixup the rtc_clk thing (drop it) and
> then just add your new platform in the list in this binding.
> 
> 
Hi Daniel,

OK! We'll fix it and merge two timers into single document file in v3.

Thanks.
Stanley Chu

