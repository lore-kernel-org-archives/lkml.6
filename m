Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDQONA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:13:00 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:38761 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeDQOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:12:59 -0400
Subject: Re: [RESEND PATCH v2 4/4] ARM: davinci: use aemif platform driver in
 legacy mode for da850-evm
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-5-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
Date: Tue, 17 Apr 2018 19:42:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417102917.7794-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now support board files in aemif. Use the platform driver instead
> of the handcrafted API in da850-evm.
> 
> Note: the id of davinci_nand is changed to 0 in order to make it work
> with the new common-clock framework based psc driver.

Is this now needed after applying my patch dropping clock acquisition
from DaVinci NAND driver?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks,
Sekhar
