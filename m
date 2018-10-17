Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DDECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73072150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73072150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJQXiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:38:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33693 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeJQXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:38:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so26671959otd.0;
        Wed, 17 Oct 2018 08:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NtzvfJg/BONVTnNlFrUkQAhk6b6lrZIFvsF7G9ksNM8=;
        b=mpouo5ZVhQYzWSyExfVnK5EuWYJx4qLFsOtODN9mBXycEAajahXiFRFxGKVldEBHjn
         0ul9NEoIWa2CDPQmaUuSkQPP0HVci3J2un2yUQS+YjGpzZJp84UmQsxFX7SrJfQj+6jT
         VIw5TqYj/Kk9xkvOvXyj4Plm4RdQ9s46UTucTmmsRsm5LFK+zG6RVVYT1ngUxJ9nBB1C
         bxHEDv4ITq/G280v/nveuABPN5urDBcwuViAdV8Ec17mNR5bkBsjH3hKG0pi5UZvOFqc
         uSkegvhorxy+/DtAfPE2HvGOpw7RscjLnqWJEejB0LNQAO6CNHSxXwQ69neVA/AwCSnP
         nFtw==
X-Gm-Message-State: ABuFfoiurvch4nsa7SSay2Hc2DkUJn9M4fKstErbOdvfQCiK+o0tFUeP
        HovaSZoS+UuRTVQ/7ngRDw==
X-Google-Smtp-Source: ACcGV61CGMRVpvWU5TUZ4KMK8AtERQFMBTmmdmdYeK6pEn/kCL+NnowNYyD1VBCIL3KlYYODLzTdAg==
X-Received: by 2002:a9d:3a21:: with SMTP id j30mr14513043otc.237.1539790915104;
        Wed, 17 Oct 2018 08:41:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x15sm5777848oth.24.2018.10.17.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:41:54 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:41:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 10/11] dt-bindings: net: ti: deprecate cpsw-phy-sel
 bindings
Message-ID: <20181017154153.GA21670@bogus>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-11-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-11-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 18:49:48 -0500, Grygorii Strashko wrote:
> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
> deprecate cpsw-phy-sel bindings.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
