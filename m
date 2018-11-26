Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6478C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD0D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeK0Il6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:41:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46705 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeK0Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:41:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so17331563oif.13;
        Mon, 26 Nov 2018 13:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SZ+vTotyFyuWTvSfSwlZ+iCTw1Yda/AWHj/lJeG8OI=;
        b=MsoVScrSuUwYdN9+uaZsMOTe9AGWuTalfdDkpzUCGEN+WQ4hxSsQlViDlJmOHXXeqH
         NfNOFN/FtlZqCR8bgKcUQ12p1+xblYyLZB8Dh/8ZGApcoXB1sYy68NcMMbpRnK4DJl0B
         DZx5OcH5wzZprWggvcXXfyJvMkujzARgz+DgCiCBHd3d6H4g2XEnEoLOJFUyGCXf6tVY
         XdNnqq7MzFoTlTZGvsMeDGfrciNZtyqA79cC8lWTZ49kEZ1E+/2S4wHQqxQfv4YuPjo/
         GCehPYp8WuKlu+Q/2YVZHv77wWhekFF0POcynRXIDJC2Pux4Y9jhBenphTkzGpaI23bq
         V3Rg==
X-Gm-Message-State: AA+aEWb0ITE2QbcNlH8Kbz7FSt4qadmri3oj0XCuiQhBmeqTjrELDHcg
        OfjSDW24E/COk+EJCabbdQ==
X-Google-Smtp-Source: AFSGD/V1F8bNYB1X6KEu6IyQ5bwIAk1V41Eg5xYqvGK9DsIoUMUFC1856AukGpbEgOt2BA/YRrK4HQ==
X-Received: by 2002:aca:4489:: with SMTP id r131mr9352498oia.296.1543268787321;
        Mon, 26 Nov 2018 13:46:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 187sm2049348oic.12.2018.11.26.13.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 13:46:26 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:46:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     biao huang <biao.huang@mediatek.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181126214626.GA13830@bogus>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
 <20181122151932.GD15403@lunn.ch>
 <1542936676.24219.66.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542936676.24219.66.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:31:16AM +0800, biao huang wrote:
> Dear Andrew,
> 
> 	Thanks for you remind.
> 
> 	Sincerely, I respect any comment from any reviewer. If I didn't reply
> for any comment, really sorry for that.
> 
> 	As to this "tx-delay" issue, the following reply in v3 maybe ignored.
> 	https://lkml.org/lkml/2018/11/19/158
> 
> 	"the delay time in mediatek dwmac design is not so accurate,
> 	the current mt2712 and the following ICs will not use the
> 	same delay design, but will use stages to indicate different
> 	delay time.
> 	so maybe "mediatek.tx-delay" represent the delay stage is a
> 	good choice"
> 
> 	And to make it clearer here.
> 
> 	In mt2712, there are two delay macro circuit: named fine-tune and
> coarse-tune.
> 	a. fine-tune, 170+/-50ps per stage, total 32 stages
> 	b. coarse-tune, 0.55+/-0.2ns per stage, total 32 stages
> 	If we only consider mt2712, delay in fine-tune select a integer
> multiple of 170ps, delay in coarse-tune select a integer multiple of
> 550ps, for stage 0~31, the delay in fine-tune will not have the same
> value with that in coarse-tune.
> 	OK, It seems the property "fine-tune" can be eliminated .
> 
> 	But the following ic will not have the same accuracy as mt2712,
> and maybe will not have two delay macro circuit to be selected.

New IC will have new compatible string then. If it is different, then 
likely these properties would have to change or have different meaning 
unless you use time.

> 	1. assume two delay macro circuit in the following ic,
> 	fine-tune, 100ps per stage, coarse-tune, 0.55ns per stage,
> 	if we want delay 2.2ns, fine-tune will get a 22, and coarse-tune get a
> 4. We can't distinguish which delay macro we are choosing.

Why wouldn't you just choose fine-tune for anything less than the max 
range (3200ps in this example) and course for greater than 3100ps.

> 	2. assume only one delay macro circuit is used, a similar case as 1
> will also increase the complexity of driver.
> 	Then, we need define more flag property to know which delay macro we
> are handling.
> 
> 	The common things for all delay macro circuit in MediaTek mac design is
> the stages, not the accuracy. so if we maintain stage info in "mediatek,
> tx-delay", we only need care which stage we should choose.
> And for each IC, we will recommend a best stage as a candidate.

What if you had a 3rd delay circuit?

> 	Above is my personal opinion, may be my understanding is wrong,
> welcome for further discussion.
> 
> 	Thanks a lot.
