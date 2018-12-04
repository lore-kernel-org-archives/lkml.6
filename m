Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188292082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188292082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLDAEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:04:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37996 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLDAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:04:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73472207AD; Tue,  4 Dec 2018 01:04:41 +0100 (CET)
Received: from localhost (lputeaux-656-1-51-242.w82-127.abo.wanadoo.fr [82.127.57.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4784F20701;
        Tue,  4 Dec 2018 01:04:41 +0100 (CET)
Date:   Tue, 4 Dec 2018 01:04:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: Move trivial RTCs to rtc.txt
Message-ID: <20181204000441.GQ8952@piout.net>
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
 <20181111193114.24307-2-alexandre.belloni@bootlin.com>
 <20181203234558.GA10722@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203234558.GA10722@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 17:45:58-0600, Rob Herring wrote:
> On Sun, Nov 11, 2018 at 08:31:14PM +0100, Alexandre Belloni wrote:
> > Move trivial RTCs to the rtc generic binding documentation as they all also
> > support at least 'start-year'.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc.txt | 34 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.txt   | 24 -------------
> >  2 files changed, 34 insertions(+), 24 deletions(-)
> 
> Okay if I take these 2 to avoid conflicts with trivial-devices.txt?
> 

Sure, I was actually planning for them to go through your tree for this
reason.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
