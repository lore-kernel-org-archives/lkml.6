Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BD95FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E09208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E09208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeFLVoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:44:37 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39084 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeFLVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:44:35 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so172883ywb.6;
        Tue, 12 Jun 2018 14:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fxNalv5f5Hs21C+Rp455uSOBSxThLazOyNrcY49/5ZQ=;
        b=O4cy2nVJDq1z866i67CtFRPQATz8GRD1rHE9Xt7GjfYHIrIKpeYu2kBitXr2gh2+qr
         hwTneZht9Vgc9t61r8hJuc0cWwQnlEEGJk1RHfVwx4KLKvNh4PDu+fQ9u3ICnD7xkpoS
         7ELZZy60Rzu9WB6YpB+MwrRS7CW31l8kXu8guKLUkKFelw5lUZdzI18SHzC1LUnHvBbj
         storHz2lf+8XKXj99MkexlxNE4/ss/8sV3jcQIVhDIocG+f7BmGHnFacQav7B9xSXEWU
         TYIOJptj80utOGlWCGyA7xiL3y3wqTNeJenu0y0rIEjpJPiY/2n3hx2ImR1OCSjx3Kc4
         mJ2Q==
X-Gm-Message-State: APt69E12KkYpPYLJBPDkS2c2mgSr+MTVNocLsgQWvfzq8YOYi872zrIW
        wGztFOM5ThxZvphUhhZq2ssVmHk=
X-Google-Smtp-Source: ADUXVKKJbmeO3sndllwu1AQi+sIc3V8oMlbnJ58Ce+o+CTxz03q6LvstyBydoT2a3XND1ZqC96Ix1Q==
X-Received: by 2002:a81:ad44:: with SMTP id l4-v6mr1149668ywk.68.1528839875019;
        Tue, 12 Jun 2018 14:44:35 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j191-v6sm446237ywg.43.2018.06.12.14.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:44:34 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:44:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add bindings for
 r8a77990
Message-ID: <20180612214433.GA28082@rob-hp-laptop>
References: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528267348-18960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:42:28PM +0900, Yoshihiro Shimoda wrote:
> This patch adds suuport for r8a77990 (R-Car E3).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
