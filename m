Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBZGOJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 01:14:09 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61674 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeBZGOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 01:14:08 -0500
Subject: Re: [PATCH] ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <aford173@gmail.com>
References: <1516037371-3932-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <7849e3ae-cebe-b067-213c-3fe0d6e7a18e@ti.com>
Date: Mon, 26 Feb 2018 11:43:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516037371-3932-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2018 10:59 PM, David Lechner wrote:
> This changes CONFIG_DAVINCI_WATCHDOG from a module to a compiled-in
> option. Since the reset function has been moved out of the mach code in
> commit 0808d3260456 ("ARM: davinci: remove watchdog reset") and into the

commit id adjusted since the said patch did not make it to v4.16

> watchdog driver, devices cannot reboot unless the watchdog driver is
> loaded, so make it a compiled-in option so that we can always reboot, even
> when modules are not loaded.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Suggested-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/defconfig

Thanks,
Sekhar
