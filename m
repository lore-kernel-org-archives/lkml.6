Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D02CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E643520865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeIJVUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:20:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40645 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeIJVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:20:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so41291727oig.7;
        Mon, 10 Sep 2018 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dLPamnj93PezHNQaCgjXEg7lt1JJ3s5ehNvM0T3gNv8=;
        b=Im/AfF6Hs3TvD0L2ct2aPpFRgBxD2ZCNsifnJLw4jVStynnPsPN7tDsNPhJkDn9FcN
         hxbG4viONZD/jPPsg4s8dINk6C9AZMcLgsMOnxZ9veJIKrCHSRG7YhPGX1w9s6MsD/DD
         81KRzIMOQvzNnK3j6v3xhSWoODu+qtEvhT3sWiSdjjgGMXX7GLTsB0gDz75xJMEoDd8W
         7Qs1mxMNYrJJ6Het60z39H4/6cVOiGiixc+t/55JTeXwUumgeR/OqrfC40QQoR044Spk
         HWp38YCqr4mVAvu48VTBpwdoy18u8b7K27NoKoYs2TLIXSkMbZyB25N0N+SNbqBynOKb
         n8Cg==
X-Gm-Message-State: APzg51D6m4lUhFrVOZKqLr9JOUb8qS31AYSehfB5qCBWteEq9JgSyxXy
        Vmalt911VdjqrnDavV5LyA==
X-Google-Smtp-Source: ANB0Vdb72rwTAXEy8cgphRWUBg5s5eKnwylcX4qJNgEvLs1lMeBele1Oym7F9BGbU80CHRpDrR+puw==
X-Received: by 2002:aca:6c4f:: with SMTP id h76-v6mr23361810oic.214.1536596751993;
        Mon, 10 Sep 2018 09:25:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 207-v6sm22834124oie.14.2018.09.10.09.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:25:50 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:25:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 1/9] dt-bindings: ata: ahci-platform: fix indentation
 of target-supply
Message-ID: <20180910162550.GA998@bogus>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903100201.23131-2-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903100201.23131-2-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:01:53PM +0200, Corentin Labbe wrote:
> This patch fix the indentation of target-supply's ':'.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please add acks/reviewed-bys when posting new versions.

Rob
