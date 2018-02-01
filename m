Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBAFVA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 00:21:00 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:12649 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBAFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 00:20:56 -0500
Subject: Re: [RESEND] phy: da8xx-usb: rename clock con_ids
To: Sekhar Nori <nsekhar@ti.com>
References: <1516731283-26388-1-git-send-email-david@lechnology.com>
 <dbf02743-10ee-ccce-5f9c-2be8de075832@ti.com>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6630e9e4-f2b9-1c2c-b301-cf0db15a7ea1@ti.com>
Date: Thu, 1 Feb 2018 10:49:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <dbf02743-10ee-ccce-5f9c-2be8de075832@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 25 January 2018 09:11 PM, Sekhar Nori wrote:
> On Tuesday 23 January 2018 11:44 PM, David Lechner wrote:
>> This renames the clock con_ids in the DA8XX USB PHY driver as well as
>> the matching names in the mach clock registration code.
>>
>> This is in preparation for using device tree clocks where these names
>> will become part of the device tree bindings. The new names more closely
>> match the names used in the USB clock diagram in the SoC TRM.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Looks good to me.
> 
> Kishon, like with the other patch touching phy-da8xx-usb.c, I would like
> to queue this through my tree and provide an immutable commit to you.
> Let me know.

sure.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks,
> Sekhar
> 
