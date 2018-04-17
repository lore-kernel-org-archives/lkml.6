Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeDQKyD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:54:03 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:17516 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeDQKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:54:02 -0400
Subject: Re: [RESEND PATCH v2 0/4] ARM: davinci: remove the mach-specific
 aemif driver - part 1
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <2a2ac117-900c-77b6-f247-49777493e55f@ti.com>
Date: Tue, 17 Apr 2018 16:23:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417102917.7794-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is the first part of changes required to remove duplicate aemif
> support from mach-davinci.
> 
> I actually noticed that one of my previous changes from 2017 broke nand
> in legacy mode - the clock lookup no longer works. This series addresses
> it as well.
> 
> First patch just uses a static string for the ti-aemif driver name.
> 
> The second adds support for board files to the aemif driver.
> 
> Last two add nand support to da850-lcdk in legacy mode and make
> da850-evm use the platform driver instead of the mach-specific one.
> 
> If these patches get accepted, I'll prepere a follow-up moving all
> other boards to the new platform driver.
> 
> This series applies on top of v8 of David Lechner's CCF series.

Are there any patches in the series that can safely be applied to v4.17-rc1?

Thanks,
Sekhar
