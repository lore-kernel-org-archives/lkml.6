Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37310ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B4C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+os0n54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B4C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeGQPZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbeGQPZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:25:27 -0400
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com [209.85.161.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A68208A3;
        Tue, 17 Jul 2018 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531839146;
        bh=z3WZjyx8w/7SsHTciRTK872Dj0oS3yiCr60FsOIyNmQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k+os0n54PyL91pYS2qb8/UwOiS4o3uoR5JFmKVwju3wGt20FXxMcR+UDX8ikTf+iI
         ijyB204Ol65+t0hT6uUY+0xz1Oi6YuTJjt0BVEXHDyRQhh1sN2I7vrzy9pa/IX20//
         BOBbAO1BskgxjzauaD41azSEMXZpLaL55TovOEsY=
Received: by mail-yw0-f179.google.com with SMTP id q129-v6so479657ywg.8;
        Tue, 17 Jul 2018 07:52:25 -0700 (PDT)
X-Gm-Message-State: AOUpUlFFsXRUgCmzjP9ZGpgFa/1s4afyACo072qlk7TcCwLvMKQ6YIUH
        ljORgYn7xlNIZ6Kcn0fbqDE16spuq9hlUni+HzI=
X-Google-Smtp-Source: AAOMgpd7WwhgPVKzTUMtdG7/qgQ78qFoYHzaFICmFii2R0wylptECEvefHlFn7OWY1JIDfOdNITPzb3N2mHhG6OdqDk=
X-Received: by 2002:a81:a348:: with SMTP id a69-v6mr974137ywh.142.1531839145071;
 Tue, 17 Jul 2018 07:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 07:51:44
 -0700 (PDT)
In-Reply-To: <20180717092138.19010-1-colin.king@canonical.com>
References: <20180717092138.19010-1-colin.king@canonical.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 17 Jul 2018 09:51:44 -0500
X-Gmail-Original-Message-ID: <CANk1AXTWqY1OvGYE_FxtEPx=QtcVgQ9Bx3ss3Lc23ZSB1bRctg@mail.gmail.com>
Message-ID: <CANk1AXTWqY1OvGYE_FxtEPx=QtcVgQ9Bx3ss3Lc23ZSB1bRctg@mail.gmail.com>
Subject: Re: [PATCH] drivers: fpga: fix two trivial spelling mistakes
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:21 AM, Colin King <colin.king@canonical.com> wrote:'

Thanks Colin!

> From: Colin Ian King <colin.king@canonical.com>
>
> Trival fix to two spellling mistakes
> "execeeded" -> "exceeded"
> "Invaild" -> "Invalid"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Tull <atull@kernel.org>

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
