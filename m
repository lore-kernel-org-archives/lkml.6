Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66DFC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7346214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfA0JY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 04:24:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43754 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfA0JY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 04:24:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so15271217qtj.10;
        Sun, 27 Jan 2019 01:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaDJija6UKG2unMz2UqBHNOl5GWCn+T+fZPhVoigDHM=;
        b=tzS8x9rIvBxNwc7mtQggg6f1y+yas7DLMvv1WlKlfinhrLB1DtBzf9RM6mA8RUbU8t
         0J8fbdoQS4aY0lLDejd3idD6lPAMYfClsHHPelzVkVkd3aLzaQkKHCMpgBPND3kEpzAh
         Of4LXbNLnxouDmfcds3aSIPAd5oqL0wq4ztessX4LeaNinlgBAWzoEaRvn5dy0FF6+5L
         OizYTie1LckfM9eAPkJLXSFEtS5mXQg7Y7Iil0bUMh18y5tAmFTjd02jC6oIyjiDu9br
         uLAT27tyAXX8ssNta+tkvq9u5ywFhqCOw/yJz9SV/KVBmrRAszK9M2YKA+Vm18dUinY9
         EqDw==
X-Gm-Message-State: AJcUukf7wNy3Vc4Htgh4R0I06SQi85bbVXO3UdI4jgoCVnnc2W7kN5Au
        i+V7+Vo2JudUS7iTgIEl6J/AQYzAHANo3eG7bTA=
X-Google-Smtp-Source: ALg8bN6YOrCCbFLraxbCAPIcE7Ke2xKTD7COsjshu0jkDrMpY+3p8hvnecYOSve52woTsvixPsFw+6HRVTtgmj5kkQI=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr17403811qte.212.1548581067076;
 Sun, 27 Jan 2019 01:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 27 Jan 2019 10:24:09 +0100
Message-ID: <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> processor subsystem, a single core RISC-V subsystem and a Tensor
> Processor subsystem. This patchset adds support for only ARM Cortex
> A53 Application processor subsystem with UART, which enables the board to
> boot into initramfs with 2 CPUs.

Nice work! All patches in this series

Acked-by: Arnd Bergmann <arnd@arndb.de>
