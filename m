Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2635DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B6C208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B6C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935753AbeFMNvB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:51:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46682 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935693AbeFMNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:50:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id h79-v6so2358650oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1Odggdann0fG50TU9NBrNwkypfQxuEWXidzD+HSBBY=;
        b=j66Uys9FkcKH+Qa9mjSi5q4voMoc8BLmAO3v9ulF0flJ5+IwUl8UuDYZHi2cV+8ydE
         BKeq/urmPuHekPslnRsvUKKNds/lM2zfU3eKHCb7KuUToJXgeRGSDVM49z6IB6u4FX+S
         E26a4OTlJReYcNTvZklcEWdIZTd7sxCduRQktEYrNr6o7D8Zt8Fh1tj6PduoBluzGDR4
         91xS4PGVgWWUwpo+8Hy/xWCN76cousoN/STtpp/YIpHKRqE4FurrCZRiUSnM/AZg4YOZ
         6ABWTDx4lPlBiDs5kfDvUGkTXnVy4L2/JAkwl+mTOGxOoKN24Ko8fSl73m874lF44ytW
         L8wg==
X-Gm-Message-State: APt69E0Gn+0jJL3hRDaE0xYG+r4xe6YbwyCI3grSOlLbAsCSmGYTzHiC
        znk70/9Lr9HGlLqzjUHhCzNosg==
X-Google-Smtp-Source: ADUXVKKkJtVV0gVg22Wc86M4qfd4/4DeyC3auXg5XB9oEnei8KMT3a5DcEQcSxEUYxj4iqKIaqtB2w==
X-Received: by 2002:a54:4e10:: with SMTP id a16-v6mr4639580oiy.25.1528897858060;
        Wed, 13 Jun 2018 06:50:58 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id k19-v6sm2194181ote.0.2018.06.13.06.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:50:56 -0700 (PDT)
Date:   Wed, 13 Jun 2018 06:50:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH v6 29/29] MAINTAINERS: add entry for FPGA DFL drivers
Message-ID: <20180613135055.GA3866@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-30-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-30-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:43PM +0800, Wu Hao wrote:
> Add entry for FPGA Device Feature List (DFL) drivers.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448957c..98fc5ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5619,6 +5619,14 @@ F:	drivers/fpga/
>  F:	include/linux/fpga/
>  W:	http://www.rocketboards.org
>  
> +FPGA DFL DRIVERS
> +M:	Wu Hao <hao.wu@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/fpga/dfl.txt
> +F:	include/uapi/linux/fpga-dfl.h
> +F:	drivers/fpga/dfl*
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  W:	http://floatingpoint.sourceforge.net/emulator/index.html
> -- 
> 1.8.3.1
> 

Thanks,
Moritz
