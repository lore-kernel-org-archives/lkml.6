Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77E55C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491920891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3491920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeFLWTe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:19:34 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33737 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934627AbeFLWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:19:33 -0400
Received: by mail-yb0-f196.google.com with SMTP id x36-v6so212701ybi.0;
        Tue, 12 Jun 2018 15:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bnby6qleb3PkE+apyLt4cBCU1ZhSwMa9VvBTiNrfmHo=;
        b=jJovuaDCAQT5jjgFrfjEKnizjlFbHVTSzrwinFSVaZ8Sqn9FCZ2fjHGyE05giHUF2v
         K3i2IMDsXY7/cKt6I7hd6EWFdiXjlrtQjLRRqHnOwuTBBdJG35qxeTvmknuvLZL9SHeE
         MXNJCaitI+17VJN7I1AXknU3WQIIQhfEezp1crl9ldenSPpHregvJrWg34y5VDz11C0J
         0tSTHNdb20MsdxjhYVJ9R7bix8P2koCqkQPz6V+eG/TeSxY7UFW0AckKT+mZnsV2xNDk
         ZlX5erDqIq8MOd9loD/j6YYB9jfVwVZ2niMj+UXbuDqvV6ti8yut7atQxx4/vaPMeifz
         moNQ==
X-Gm-Message-State: APt69E0tO5OX35bMbViTEo3JOlPxC2vkb1mvyS5DUVfuZKD5/cra6Xmv
        0cxRL2nBWqKhp2/d4LIuEg==
X-Google-Smtp-Source: ADUXVKKu10mi46e2Df+KAsqU7WJIm8+XcqJ/DfMwrfvPrXmMCNyBhmw304QvhjYBgAOqplKLm5OYZQ==
X-Received: by 2002:a25:bbd1:: with SMTP id c17-v6mr692859ybk.109.1528841972407;
        Tue, 12 Jun 2018 15:19:32 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 142-v6sm449587ywi.49.2018.06.12.15.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:19:31 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:19:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
        broonie@kernel.org, freeman.liu@spreadtrum.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Add Spreadtrum SC27XX efuse
 controller documentation
Message-ID: <20180612221930.GA678@rob-hp-laptop>
References: <0a5444dd0646f4e1f1d8ce51870afe6cc864219e.1528780670.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5444dd0646f4e1f1d8ce51870afe6cc864219e.1528780670.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:24:01PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27XX series
> PMICs efuse controller device.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/nvmem/sc27xx-efuse.txt     |   52 ++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt

Reviewed-by: Rob Herring <robh@kernel.org>

