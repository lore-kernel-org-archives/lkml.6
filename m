Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeCEP5o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:57:44 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:47026 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeCEP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:57:41 -0500
X-Google-Smtp-Source: AG47ELsHAqgCqw3R/GjfL9Kd1gsiGkfLZumkOEIlEI7OBZXZuZKlgVlnsYd91PAlKn9PCSq4RTYI8K9RF/tuPDr6+l8=
MIME-Version: 1.0
In-Reply-To: <6fc780e4-3594-2ca5-dc4e-7e147dc4e40f@samsung.com>
References: <CGME20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120@eucas1p1.samsung.com>
 <1519980169-8491-1-git-send-email-m.purski@samsung.com> <CAOMZO5C3YPKvZN+aORA+Jga-P=XgfG2xw7u6Ose5p6Twet2KLw@mail.gmail.com>
 <6fc780e4-3594-2ca5-dc4e-7e147dc4e40f@samsung.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Mar 2018 12:57:39 -0300
Message-ID: <CAOMZO5Cdg4Njd5kXT4tqnJngSPr9NNHdSpoqT3UfmHYYpvuj1g@mail.gmail.com>
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

On Mon, Mar 5, 2018 at 11:40 AM, Maciej Purski <m.purski@samsung.com> wrote:
> Hi Fabio,
> thank you for your response.
> Could you tell me on which board precisely (on which DTS) has this issue
> occurred?

I tested it on a imx6dl-wandboard.dtb.

kernelci.org also shows other imx6 boards that cannot boot with
today's linux-next.

> Also, I don't understand, did you boot successfully and you got only a
> lockdep warning or you encountered an actual deadlock?

No, with this series I am not able to boot till the Linux prompt.

Thanks
