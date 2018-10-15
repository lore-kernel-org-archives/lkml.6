Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843432089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843432089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJPARQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:17:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35633 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJPARQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:17:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id 14so15506335oth.2;
        Mon, 15 Oct 2018 09:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiaoKbg7fEGJC2lw+DdaVqPMtTyrICo+DtWL8zXrzzE=;
        b=Hi9ZNgkBGwoiLxIr++iCR0YTwXQ3D40Oj7hitmKvR48ZwooKKfBhldjXvFr9P2va1V
         MrrmoreKkWkqPSky5KG493Syvajf0yVsTH4Ho69ARWsXYQthnoBwMTmdMzrlvRYj0DOl
         JZXLB6IXm+n2S1aXm7rDLFPTdp0E1S3UnUAIXG4VdqHiNlJoeBtUub4UegiB5TK8Oo3n
         vqbHcgu/tls3nPcweaz6kaazpRQsLH0rOJgsFO1hVr9TPm1sZ3ImqUAU4jVPBH/K1EiS
         D2xrookgy3LyMOHzLJdTxRjuIHG8rUTUu9YnmFuvpfS6noq4BnUaq91aJ+QHELp7mleR
         39Cw==
X-Gm-Message-State: ABuFfohJD3ctnJtxV8PDkfkdTgIFLDHHZwOOxcbSdyTpE6TEuuJ6DvrB
        p60Se4ZP3L7hyeWpeKI/hQ==
X-Google-Smtp-Source: ACcGV62hbfh3cmm3/k8aoQcIFFjJ8OskWzJI32O6C6XXMJHLPzeYk8YWY4A0VwEEoTuScin1JspHhA==
X-Received: by 2002:a9d:5b66:: with SMTP id e35mr11870468otj.206.1539621077548;
        Mon, 15 Oct 2018 09:31:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x78-v6sm3191354oif.50.2018.10.15.09.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:31:16 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:31:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/HISILICON SOC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the
 tsensors
Message-ID: <20181015163115.GA25282@bogus>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:03:08AM +0200, Daniel Lezcano wrote:
> Add the missing interrupts for the temperature sensors as well as
> their names.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--

Combine this and the previous binding change to 1 patch.

>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)

And more checkpatch whitespace errors in this.
