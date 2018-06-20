Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AC720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AC720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeFTTP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:15:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33546 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbeFTTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:15:55 -0400
Received: by mail-yw0-f194.google.com with SMTP id u124-v6so251977ywg.0;
        Wed, 20 Jun 2018 12:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hLf8LGDPhCmj7jxokpFyPoQnzdVFJMzEN9a1PAJaVU=;
        b=c399IvWc3q/xVWTWdPQRpJrAGchkCaCm+f6BfztpZCp5c4DGdrfhJPpOOtfVyFGUZK
         CNmwOOQm18hONkCs5Rq+KtpWvFMlOqeOa3jS8C7fahSmMIgZP/Or88/ouSN4pWpHX+KW
         v3IaEs3jM5gzsSVd2R/b+8uJkPl8dD9UcwtqlxvYyuXWcrzHWqc5SqQtupDpdwh3WF0k
         8rZL5Aa79PN+at7sQTwaiq1Gt8rcQmTVQxjiSj7/B4SJmgxR5inuHC3Ru7TJTkJF8iEm
         8xPudB5DMUt1Sc12rSEpEzz5GSVLCiY0s/ZS4XKS1uMkRVj04Ep7HZA5HyT7P5DiWO1I
         64hg==
X-Gm-Message-State: APt69E0OFEMeVC5M/eUF41h3zikvntPlWZmmSP2J3bU2c3vx9W8TAGc5
        r7XmjqlNX0K5k6kDLNXFvw==
X-Google-Smtp-Source: ADUXVKIywasibdPRefsnq6KS0h1qYhvnuo2EoL9CXUqAAmcgREkKNAaRWlR4P5J5YY+xgEoPz4OixQ==
X-Received: by 2002:a81:4b57:: with SMTP id y84-v6mr10746493ywa.35.1529522154939;
        Wed, 20 Jun 2018 12:15:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 83-v6sm1158519ywm.108.2018.06.20.12.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:15:54 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:15:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/27] dt-bindings: display: sun4i-drm: Add R40 TV
 TCON description
Message-ID: <20180620191553.GA5151@rob-hp-laptop>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-11-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-11-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:00:19PM +0200, Jernej Skrabec wrote:
> TCON description is expanded with R40 TV TCON compatibles. TV TCONs,
> which are connected to TCON TOP muxes, such as those on R40 SoC, also
> needs additional clock gate to be specified.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
