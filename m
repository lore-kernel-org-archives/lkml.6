Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeC0Nkg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:40:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46839 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeC0Nkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:40:35 -0400
X-Google-Smtp-Source: AG47ELt/8s6D0yBDQE5H54XCI5c7qq1XDuwGAfD5cmcjY/c6JYb6IkqxjtysDhASMGWiW9U0LPV8c3m3KgJerT+VKrs=
MIME-Version: 1.0
In-Reply-To: <20180326073214.GB8857@dragon>
References: <20180318203442.19759-1-stefan@agner.ch> <20180326073214.GB8857@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 15:40:33 +0200
X-Google-Sender-Auth: JtUuE79qqRU6fDdSHXdotjkwung
Message-ID: <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
To: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 9:32 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
>> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
>> Since OTP values might be required by drivers required during
>> boot, make sure the driver is built-in (e.g. i.MX thermal
>> driver).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Arnd,
>
> The series looks good to me.  In general, I keep myself away from
> multi_v7_defconfig changes, but if you expect a pull-request from me, I
> can do that.  Let me know how you want to apply the patches.

I would generally prefer that your defconfig pull requests contain changes
to both the imx specific and the generic defconfig files. It's much easier
for me to handle any conflicts when they arise during a merge than
to pick up the individual patches.

I applied all seven this time, to make sure we get them into linux-next
for more testing.

      Arnd
