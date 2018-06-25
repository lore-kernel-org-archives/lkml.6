Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A21FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77FA25D9B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77FA25D9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeFYQAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:00:03 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40207 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeFYQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:00:01 -0400
Received: by mail-yw0-f195.google.com with SMTP id p129-v6so4941917ywg.7;
        Mon, 25 Jun 2018 09:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKUd4On5AdPB92Sv/2n8eT5mkUq0bdarrgIEnSVDZnk=;
        b=oKR+/Jdt1oPx+2mNSEPoRNkEYZT2m2OQqFoBs+W/zvvdmxopz1bIvp158ZzkXvMZYv
         cYThGEjW8f6dxkVsd5DxqZ4UDywYnbFCGs8UCT0DfWBVa+dEkpyvBYLnFPR0XI3IJtCD
         PPl+Yav8FWN7/epFpxVBDwPvGG8FtXvwPb2EyF1Fya1lYjcv2DaI57QzuU4ZGMavf9jb
         GxRO9RQZcChvNiF8c4tZwX1Ye8QJ68jFIqcItjyHQctAYNM6L9N9LEr63PkQe116oCMx
         I4Pjqnj0aYvmqyTsu36GQKcuW6T9N6roZb+PcJkeaQKCp9hESu59++3DqCWWwhfCTIom
         5Nog==
X-Gm-Message-State: APt69E0QwhQXkOd9ozkj09uS1E47MOqgOmos7ljDDF0/tFnV7VHHdxU1
        KPfZUz6KW8G7ISRzmM/Ang==
X-Google-Smtp-Source: ADUXVKKVvhDiHWRgeSel5w15gd/wt4lVlr4w8x/YBB9jHCJ9l9mO/cyCnhzofmsBOrZvUSJ0xrDmWQ==
X-Received: by 2002:a81:3a03:: with SMTP id h3-v6mr5890484ywa.266.1529942401158;
        Mon, 25 Jun 2018 09:00:01 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b190-v6sm4281105ywf.16.2018.06.25.08.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 09:00:00 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:59:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/5] dt-binding: mtd: denali_dt: document clock
 property
Message-ID: <20180625155959.GA2820@rob-hp-laptop>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
 <1529683598-25783-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529683598-25783-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 01:06:36AM +0900, Masahiro Yamada wrote:
> Commit 30f9f2fb7ba0 ("mtd: denali: add a DT driver") supported the
> clock enablement, but did not document it in the DT binding.
> 
> In addition to the existing clock, this commit adds more clocks based
> on the IP specification.
> 
> According to the Denali User's Guide, this IP needs three clocks:
> 
>  - clk: controller core clock
> 
>  - clk_x: bus interface clock
> 
>  - ecc_clk: clock at which ECC circuitry is run
> 
> The driver should accept the current single clock for the backward
> compatibility, but the DT binding should represent the real hardware,
> and future platforms must follow this.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v4:
>   - split into a separate patch
> 
> 
>  Documentation/devicetree/bindings/mtd/denali-nand.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
