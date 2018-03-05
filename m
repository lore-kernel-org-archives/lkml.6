Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeCETai (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:30:38 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34487 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCETag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:30:36 -0500
X-Google-Smtp-Source: AG47ELtp0E6C3pzfEyzZWmra8oT0pigZeMsHOS9Q6YuFXQRQLbPjuFG3aQ7/Jh9OqmHzZFcuWWSHKziMT1C2sRAfeAQ=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Cdg4Njd5kXT4tqnJngSPr9NNHdSpoqT3UfmHYYpvuj1g@mail.gmail.com>
References: <CGME20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120@eucas1p1.samsung.com>
 <1519980169-8491-1-git-send-email-m.purski@samsung.com> <CAOMZO5C3YPKvZN+aORA+Jga-P=XgfG2xw7u6Ose5p6Twet2KLw@mail.gmail.com>
 <6fc780e4-3594-2ca5-dc4e-7e147dc4e40f@samsung.com> <CAOMZO5Cdg4Njd5kXT4tqnJngSPr9NNHdSpoqT3UfmHYYpvuj1g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Mar 2018 16:30:34 -0300
Message-ID: <CAOMZO5BqoEDEzPvVjAbE-e8SS5qLFc8WHQted-3hwYYTvQgajQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add coupled regulators mechanism
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Mon, Mar 5, 2018 at 12:57 PM, Fabio Estevam <festevam@gmail.com> wrote:

> kernelci.org also shows other imx6 boards that cannot boot with
> today's linux-next.

Here are the completes logs in case they help:

https://storage.kernelci.org/next/master/next-20180305/arm/imx_v6_v7_defconfig/lab-free-electrons/boot-imx6q-nitrogen6x.txt

https://storage.kernelci.org/next/master/next-20180305/arm/imx_v6_v7_defconfig/lab-baylibre-seattle/boot-imx6dl-wandboard_solo.txt
