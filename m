Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeBRO4j (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:56:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:55971 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeBRO4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:56:38 -0500
Subject: Re: [PATCH] ARM: dts: owl: Convert to new-style SPDX license
 identifiers
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>,
        =?UTF-8?B?5qKF5Yip?= <harrymei@actions-semi.com>,
        Sudeep Kumar <sudeepkumar@cem-solutions.net>,
        linux-kernel@vger.kernel.org,
        Thomas Liau <thomas.liau@actions-semi.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
References: <20180121163943.27330-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <32d74f00-88ae-686f-d1c7-0608a80efcec@suse.de>
Date: Sun, 18 Feb 2018 15:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180121163943.27330-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.01.2018 um 17:39 schrieb Andreas Färber:
> Move the SPDX-License-Identifier lines to the top.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 3 +--
>  arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 3 +--
>  arch/arm/boot/dts/owl-s500-guitar.dtsi         | 3 +--
>  arch/arm/boot/dts/owl-s500-sparky.dts          | 3 +--
>  arch/arm/boot/dts/owl-s500.dtsi                | 3 +--
>  5 files changed, 5 insertions(+), 10 deletions(-)

Applied to v4.17/dt:
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.17/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
