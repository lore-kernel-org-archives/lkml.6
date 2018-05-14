Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeENKaX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:30:23 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:40561 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeENKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:30:20 -0400
Subject: Re: [PATCH] clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180512204942.10090-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4aa52e4d-766f-2d71-496b-1660627a7620@ti.com>
Date: Mon, 14 May 2018 15:59:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512204942.10090-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2018 02:19 AM, David Lechner wrote:
> The clkdev lookups for the ASP0/1 devices on TI DM355 were declared, but
> not assigned to any LPSC. This assigns the clkdev lookups to the
> correct LPSCs.
> 
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
