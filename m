Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030827AbeBNO3m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:29:42 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34736 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030429AbeBNO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:29:41 -0500
X-Google-Smtp-Source: AH8x2255QR6s+SHGL3mbLUVIgBK9sglgf7c5Wgs76Q3ZvSFGCIEiLGzEvzTQpBT0W9aWRd3HqZ9IuxQm1xuumqqT9yU=
MIME-Version: 1.0
In-Reply-To: <20180213200959.160157-3-brendanhiggins@google.com>
References: <20180213200959.160157-1-brendanhiggins@google.com> <20180213200959.160157-3-brendanhiggins@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:29:39 +0100
X-Google-Sender-Auth: B4jXltvk-L_DChQfgyAXuKqS4R0
Message-ID: <CAK8P3a2_2sQYCaUK-thBxTJ+VhQiw4AcDgwJoyEG=Ssnr=PtQg@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 9:09 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:

> +
> +Enable method name:    "nuvoton,npcm7xx-smp"
> +Compatible machines:   "nuvoton,npcm750"
> +Compatible CPUs:       "arm,cortex-a9"
> +Related properties:    (none)
> +
> +Note:
> +This enable method needs valid nodes compatible with "arm,cortex-a9-scu" and
> +"nuvoton,npcm750-gcr".
> +
> +Example:
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm7xx-smp";

It seems you changed the DT files, but forgot to update the binding to match.

Otherwise it looks al good to me.

       Arnd
