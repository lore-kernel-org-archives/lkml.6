Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeCGO2A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:28:00 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:41388 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeCGO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:27:54 -0500
X-Google-Smtp-Source: AG47ELsHsQju+daSZkvpgN/kSXJbb/8VSEjdGx7y/a4Ol5cketiS1moIpQMxfuo7FCuawsH0xu8/KbOmL42K/mKIZew=
MIME-Version: 1.0
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 15:27:52 +0100
X-Google-Sender-Auth: 2N5uawrqrvIsSAkFdFotlZMj4XA
Message-ID: <CAK8P3a2Fu9OpdFwXKqwbxMzCR==smaW=M1mzn4rvFm05H-Dwig@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/7] arm64: dts: Add hwspinlock node for Spreadtrum SC9860
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, chunyan.zhang@linaro.org,
        =?UTF-8?B?T3Jzb24gWmhhaSAo57+f5LqsKQ==?=
        <orson.zhai@spreadtrum.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:47 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum SC9860 platform only has one hardware spinlock device,
> which is located on AON system of Spreadtrum SC9860 platform.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied all seven patches to next/dt, thanks!

     Arnd
