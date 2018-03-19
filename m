Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551932-1521485537-2-8344762920619869288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485536; b=QHUU5EMCVWq5MEVzzLfLrggKyuRi6H1xZjVKjlmqMnepPBg
    IqtEmiHPeg2AJRzgMZO54srJxiJcwDttB5UlDSNCddVzHla59hs9w6vNpxN+DQB8
    ze78sAzI1M+5tLbiAxEFlsSbpxpcsuDuYTgestN8V8nUzCicQM/BUWvboOXpnN4u
    uHKD8B2cK7jGrTqy6z+zo2OgPYzdf6PZshMdwpzt6clhK85tqsRRiXdxlEIV5iAq
    Q0PrXqtRXopWKcpBIbny8soNmVlwgq0khgcDsVxByM/6jBShotqKwX17UmY/kWoe
    TewFNEknaY69CS8AZJf3ZBdo3vIn6uX6VMqWAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521485536; bh=VX4+fo72b+s+fr256+1TG8zYeJ2NAK0M6vdNxn
    RYwMw=; b=IWKPPQ0PofUGlsCxtimb1c6ftz7UL8w0fwKo+tTiVGWJb61Bc/LcnR
    iXOSjPoZ7VtgxN9gLCYgNGXW1uqhMNn/NKvI2N7HZZW5VPn9AmozZLRwqqKEttK8
    XJEW+0whE+RpchxvCGX6mK9oBPyyRb/5Fw7/qluqkIq7xvz+ivn7jVYCJmXoD4o+
    K7s4KnP0iy9O4vb8UuZ8QJAFD9NKLlPlMA9y7fNsZPf6JsqVw4qaEO6TPwfZWGhp
    HZOsFF69Clhvhprbp/S+/6qMXyEsY/1vel6lwXWfI/HZUWbPtA6KG76G/uvp673v
    Aq8pTkwivQkKyQrb5lMjnSITQgsTgeeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvtghsphejsehttdertddttdejnecuhfhrohhmpeetlhgrnhcuvfhulhhluceorghtuhhllheskhgvrhhnvghlrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddtledrkeehrddvvddtrdduieelnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeejleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvtghsphejsehttdertddttdejnecuhfhrohhmpeetlhgrnhcuvfhulhhluceorghtuhhllheskhgvrhhnvghlrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvddtledrkeehrddvvddtrdduieelnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeejleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935786AbeCSSv7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031959AbeCSSaf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Mar 2018 14:30:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AC7217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELsau4QX2stzzCHw7eZneq6aQOyazLs045yjkodMOMLWYoAf7XBiIo3FEmZ/GcDwTepN8cp0QJ4CaJP9dUoZtwY=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-13-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-13-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 19 Mar 2018 13:29:52 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ79CvNECJav6bvs+XZHSD=1ai=kg55W4zTYvSn7GRwKQ@mail.gmail.com>
Message-ID: <CANk1AXQ79CvNECJav6bvs+XZHSD=1ai=kg55W4zTYvSn7GRwKQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] fpga: dfl: fme: add FPGA_GET_API_VERSION/CHECK_EXTENSION
 ioctls support
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looking at fpga-dfl.h again, there's a lot of things that start with
FPGA_.  Don't you think this is too general?  There are other FPGA_
things in the kernel.  Not just the things added by this patch, but
the whole file.

> FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which

Maybe DFL_FPGA_GET_API_VERSION?

> need to be supported by all feature devices drivers including FME and AFU.
> Userspace application can use these ioctl interfaces to get the API info
> and check if specific extension is supported or not in current driver.
>
> This patch implements above 2 ioctls in FPGA Management Engine (FME)
> driver.
>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: switched to GPLv2 license.
> v3: rename intel-fpga.h to fpga-dfl.h and rebased.
> v4: fix SPDX license issue.
>     add Acked-by from Alan and Moritz.
> ---
>  Documentation/ioctl/ioctl-number.txt |  1 +
>  drivers/fpga/dfl-fme-main.c          | 12 +++++++++
>  include/uapi/linux/fpga-dfl.h        | 48 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 include/uapi/linux/fpga-dfl.h
>
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 6501389..f1e7baa 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -324,6 +324,7 @@ Code  Seq#(hex)     Include File            Comments
>  0xB3   00      linux/mmc/ioctl.h
>  0xB4   00-0F   linux/gpio.h            <mailto:linux-gpio@vger.kernel.org>
>  0xB5   00-0F   uapi/linux/rpmsg.h      <mailto:linux-remoteproc@vger.kernel.org>
> +0xB6   all     linux/fpga-dfl.h
>  0xC0   00-0F   linux/usb/iowarrior.h
>  0xCA   00-0F   uapi/misc/cxl.h
>  0xCA   10-2F   uapi/misc/ocxl.h
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 056ae24..1a9929c 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -16,6 +16,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/fpga-dfl.h>
>
>  #include "dfl.h"
>
> @@ -114,6 +115,13 @@ static struct feature_driver fme_feature_drvs[] = {
>         },
>  };
>
> +static long fme_ioctl_check_extension(struct feature_platform_data *pdata,
> +                                     unsigned long arg)
> +{
> +       /* No extension support for now */
> +       return 0;
> +}
> +
>  static int fme_open(struct inode *inode, struct file *filp)
>  {
>         struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
> @@ -154,6 +162,10 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
>
>         switch (cmd) {
> +       case FPGA_GET_API_VERSION:
> +               return FPGA_API_VERSION;
> +       case FPGA_CHECK_EXTENSION:
> +               return fme_ioctl_check_extension(pdata, arg);
>         default:
>                 /*
>                  * Let sub-feature's ioctl function to handle the cmd
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> new file mode 100644
> index 0000000..9321ee9
> --- /dev/null
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header File for FPGA DFL User API
> + *
> + * Copyright (C) 2017 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
> + *   Zhang Yi <yi.z.zhang@intel.com>
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + */
> +
> +#ifndef _UAPI_LINUX_FPGA_DFL_H
> +#define _UAPI_LINUX_FPGA_DFL_H
> +
> +#define FPGA_API_VERSION 0

There will be other FPGA API's.  Maybe DFL_FPGA_... or FME_FPGA_...

> +
> +/*
> + * The IOCTL interface for DFL based FPGA is designed for extensibility by
> + * embedding the structure length (argsz) and flags into structures passed
> + * between kernel and userspace. This design referenced the VFIO IOCTL
> + * interface (include/uapi/linux/vfio.h).
> + */
> +
> +#define FPGA_MAGIC 0xB6

Same here.

> +
> +#define FPGA_BASE 0

And here.

> +
> +/**
> + * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
> + *
> + * Report the version of the driver API.
> + * Return: Driver API Version.
> + */
> +
> +#define FPGA_GET_API_VERSION   _IO(FPGA_MAGIC, FPGA_BASE + 0)
> +
> +/**
> + * FPGA_CHECK_EXTENSION - _IO(FPGA_MAGIC, FPGA_BASE + 1)
> + *
> + * Check whether an extension is supported.
> + * Return: 0 if not supported, otherwise the extension is supported.
> + */
> +
> +#define FPGA_CHECK_EXTENSION   _IO(FPGA_MAGIC, FPGA_BASE + 1)

Basically all the FPGA_* stuff here is specific to this particular DFL
FPGA API and should have a better name.

Alan

> +
> +#endif /* _UAPI_LINUX_FPGA_DFL_H */
> --
> 2.7.4
>
