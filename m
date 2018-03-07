Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeCGPEp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:04:45 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:53843 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeCGPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:04:43 -0500
X-Google-Smtp-Source: AG47ELsnu4nVTHii4V5xeyVp08PtBrU9PEKMNripBiC9UdMnCVMs0DEkpzD6fEEUDkOu/E07gNdLbiqkPSjBtM9p1kU=
MIME-Version: 1.0
In-Reply-To: <20180227133747.23517-1-alexandre.belloni@bootlin.com>
References: <20180227133747.23517-1-alexandre.belloni@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:04:41 +0100
X-Google-Sender-Auth: Nhs7DEk2bp5Ocp5nqM4qNvltVvY
Message-ID: <CAK8P3a1st909U_9cB3+P=mr8uZbdm2x0f49QJ0_mMU+wXbwVHg@mail.gmail.com>
Subject: Re: [PATCH] ARM: reorder mach-*/Kconfig inclusions
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 2:37 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Reorder the mach-* inclusions so the comment about them being ordered
> alphabetically ends up being true.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to next/soc, thanks for the nice cleanup!

     Arnd
