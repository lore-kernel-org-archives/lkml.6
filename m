Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933130AbeCFXte (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:49:34 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46305 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeCFXtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:49:33 -0500
X-Google-Smtp-Source: AG47ELsAoDuORnB0kPDE2J5pyR3U0jW14Bab26HjFt4RuHh6hDooRP1+1rkoQjS1JYBtPhCoWzCHW9k6bbxttfIaDz8=
MIME-Version: 1.0
In-Reply-To: <20180306151334.28720-1-robh@kernel.org>
References: <20180306151334.28720-1-robh@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 6 Mar 2018 15:49:11 -0800
Message-ID: <CAErSpo6bMDNe7wSraC3jUetn=Vx5ZcTFOprhMti7NRyY2JUGcw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux/of_*.h headers to appropriate subsystems
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 7:13 AM, Rob Herring <robh@kernel.org> wrote:
> The DeviceTree support code for specific subsystems are maintained by
> the respective subsystem maintainers. However, only the DT
> maintainers are listed for most of the linux/of_*.h headers. Fix this
> and add the headers to the appropriate subsystem maintainer.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a12af4f180..248f4266c6bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4333,6 +4333,7 @@ Q:        https://patchwork.kernel.org/project/linux-dmaengine/list/
>  S:     Maintained
>  F:     drivers/dma/
>  F:     include/linux/dmaengine.h
> +F:     include/linux/of_dma.h
>  F:     Documentation/devicetree/bindings/dma/
>  F:     Documentation/driver-api/dmaengine/
>  T:     git git://git.infradead.org/users/vkoul/slave-dma.git
> @@ -6033,6 +6034,7 @@ F:        Documentation/ABI/obsolete/sysfs-gpio
>  F:     drivers/gpio/
>  F:     include/linux/gpio/
>  F:     include/linux/gpio.h
> +F:     include/linux/of_gpio.h
>  F:     include/asm-generic/gpio.h
>  F:     include/uapi/linux/gpio.h
>  F:     tools/gpio/
> @@ -7321,6 +7323,7 @@ S:        Maintained
>  F:     Documentation/devicetree/bindings/iommu/
>  F:     drivers/iommu/
>  F:     include/linux/iommu.h
> +F:     include/linux/of_iommu.h
>  F:     include/linux/iova.h
>
>  IP MASQUERADING
> @@ -10712,6 +10715,7 @@ F:      drivers/acpi/pci*
>  F:     drivers/pci/
>  F:     include/asm-generic/pci*
>  F:     include/linux/pci*
> +F:     include/linux/of_pci.h
>  F:     include/uapi/linux/pci*
>  F:     lib/pci*
>  F:     arch/x86/pci/
> --
> 2.14.1
>
