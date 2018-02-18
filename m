Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBROva (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:51:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeBROv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:51:29 -0500
Subject: Re: [PATCH] arm64: dts: actions: Convert to new-style SPDX license
 identifiers
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>,
        =?UTF-8?B?5qKF5Yip?= <harrymei@actions-semi.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Thomas Liau <thomas.liau@actions-semi.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
References: <20180121162317.24361-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <ec4db896-2a93-f128-3d6e-caf3a6ce0054@suse.de>
Date: Sun, 18 Feb 2018 15:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180121162317.24361-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.01.2018 um 17:23 schrieb Andreas Färber:
> Move SPDX-License-Identifier to the top and add one for the Makefile.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/actions/Makefile              | 2 ++
>  arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 3 +--
>  arch/arm64/boot/dts/actions/s900.dtsi             | 3 +--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied to v4.17/dt64:
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.17/dt64

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
