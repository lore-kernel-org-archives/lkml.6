Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4CB21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4CB21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeI0Ey4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:54:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33313 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeI0Ey4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:54:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so567320oib.0;
        Wed, 26 Sep 2018 15:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtIRKtih8e5pLHvIpuZbARCRjAA9miPtBJZlPvmxt+c=;
        b=OfuvVcBY8EL+yqzR325Dc9gE240MhdIEZWQ7tnsncStx+lNgR3FOIr3Bch/F1t8KrZ
         4YqqcdqN4DNBhZBObpBOxUUvsSkbEj7lHWNQM1lPwe8O0EI24JUTUsQ4+Xx97gk3ux/a
         bXG7sOcRy8cUakKJdVssHnsW8MMPIEk64yAxmKIZ07jSxuXO+ijqP99PBS4b+SixrxzX
         lUP0PO15ntox8G3lNUMhitV/jjTAfNFlHxHYjQN1Bp4OziiLWCyQrBKd7GZxIjPAnDOT
         cFoj1+zF41SoZII4tC4pjBvzbG/USHSqzavgAckMRoGYvtHszAxnbtolFQFT08rmAbD9
         OLdA==
X-Gm-Message-State: ABuFfoj3JndyIrWuUXoDlCIIxITiNSPygvQycMW/KGvdWkM2tNtrWv7e
        tNlS/1OnyP/hK7Tpfi15ug==
X-Google-Smtp-Source: ACcGV60v53WDGynlNLYvpKomfwrSn3I9djDr95Qh60dK4/w4PFYeTva1gdU80EzGbazZSmG+CJD/Ug==
X-Received: by 2002:aca:c689:: with SMTP id w131-v6mr1972166oif.152.1538001585557;
        Wed, 26 Sep 2018 15:39:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q38-v6sm166417otc.46.2018.09.26.15.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:39:44 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:39:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: arizona: Correct link for sound binding document
Message-ID: <20180926223944.GA30051@bogus>
References: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:33:22PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
