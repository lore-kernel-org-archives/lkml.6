Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21839C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19120843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE19120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeIYVcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:32:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40773 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbeIYVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:32:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so1820317oib.7;
        Tue, 25 Sep 2018 08:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRJerkiXh55OKHZQeW/K57P/zQMWwWprSb0rEHrMCb8=;
        b=OUxMteC8kY9Tqhf/ppRkxoO+X60ips3c7/MNoi4eQmMeue5KGvQjvfBAUoU4deVMLC
         WOEKowP8wtJAYdE34KO/h0Iuqg4uWqrRAatbO9FdOmVHmS1s0IGWxfyDaYWB4gWhx22k
         2VAkXpFYkmbourqqDw8LDP1iglfTWNy7KcGcU+3BXHOWT+JQAa4KcMd4RY+psk23zPVI
         JJO8/oQeNWC0JdWdWnR81rSRuZCWezU9aMfmg/i592ZcBPpF7zHOJVnYg7VDaweLZTVj
         bmMsDa/MU3F6vVenHgU2tbgNm+DMcdQ9ajUmiUFiR0Tnzsy9KGIPpA7ChuuKpbjrxrNK
         Lmaw==
X-Gm-Message-State: ABuFfoj3ntwkwrQoNT6s7ZiFyCgjk1pWWbqvPtNcUaxvVgHwxYtm8Lcs
        D/v8qlojLVz+xp6DaT6hpg==
X-Google-Smtp-Source: ACcGV63c0wRnTXZeR8eti1dfuwZsPpIA14cWvBtqs5eijlO47UBY4TUtY79Hi5UexGVmQMIIc78oLA==
X-Received: by 2002:aca:5652:: with SMTP id k79-v6mr913294oib.296.1537889056783;
        Tue, 25 Sep 2018 08:24:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a3-v6sm903578otd.17.2018.09.25.08.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 08:24:16 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:24:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
Subject: Re: [PATCH v9 5/5] dt-bindings: media: Document bindings for venus
 firmware device
Message-ID: <20180925152415.GB21227@bogus>
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
 <1537314192-26892-6-git-send-email-vgarodia@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537314192-26892-6-git-send-email-vgarodia@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 05:13:12AM +0530, Vikash Garodia wrote:
> Add devicetree binding documentation for firmware loader for video
> hardware running on qualcomm chip.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,venus.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Something change in this? If not, then please add acks/reviewed-bys when 
posting new versions.

Rob
