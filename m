Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2CFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2E02083E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2E02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGPQCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:02:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42973 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:02:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so75564169oib.9;
        Mon, 16 Jul 2018 08:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oop0UZ8M9F/TCr442bJHE1NGgZgQ+hLD3pVnQ7Ts8T0=;
        b=ZIwPwnoe6iAoKbX4V+8wtlSfQ2Yb+Nrbow2U9jGKxCJ5mBxYhoJ+kPC/dopBgvS/WY
         Ws/WPUGJNPjzuAePpU1UdkhhBdjpFrFMcZ33NuLdqZ4p74ImxQPiMUd21cGFaHKYCw8J
         yghpmqKKURoOMcdKxr+7kqq06rVKqY4VTo1MxYo1mQKM7IRVr7313ArC0XkrBnEW9t+t
         TX0XkKt9ayTgNhiXtbFtpdefLS+wq0sQnUM3ckksai9hY0xVX6NpV99oc5d8HS78D/1O
         E9OyE1JVaAH0lt3y8aSYf3d47IEBM8JTNU4V09HnsduwrlK3PCRFby/e12DJmXVrBSFR
         meUg==
X-Gm-Message-State: AOUpUlFC19X2iZROZpulID009EjPzWPn3OEu7AlJrLs4Un1yQ1KvJ2eR
        Af2FXRYVO/ch4zsqvrWRaQ==
X-Google-Smtp-Source: AAOMgpeLTweaLOJIbtjREotsBKQ6Mp1mdw3SSPpWQxOtdwk/lyGjH0/f91thOqmecFWqmXNuVm63ww==
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr19645355oie.322.1531755243419;
        Mon, 16 Jul 2018 08:34:03 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p132-v6sm9367636oia.31.2018.07.16.08.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:34:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:34:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: xilinx: zynq: Sort entries
 alphabetically
Message-ID: <20180716153402.GA14804@rob-hp-laptop>
References: <20180712041024.20583-1-luaraneda@gmail.com>
 <20180712041024.20583-5-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712041024.20583-5-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:10:22AM -0400, Luis Araneda wrote:
> Sort additional compatible strings (boards) alphabetically
> by their manufacturer and model number
> 
> This will help when finding a board because they
> will be grouped by their manufacturer
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/xilinx.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

