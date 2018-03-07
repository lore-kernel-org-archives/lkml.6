Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeCGJCp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:02:45 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45041 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeCGJCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:02:42 -0500
X-Google-Smtp-Source: AG47ELvJ73DBnQ7JhMAoeVU5UMaBFTCRy76503B7tu61IrdISrbvL6iOrkqqsnLJnDkGYuyOCvurZMy4k4JfYjviRXA=
MIME-Version: 1.0
In-Reply-To: <20180306151334.28720-1-robh@kernel.org>
References: <20180306151334.28720-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Mar 2018 10:02:41 +0100
Message-ID: <CACRpkdaKFekSHZZn-zc714NZ_CtoN+zsaSmw4u-cpy+jcY4reg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux/of_*.h headers to appropriate subsystems
To: Rob Herring <robh@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 4:13 PM, Rob Herring <robh@kernel.org> wrote:

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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
