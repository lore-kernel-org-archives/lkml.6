Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeC0NCH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:02:07 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:51043 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeC0NCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:02:05 -0400
X-Google-Smtp-Source: AIpwx4/9XPWl1WJlNxXmW7NpV0jzF1ZB+Q0T6GKUEhV90gZj/iVsAElnRbyppcr+WC7AhPK6KVzTQBApst533i5SoS8=
MIME-Version: 1.0
In-Reply-To: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com>
References: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:02:03 +0200
Message-ID: <CACRpkdYfk7P0+Ysy43HboBe0Z66vO3COXRgUGaZ7Y9sSDh+yxA@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524
 and pcal9555a
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 12:00 PM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:

> The Pyra-Handheld originally used the tca6424 but recently we have
> replaced it by the pin and package compatible pcal6524. So let's
> add this to the bindings and the driver.
>
> And while we are at it, the pcal9555a does not have a compatible entry
> either but is already supported by the device id table.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied with Rob's review tag.

If there are any further concerns from the discussion with Andy,
please follow up with additional patches if need be, thanks!

Yours,
Linus Walleij
