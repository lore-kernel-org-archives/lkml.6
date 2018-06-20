Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09601C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF44120693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF44120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754794AbeFTTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:16:40 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41005 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeFTTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:16:38 -0400
Received: by mail-yw0-f196.google.com with SMTP id s201-v6so242142ywg.8;
        Wed, 20 Jun 2018 12:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QzO8+aFbZaWJz7SEBmnuJKvX0njO/x9RkE8Fb1iNG4M=;
        b=YzxFIvhV9ae6YN0kcykl1ZGe5kwpseFDE/10+jl6gYmHo6Se++76dLN+1dUBlBgYMh
         S4PxLP8zLB8IeY1iqYhyijiMmlU6BzyxId3SIxaBIAf/zTwwv7NBpO41EKaEKKRKINx8
         Kvwezy7JdDTziJTcF2+m9v2BEkZ3zmVly5IMN4UL6DpkvdT9ednygKKwSSX2jabU5Ec3
         Go5sVdRhTglGF6rRZb/3z0TBLYkyDqmalx1OShHqkx7ywmSZU5p5w04qMC0EPhvINr6b
         hI6cH/D1ovNavl3yYz9Ul/UM/KBskNDs8XOW1ibqms+jUQ9qxyWz40FbF+fYm4QqCBtI
         DZ7w==
X-Gm-Message-State: APt69E28hwNHEKrPkGLA6JlR48lAyVfutU4Zd05Mp1YOVVcVFBqMrLKa
        cAqkAVwNInKYT1jD2MINgw==
X-Google-Smtp-Source: ADUXVKJxNmKIbxqo4K3WxCPkLs2CM2Y18V0pI1mCniPWSWEXJIod2hmCE/uOIigrJ2nWtU9eWvCCRQ==
X-Received: by 2002:a0d:d957:: with SMTP id b84-v6mr10431275ywe.257.1529522198256;
        Wed, 20 Jun 2018 12:16:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d7-v6sm1248135ywb.99.2018.06.20.12.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:16:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:16:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 16/27] dt-bindings: display: sun4i-drm: Add R40 mixer
 compatibles
Message-ID: <20180620191636.GA6106@rob-hp-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-17-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-17-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:00:25PM +0200, Jernej Skrabec wrote:
> R40 DE2 mixers are similar to those found in A83T, except it needs
> different clock settings.
> 
> Add a compatibles for them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

