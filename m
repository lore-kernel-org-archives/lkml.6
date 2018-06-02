Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeFBTqY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 15:46:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39675 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFBTqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 15:46:22 -0400
X-Google-Smtp-Source: ADUXVKKFM/vfvSoUQLBoJVP2z7i9rk0HoHAdg+YG702Q9rLZN0O/CaKHXo41qFjrDahS/NqmxVO5HWIq3DCyUH3GaA4=
MIME-Version: 1.0
In-Reply-To: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
From: Chris Healy <cphealy@gmail.com>
Date: Sat, 2 Jun 2018 12:46:21 -0700
Message-ID: <CAFXsbZrzkNM2MCye0vMUrCk-RW486rMNV2jyX78kK7pvi+fpkw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:19 PM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This adds rave-sp powerbutton and backlight devices to RDU1 device tree.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---

Tested-by: Chris Healy <cphealy@gmail.com>

Tested on an 8.9" RDU1.
