Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeEWLih (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932541AbeEWLic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:38:32 -0400
X-Google-Smtp-Source: AB8JxZrM43G22lUdfwRdPy91vXgoWfIobNtHUuw0ehu8EWK4pZh7EdQlamLxbBj4VRsQVMi5p2W+j86Fk3YZ1xyyXfM=
MIME-Version: 1.0
In-Reply-To: <a8969b297da304c292e6587fba7fcc23@agner.ch>
References: <1527069406-6359-1-git-send-email-krzk@kernel.org>
 <1527069406-6359-4-git-send-email-krzk@kernel.org> <a8969b297da304c292e6587fba7fcc23@agner.ch>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 23 May 2018 13:38:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfK+GGbvpGx4CVV5+AuskXZ=yEfiMu3NFQpezM46xQRog@mail.gmail.com>
Message-ID: <CAJKOXPfK+GGbvpGx4CVV5+AuskXZ=yEfiMu3NFQpezM46xQRog@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] ARM: dts: tegra: Work safely with 256 MB
 Colibri-T20 modules
To: Stefan Agner <stefan@agner.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:35 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 23.05.2018 11:56, Krzysztof Kozlowski wrote:
>> Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
>> (with 1024 MB NAND) flavors.  Both of them will use the same DTSI
>> expecting the bootloader to do the fixup of /memory node.  However in
>> case it does not happen, let's stay on safe side by limiting the memory
>> to 256 MB for both versions of Colibri-T20.
>>
>
> Maybe also mention the renaming stuff:
>
> "Rename to remove the unnecessary memory size from the device tree file
> name. While at it, also follow the typical Toradex SoC, module, carrier
> board hierarchy."

Since I am going to resend it for v7... no problem.

Best regards,
Krzysztof
