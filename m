Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA83C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B621473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfA3Qqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:46:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46405 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfA3Qqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:46:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so80538qkf.13;
        Wed, 30 Jan 2019 08:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBnBWYuLFJRbcDQmCg5Vi1CYtIFdJ7zoLkwsEYFcMg4=;
        b=ATXrqVbx3NrIr/5en6r8WoKQQTRTRiHkaDe8dn1nZoH9BSjZYOXL3PoTPQT79Gm2vu
         h1c91LnZuI61WYXA9RINXgmtuE8ufRdG5aJLlYclkYeO/HHAZUdBCA3OUttPIn1/OI32
         7LzJT9wRkAEaWkQwn9ifq2oSC+qvvp4Y35uu5lxeyztkSJhcodbvemqxFaczXU5BN8KN
         vkFu7uR9/9rll3apr63kBdmqsp3U6ggFvviXFL0HjpHNGABpYDVthrPh3DKUUm+i775c
         /fjOojzBM8cS3AzCxVxtxCjEybQgptc4tclEfxdhWs/k5oKHK8yYmB3jwgJ47+PDOJp5
         2lmw==
X-Gm-Message-State: AJcUukdBNd8v5JhsOyOu1GeDaheHuQyzfqYafzc17w6Vb4Ezxut789xF
        smHHLhGC0s6f+u5QsziYEajSdjbzpblQe371lUYE+w==
X-Google-Smtp-Source: ALg8bN6jYsmd+UgbwoTKJy9IxTvlceLNqrE+jWbHcGU8+0xxu59xNb7PYeU8M5gTWQX2yKZawf40fJ9yxHf3joB5Wiw=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr27015236qkf.107.1548866806420;
 Wed, 30 Jan 2019 08:46:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 17:46:29 +0100
Message-ID: <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set adds charger and fuel gauge device nodes for Spreadtrum
> SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
> devices and adds nvmem cells for ADC to calibrate the ADC channel scales.
>
> Baolin Wang (4):
>   arm64: dts: sprd: Remove PMIC INTC irq trigger type
>   arm64: dts: sprd: Add ADC calibration support
>   arm64: dts: sprd: Add SC2731 charger device
>   arm64: dts: sprd: Add SC27XX fuel gauge device

I did not apply these because of the 'sc27xx' wildcard matching.

Please fix those up and resend.

      Arnd
