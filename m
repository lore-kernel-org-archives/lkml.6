Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeCFQpd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:45:33 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55759 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:45:31 -0500
X-Google-Smtp-Source: AG47ELs5Iz0pQ4VgnfNHeTwliwnv62FzT11MwXkLIDFZa1vwZeZATCk0w+pIMVLtzt4AtOtyK2DW/oPsy0jhnepJB/4=
MIME-Version: 1.0
In-Reply-To: <20180221090000.18091-1-niklas.cassel@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 17:45:30 +0100
X-Google-Sender-Auth: IW5thdlSCanCHW2VECgNTSBGoBA
Message-ID: <CAK8P3a0ykwsO40w49TL9xgVKv3wrvx7KXz1o6XD5+qXQ6n8YUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] ARTPEC-6 ARM SoC device tree updates
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: arm-soc <arm@kernel.org>, linux-arm-kernel@axis.com,
        DTML <devicetree@vger.kernel.org>, Niklas Cassel <niklass@axis.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:59 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> Hello,
>
> Here comes some ARTPEC-6 ARM SoC device tree updates.
>
> Niklas Cassel (8):
>   ARM: dts: artpec: disable Accelerator Coherency Port
>   ARM: dts: artpec: use 1 GiB RAM
>   ARM: dts: artpec: remove 0x prefix from clkctrl unit address
>   ARM: dts: artpec: migrate ethernet to stmmac binding
>   ARM: dts: artpec: add and utilize artpec6 pin controller
>   ARM: dts: artpec: add and utilize nbpfaxi DMA controllers
>   ARM: dts: artpec: add disabled node for PCIe endpoint mode
>   ARM: dts: artpec: add node for hardware crypto accelerator

For a series eight patches, a pull request would save me some work, but
I applied it anyway.

Are you sure that the first three patches shouldn't be applied to stable
backports?

     Arnd
