Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DABC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308A2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8308A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJLX7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:59:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46956 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbeJLX7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:59:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so10286425oia.13;
        Fri, 12 Oct 2018 09:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+S7OtCrHtaGyH/mY1Vf4DWtogNFs+gISj6iS4xUTVk=;
        b=MCHkOWAj3g0cwdeHGrt/wdap63D9zA7Rt+yFk9TN0V3wjmAsjr5mlY16j6RqsIEFGY
         b9PZCo54qU4fuqR5fcsA5ZfHY8/E81zAsPyfTKIM0lpyTaJ4f1Jbbt6x1uaSd5ZZhiXX
         zz1Ugp4JTwyEdCY45XHTgnGbAt8AtFwrbORmwhHqPCR3gz0nHzcwPOXPfY6FRrlZ7deI
         +qvY16LO6MPcbiE83JOg9OjA6mCcEzsb3zm6EsybdN/e+xwiYCa26NiLD6/nJAVm2ch+
         z/WMnMQxqAZ1Ae13rZ/N6NNcOmxyB8KEZi7S/Y/6fPYNSl18+5RHf4bF90VqPMpGhdyS
         r/Dw==
X-Gm-Message-State: ABuFfohycGB6j/DglejBeI4b+Gqo1fBNSFtuvoXjj8lkMf6pTYkRbBBN
        FNTcPg2lHFbPePNtxBm4CQ==
X-Google-Smtp-Source: ACcGV61uwrHmkoNWOf3k4JdAiMv5GxHRcE61r+QQ5+x9WmuelSD6XdO31tw4J4zFbXDDdCREA8jqUg==
X-Received: by 2002:aca:785:: with SMTP id 127-v6mr3750159oih.127.1539361580945;
        Fri, 12 Oct 2018 09:26:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y42sm478309oty.5.2018.10.12.09.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:26:20 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:26:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        lee.jones@linaro.org, tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181012162619.GA28573@bogus>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com>
 <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:38:53PM +0200, Jacek Anaszewski wrote:
> On 10/11/2018 08:34 PM, Dan Murphy wrote:
> > Pavel
> > 
> > On 10/11/2018 01:27 PM, Pavel Machek wrote:
> >> On Thu 2018-10-11 11:51:16, Dan Murphy wrote:
> >>> Remove support for the LM3697 LED device
> >>> from the ti-lmu.  The LM3697 will be supported
> >>> via a stand alone LED driver.
> >>>
> >>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >>
> >> NAK.
> > 
> > Thanks for the NAK.
> > 
> > This NAK was NAK'd by other maintainer in the V2 RFC patchset
> > 
> > https://lore.kernel.org/patchwork/patch/993171/
> 
> I confirm. LM3697 is a standalone device and not a cell of any
> MFD device.
> 
> Waiting for DT maintainer's ack.

You all sort out what you want... I can't follow it all, and I'm not 
going to spend the time trying to figure out what is going on here.

As this is worded, changing the driver is a Linux problem and irrelevant 
to the binding. Now if you want to move documentation to a location that 
makes more sense, then fine. But structure patches that way and make it 
clear that from an binding ABI perspective, nothing is changing.

Rob
