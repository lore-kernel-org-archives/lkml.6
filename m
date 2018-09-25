Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2984C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D08D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D08D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeIYVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:31:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42286 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbeIYVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:31:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so1821494oif.9;
        Tue, 25 Sep 2018 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TmtAubfClAz3y1EyHdu9gHhM/cKHlYBwmotmVIop8Dg=;
        b=qUgsWCqw+CfFD9AHzX9+P3WSg+fm5MHdH2iiupoY+a8RzpvtkFty1WcjSfJaoA0Iy+
         8EPJDFJNUNT14T3dzdKIFk4imI+4ZRY/J3gJys4wjfhdwtShDWHkL0RS++CJ8VsjQCP3
         GpLt0AaiE+v+8/wuSSgmtFyln0pfo8AdDWjzEranI5ZKXOY2C2uMHxughvTWnU0CCaXr
         R2YR8JF3jVwHdQogdMXV5Pd1O2LACs+Ta0W9Q2PwNvEx/DFfAShu81RIHD78LQSugpzn
         2veYmPXztsbGjUNtY7HFzHs9HaO/1dMK7U4xvPUsK/Kr2y6sCjgNvT/NLsrSt0EAgM6W
         pWTw==
X-Gm-Message-State: ABuFfoir43F2CVEpDC3+rMoOC377ONlqth8vXw8D5iCyG4Dj18wR7idT
        xD3ojvqzvqRWiQYBu7KFZB8jTtO0dg==
X-Google-Smtp-Source: ACcGV60QkqTV/LoRSfCd23GCyhkHk1m7awZ3GMa0HBVr0k43n35/wtvrQGMeiwCtW5rIQfNEM2qlZg==
X-Received: by 2002:aca:3e56:: with SMTP id l83-v6mr932788oia.170.1537888990153;
        Tue, 25 Sep 2018 08:23:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p185-v6sm842779oic.18.2018.09.25.08.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 08:23:09 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:23:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Brian Dodge <bdodge09@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: arc vendor prefix
Message-ID: <20180925152308.GA21227@bogus>
References: <527da392-9629-792b-08cc-970ffc8173ee@gmail.com>
 <20180920130952.7eb8e45c@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920130952.7eb8e45c@alans-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:09:52PM +0100, Alan Cox wrote:
> On Tue, 18 Sep 2018 21:05:20 -0400
> Brian Dodge <bdodge09@gmail.com> wrote:
> 
> > Hi,
> > 
> > In the linux kernel commit 91ab076e3a2f092254fe5231bbfa92b37fd52e38 the 
> > vendor prefix "arctic" was added to vendor-prefixes.txt.
> > 
> > The original change I authored used "arc" not "arctic", and the device 
> > tree bindings were added assuming that prefix in commit 
> > ce9d22573d85341c987f997461ac712e4dbe47b1
> > 
> > Perhaps odeju changed the name to arctic in the patch after I created it 
> > and before it was approved.
> > 
> > This pairing isn't really compatible is it?  Either the prefix should be 
> > reverted to "arc" or the bindings (and driver source) changed to use 
> > "arctic", as in "arctic,arc2c0608" vs. "arc,arc2c0608"
> 
> ARC is a Synopsys registered trademark for the ARC processor line. I'm not
> sure what the right answer is but I think it might be better to keep to
> arctic to avoid confusion with arc based products.

Agreed.

Rob
