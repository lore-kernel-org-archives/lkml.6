Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E93C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DED20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DED20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeGaBVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:21:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:9697 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbeGaBVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:21:32 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 31 Jul 2018 08:44:08 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 868AA60034;
        Tue, 31 Jul 2018 08:44:08 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 31 Jul 2018 08:44:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 400FE40385;
        Tue, 31 Jul 2018 08:44:08 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 02945120424;
        Tue, 31 Jul 2018 08:44:07 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <broonie@kernel.org>, <mark.rutland@arm.com>,
        =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?= 
        <yamada.masahiro@socionext.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <linux-kernel@vger.kernel.org>,
        =?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?= 
        <hayashi.kunihiko@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-2-git-send-email-hayashibara.keiji@socionext.com> <20180730214705.GA25882@rob-hp-laptop>
In-Reply-To: <20180730214705.GA25882@rob-hp-laptop>
Subject: RE: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI controller
Date:   Tue, 31 Jul 2018 08:44:04 +0900
Message-ID: <004f01d4285f$336d43f0$9a47cbd0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUJK+L7q1ixKL8VEufHh/TeUGI3aSnvXeAgAC0hsA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

I see.
I will add "Acked-by" and "Reviewed-by" tag by Rob in next version.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, July 31, 2018 6:47 AM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI controller
> 
> On Thu, Jul 26, 2018 at 04:09:02PM +0900, Keiji Hayashibara wrote:
> > From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >
> > Add DT bindings for SPI controller implemented in UniPhier SoCs.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > ---
> >  .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
> 
> Please add acks/reviewed-bys when posting new versions.
> 
> Rob


