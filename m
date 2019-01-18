Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2505C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA51C20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfARBR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:17:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4217 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726188AbfARBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:17:55 -0500
X-UUID: d3526cde18e94e4a95d2c3cbaabbeec1-20190118
X-UUID: d3526cde18e94e4a95d2c3cbaabbeec1-20190118
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 692066483; Fri, 18 Jan 2019 09:17:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Jan
 2019 09:17:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 09:17:48 +0800
Message-ID: <1547774268.4433.238.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/4] Add MediaTek MUSB Controller Driver
From:   Min Guo <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Date:   Fri, 18 Jan 2019 09:17:48 +0800
In-Reply-To: <20190117150053.GH18026@uda0271908>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
         <20190117150053.GH18026@uda0271908>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Thu, 2019-01-17 at 09:00 -0600, Bin Liu wrote:
> On Thu, Jan 17, 2019 at 03:15:44PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > These patches introduce the MediaTek MUSB controller driver.
> > 
> > The driver can be configured as Dual-Role Device (DRD),
> > Peripheral Only and Host Only modes. This has beed tested on
> > MT2701 with a variety of devices in host mode and with the 
> > f_mass gadget driver in peripheral mode, plugging otg cables
> > in/out a lot of times in all possible imaginable plug orders.
> > 
> > changes in v3:
> 
> Please put the change log in each individual patch, which helps in
> viewing patches.

Okay.

> Regards,
> -Bin.


