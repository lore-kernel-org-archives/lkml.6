Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED39C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28CB20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28CB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJMDLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:11:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36610 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:11:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so10723860oic.3;
        Fri, 12 Oct 2018 12:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+8ktc9b4TEtJkMAqOEOXgLPUjLLmilz7SbCnOHMk74=;
        b=IWUYNEwT7O6g2MQW8KaQzHDDs40OcNvK7OSdi/WWizJH426+4aiJepPwBBbGvdmPYA
         ydBOVeKQEXGeciFjf8T0XZ2toGuP+jy/9VsA86IqJTesL1Ae1ImszSd6pKYRL4Iwr2XC
         88ooDcbktzonTz52jwsvbrzgnpbX76liHgMsrRb7zotJGhtTc/YyHLDO+zLr0CYVogQ7
         WWAYdXa4P+/2ErQeGZhCW2CKkt6Eduqt5pApYrrFd7zCbpb780Kgal2wfajBKGsQnH+U
         TpxdeQfOeLo0mJ+eAGqTZfYta+rqLr9cR9tr29/ly5y65F7xJ80Zu0gbkdsdaJb22tsY
         u6IA==
X-Gm-Message-State: ABuFfoih9Jc3jbtSfV3/diGz1RiD+v+ioTMDiJyTbjiUtPjIInQ/2OSe
        w0NZnPRRf3Hb+Ubj5M/yVA==
X-Google-Smtp-Source: ACcGV62G3TArDrtqa5USWPm4pimexvnbENMSQz/pG0568qVI7qYeSaf6qaKmjG0SbB4PbrqThCwYhQ==
X-Received: by 2002:aca:fd89:: with SMTP id b131-v6mr3856418oii.30.1539373029263;
        Fri, 12 Oct 2018 12:37:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129-v6sm566636oia.21.2018.10.12.12.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:37:08 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:37:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>
Cc:     SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: omap: Add binding for Moxa
 UC-2101 open platform
Message-ID: <20181012193707.GA2531@bogus>
References: <20180928104739.30727-1-sz.lin@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928104739.30727-1-sz.lin@moxa.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 18:47:38 +0800, =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= wrote:
> Add devicetree binding for Moxa UC-2101 open platform
> 
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
