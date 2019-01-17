Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD46C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9366205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAQOds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:33:48 -0500
Received: from muru.com ([72.249.23.125]:34020 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQOdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:33:47 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E80C98119;
        Thu, 17 Jan 2019 14:33:52 +0000 (UTC)
Date:   Thu, 17 Jan 2019 06:33:42 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hdegoede@redhat.com,
        Yonglong Wu <yonglong.wu@mediatek.com>
Subject: Re: [PATCH v3 4/4] usb: musb: Add support for MediaTek musb
 controller
Message-ID: <20190117143342.GS5544@atomide.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547709348-17506-5-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* min.guo@mediatek.com <min.guo@mediatek.com> [190117 07:16]:
> There are some quirk of MediaTek musb controller, such as:
>  -W1C interrupt status registers
>  -Private data toggle registers
>  -No dedicated DMA interrupt line

Can you please separate the musb generic changes listed above
into separate individual patches in preparation for adding
support for new hardware?

Otherwise we'll have hard time finding out with git bisect what
exactly breaks things if we run into trouble.

Regards,

Tony
