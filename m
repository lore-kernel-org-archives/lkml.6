Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026AC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C648241C5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C648241C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGEB1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:27:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41774 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752969AbeGEB1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:27:21 -0400
X-UUID: d3398eb5990e4b32b460d11825cc80a4-20180705
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chen.zhong@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 779870060; Thu, 05 Jul 2018 09:27:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Thu, 5 Jul
 2018 09:27:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 5 Jul 2018 09:27:14 +0800
Message-ID: <1530754034.14396.19.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH] dt-bindings: input: Add common keyboard document
 bindings
From:   Chen Zhong <chen.zhong@mediatek.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 Jul 2018 09:27:14 +0800
In-Reply-To: <20180704152514.33h52ujqp34hpj2o@penguin>
References: <1529648198-14231-1-git-send-email-chen.zhong@mediatek.com>
         <1529649595.14396.18.camel@mhfsdcap03>
         <20180704152514.33h52ujqp34hpj2o@penguin>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 15:25 +0000, Dmitry Torokhov wrote:
> On Fri, Jun 22, 2018 at 02:39:55PM +0800, Chen Zhong wrote:
> > Hi Dmitry,
> > 
> > The other patches in the series to add mediatek pmic keys support are
> > now available in 4.18-rc1, but this patch seems not being merged.
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
> > ib-mfd-input-rtc-v4.18
> > 
> > I have resend the patch, and rebase to 4.18-rc1.
> > Could you help to see if it is good enough to be merged into your tree?
> 
> I thought Rob would pick it up, but since he hasn't I'll do it.
> 
> Thanks.
> 

That would be great helpful.
Thank you.

