Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04844C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA82627A88
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA82627A88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeF2AQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:16:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36831 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752608AbeF2AQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:16:56 -0400
X-UUID: 9d0d7f01c77745bb84ae6026cdf4a59d-20180629
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 461530588; Fri, 29 Jun 2018 08:16:51 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 29 Jun 2018 08:16:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 08:16:49 +0800
Message-ID: <1530231409.17448.52.camel@mtkswgap22>
Subject: Re: [PATCH v3 5/5] clocksource/drivers/timer-mediatek: Add support
 for system timer
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 29 Jun 2018 08:16:49 +0800
In-Reply-To: <b025b8c2-9cfd-466e-ec1c-9fa5e2148904@linaro.org>
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
         <1530182744-10731-6-git-send-email-stanley.chu@mediatek.com>
         <b025b8c2-9cfd-466e-ec1c-9fa5e2148904@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 16:08 +0200, Daniel Lezcano wrote:
> On 28/06/2018 12:45, Stanley Chu wrote:
> > This patch adds a new "System Timer" on the Mediatek SoCs.
> > 
> > The System Timer is introduced as an always-on timer being
> > clockevent device for tick-broadcasting.
> > 
> > For clock, it is driven by 13 MHz system clock.
> > The implementation uses the system clock with no clock
> > source divider.
> > 
> > For interrupt, the clock event timer can be used by all cores.
> > 
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > ---
> 
> Please do the GPT prefix in patch 3/5, so this patch will contain 'syst'
> addition only.
> 
Hi Daniel,

Sure! Will re-arrange patches in v4.

Thanks.
Stanley Chu

