Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5721904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392339AbfBNByg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:54:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728032AbfBNByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:54:36 -0500
X-UUID: a376d6289f334b4193666d8d5b816656-20190214
X-UUID: a376d6289f334b4193666d8d5b816656-20190214
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 559263774; Thu, 14 Feb 2019 09:54:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 14 Feb
 2019 09:54:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 09:54:28 +0800
Message-ID: <1550109268.30065.13.camel@mhfsdcap03>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From:   Qii Wang <qii.wang@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <ryder.lee@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>
Date:   Thu, 14 Feb 2019 09:54:28 +0800
In-Reply-To: <20190205131641.GF12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
         <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
         <20190205131641.GF12401@kunai>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > +  - mediatek,share-i3c: i3c controller can share i2c function.
> 
> I am not happy with this binding. There must be a better way of using
> the I3C controller in I2C mode. I think it would be easier to tell if we
> had an I3C driver to see how it implements I2C fallback there. Is the
> I3C driver on the way?
> 

I am very sorry for the late reply due to the Chinese New Year holiday.
After confirmation, for I2C mode in I3C controller, we will push an I3C
driver to implement I2C fallback there later, and we will remove
"mediatek,share-i3c" for i2c controller driver in the next patch.

