Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7832084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz2yF8TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7832084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeGSQOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbeGSQOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:14:47 -0400
Received: from mail-yb0-f180.google.com (mail-yb0-f180.google.com [209.85.213.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2281620863;
        Thu, 19 Jul 2018 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532014265;
        bh=bFqxLR1Kdfry5I5BzaQgR2RhEXZhKMBBTWL5Eq0ybcQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Dz2yF8TQvFv8KPNLTQYEtotd8IQhTXtq+saR4e3oqn8JwZIi58VCdd6CvUj9XPd7z
         LWqx2BiAQ28dHql+7GGOFwB+T0QdtUz4OOHEF6EuTgB2cN0g8MLfBIOoTCW3l/j8UY
         gKF1/MCS0vhaUik5hfk2DRw8/AGlVy5Mpk+fBQ8o=
Received: by mail-yb0-f180.google.com with SMTP id h127-v6so3408059ybg.12;
        Thu, 19 Jul 2018 08:31:05 -0700 (PDT)
X-Gm-Message-State: AOUpUlFCb4YuTHnG7B6gXoODooJRBaKTNOlx/WzWlgvM9GuqW1KxyToP
        FimpvO4YSfbzd1gh6IqKlK2+puJVfyYKII0ZtA0=
X-Google-Smtp-Source: AAOMgpd1hIqxR7nWGqgzt0CQ5nb20oY4JyP9N3jxnsc5dt2gkoAFlR3dTdpv6ogXMuS4aE1/C6xrjs4086TG8s6zLXs=
X-Received: by 2002:a25:2102:: with SMTP id h2-v6mr5699336ybh.31.1532014264343;
 Thu, 19 Jul 2018 08:31:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:30:23
 -0700 (PDT)
In-Reply-To: <20180718072526.25378-1-colin.king@canonical.com>
References: <20180718072526.25378-1-colin.king@canonical.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 19 Jul 2018 10:30:23 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ1CO5_D7nspi8W8Vd8-2kPKXCCUeHBf-ZhfvktboLOqA@mail.gmail.com>
Message-ID: <CANk1AXQ1CO5_D7nspi8W8Vd8-2kPKXCCUeHBf-ZhfvktboLOqA@mail.gmail.com>
Subject: Re: [PATCH][V2] drivers: fpga: fix two trivial spelling mistakes
To:     Colin King <colin.king@canonical.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:25 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to two spelling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Tull <atull@kernel.org>

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
>         dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
>                 incr ? '+' : '-', npages << PAGE_SHIFT,
>                 current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> -               ret ? "- execeeded" : "");
> +               ret ? "- exceeded" : "");
>
>         up_write(&current->mm->mmap_sem);
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>                 }
>
>                 if (count < 4) {
> -                       dev_err(dev, "Invaild PR bitstream size\n");
> +                       dev_err(dev, "Invalid PR bitstream size\n");
>                         return -EINVAL;
>                 }
>
> --
> 2.17.1
>

Thanks,
Alan
