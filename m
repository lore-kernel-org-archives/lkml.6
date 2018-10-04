Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36723C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A9E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A9E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJDWFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:05:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34668 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJDWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:05:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id x23-v6so10274191qtr.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+qtkbyTr0VleW3XhzCYJAISKghcccXn5jBrpsLA/sU=;
        b=DyFlZRdGAu2Q34/YSJkAh5zSPElRf+1Of7oCPO8LzsPHZ+nEE+o/CGl7K4A9kc0jgM
         mM7cwRKRSFAgML152LtyIkkxVFwi0WT+JthdBIOvYeRIh+sGLavyMe5K47pH7EBOIh4h
         t/2JaNq0v3c9HmCLgByOTrILsr8R4/k9xd2T7wcPZIz9ClrH2tgv39VhnbttJ5hMUh0E
         VhLuAFN4IU5REfzGNXxRbT0RtM0WeydYw8Qu6ba8GNfFC7RyXRLkKWznizz4Ax53/beK
         p3PP14O7HLh5uoWHMisBGi1k5RxPb2ZukfE5ImvnYmT9tNdZTTuhoSxDYmiwHnqJIPp8
         CYNA==
X-Gm-Message-State: ABuFfog858x0RQHvBwsy+V0gTuccviwm0JOPfj5I6rU02SDCVs1eDte2
        PcGaT3xmrnuHvE6c+a8kyocR/KeKAlowvWDbKWw=
X-Google-Smtp-Source: ACcGV62BKrfz/qm8TI797DFSQr7rQbTeZ5/hJ6ngPiLVWlWoB88IF+zMKxn7qXM9b3tTwpe2WxIQqg6PZq+zCi0zJUM=
X-Received: by 2002:a0c:ad8e:: with SMTP id w14-v6mr5641645qvc.149.1538665931198;
 Thu, 04 Oct 2018 08:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:11:55 +0200
Message-ID: <CAK8P3a0R+hj3owNUi_nW6avi5HgEb3GcNCAk0TTudGTMXrjGmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_MMC_UNIPHIER
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 2:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Enable the UniPhier SD controller driver.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to next/defconfig, thanks!

Note: I think it would actually be better to update both defconfig files in one
patch, since you are doing the same change on both.

     Arnd
