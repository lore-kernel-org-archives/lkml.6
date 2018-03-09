Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCIIqx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:46:53 -0500
Received: from regular1.263xmail.com ([211.150.99.132]:37645 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeCIIqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:46:50 -0500
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: lee.jones@linaro.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <c56f786acc6f540009f192577c4f8644>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AA249BC.6020705@rock-chips.com>
Date: Fri, 09 Mar 2018 16:45:48 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Set name of regmap_config
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com> <20180309081603.4u5pgwwsfxernodm@dell>
In-Reply-To: <20180309081603.4u5pgwwsfxernodm@dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thanks for your reply.

On 03/09/2018 04:16 PM, Lee Jones wrote:
>> >
>> >Jeffy Chen (4):
>> >   mfd: syscon: Set name of regmap_config
>> >   rtc: at91sam9: Set name of regmap_config
>> >   clk: lpc32xx: Set name of regmap_config
>> >   ARM: rockchip: Set name of regmap_config
>> >
>> >  arch/arm/mach-rockchip/platsmp.c | 1 +
>> >  drivers/clk/nxp/clk-lpc32xx.c    | 1 +
>> >  drivers/mfd/syscon.c             | 1 +
> It's difficult to review, since we cannot see what's happening with
> the rest of the patch set.  Would you mind re-sending the whole set to
> all parties please?
sure, i can do that :)

>
