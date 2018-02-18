Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeBRPAq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 10:00:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:56137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeBRPAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 10:00:45 -0500
Subject: Re: [PATCH] soc: actions: Convert to SPDX license identifiers
Cc: =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>,
        =?UTF-8?B?5qKF5Yip?= <harrymei@actions-semi.com>,
        linux-kernel@vger.kernel.org,
        Thomas Liau <thomas.liau@actions-semi.com>,
        =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
References: <20180121170143.29915-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <72b34d7f-8987-0bc3-4336-c833ffb69bb3@suse.de>
Date: Sun, 18 Feb 2018 16:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180121170143.29915-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.01.2018 um 18:01 schrieb Andreas Färber:
> Replace textual license notices with SPDX-License-Identifier lines.
> Add an SPDX-License-Identifier for the Makefile.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/soc/actions/Makefile         | 2 ++
>  drivers/soc/actions/owl-sps-helper.c | 6 +-----
>  drivers/soc/actions/owl-sps.c        | 6 +-----
>  3 files changed, 4 insertions(+), 10 deletions(-)

Applied to v4.17/drivers:
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.17/drivers

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
