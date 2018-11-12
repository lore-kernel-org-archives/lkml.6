Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D31AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01AE224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01AE224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeKMDe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:34:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54304 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:34:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 570D3208A0; Mon, 12 Nov 2018 18:40:40 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2013320510;
        Mon, 12 Nov 2018 18:40:40 +0100 (CET)
Date:   Mon, 12 Nov 2018 18:40:40 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "long17.cool@163.com" <long17.cool@163.com>
Cc:     "a.zummo" <a.zummo@towertech.it>,
        "mark.rutland" <mark.rutland@arm.com>,
        linux-rtc <linux-rtc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 3/4] dt-bindings: rtc: sd3078: add device tree
 documentation
Message-ID: <20181112174040.GG29768@piout.net>
References: <1542001514-8167-1-git-send-email-long17.cool@163.com>
 <1542001514-8167-3-git-send-email-long17.cool@163.com>
 <20181112154919.GB26341@piout.net>
 <201811130055486298716@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201811130055486298716@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 00:55:49+0800, long17.cool@163.com wrote:
> hello：
> The patch of 4/4 is not used for this modules,  this is my problem.
> 
> I have a question : 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16130,6 +16130,7 @@ M: Zoro Li <long17.cool@163.com>
> >  L: linux-rtc@vger.kernel.org
> >  S: Maintained
> >  F: drivers/rtc/rtc-sd3078.c
> > +F: Documentation/devicetree/bindings/rtc/rtc-sd3078.txt
> > 
> 
> There is no need to list this file here if it is only done to silence checkpatch.
> What does it mean?
> 
> I found that if I didn't add that statement, when I checkpatch,
>  I would get the following warning.
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16: 
> new file mode 100644
> Can I ignore this warning?
> 

Yes, you can.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
