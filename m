Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE3CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460242084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460242084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeGST2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:28:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35226 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbeGST2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:28:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so4034522plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 11:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaPzPQNE/9UUKdVdTFk8NeMtafRlZgBVGcZlebq/sNo=;
        b=VVVoNxIhhy2IGc2VtMXhJu+io/aOzzKz4y0FUOotbX9kvV1+gNea++3Gzb5XBB1blL
         hED05HH64KwlZ2/y3JvcOMvdsEGSsAIXfNHwey6Scu08JwWqVGnJq/8F2pLEJmviWxPt
         T9odNpvyuyz93AGfM+4c1915lWkdvt91rLKMYialsD9QqeNMAlxh7WUKBiDD/f7Uzgml
         wylGCU27HVc9sp+5O+ZQ8UUfHqyWZLQCEytbxDJ+1ReiEdmjT0tCMb+jAcIPYLl7DEm1
         kMBgSkwYZtnwoZNOxHTUjnHY9brqmsEhGIoKN78rRJeLXDgxIULMVXT2aDxc2xojUbfr
         /M+g==
X-Gm-Message-State: AOUpUlE4K/53iqbGFAvwhiXMc/nwQodUMIMxIff8l7idVEW8zTTQo02g
        mBgevyo8sqEszF3/q0RHQqN3DA==
X-Google-Smtp-Source: AAOMgpchwrrJkSg3J5IjlXEg22vm/UQ56oIf+DtKiNHamvYY9zE5pq+nyAcYa7CtgumKOy/sByBB0Q==
X-Received: by 2002:a17:902:d90f:: with SMTP id c15-v6mr11062756plz.65.1532025828879;
        Thu, 19 Jul 2018 11:43:48 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id z4-v6sm18433577pfl.11.2018.07.19.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:43:48 -0700 (PDT)
Date:   Thu, 19 Jul 2018 11:43:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drivers: fpga: fix two trivial spelling mistakes
Message-ID: <20180719184347.GA8465@archbook>
References: <20180718072526.25378-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718072526.25378-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:25:26AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to two spelling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> V2: Fix spelling mistakes in the commit message.
> 
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 2 +-
>  drivers/fpga/dfl-fme-mgr.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 0e81d33af856..025aba3ea76c 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -70,7 +70,7 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
>  	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
>  		incr ? '+' : '-', npages << PAGE_SHIFT,
>  		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -		ret ? "- execeeded" : "");
> +		ret ? "- exceeded" : "");
>  
>  	up_write(&current->mm->mmap_sem);
>  
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  		}
>  
>  		if (count < 4) {
> -			dev_err(dev, "Invaild PR bitstream size\n");
> +			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 
Thanks,

Moritz
