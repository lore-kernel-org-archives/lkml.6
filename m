Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeD3GLI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 02:11:08 -0400
Received: from mail.sysgo.com ([176.9.12.79]:59918 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeD3GLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 02:11:07 -0400
Subject: Re: [PATCH v2] i2c: at91: Read all available bytes at once
To: Wolfram Sang <wsa@the-dreams.de>
Cc: ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
 <20180426095314.12758-1-david.engraf@sysgo.com>
 <20180428123838.abxiht7k4egv7iel@ninjato>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <d728f2ac-5763-48af-03b5-571a75265281@sysgo.com>
Date: Mon, 30 Apr 2018 08:11:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180428123838.abxiht7k4egv7iel@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.04.2018 um 14:38 schrieb Wolfram Sang:
> On Thu, Apr 26, 2018 at 11:53:14AM +0200, David Engraf wrote:
>> With FIFO enabled it is possible to read multiple bytes
>> at once in the interrupt handler as long as RXRDY is
>> set. This may also reduce the number of interrupts.
>>
>> This patch polls RXRDY and reads all available bytes at
>> once.
>>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
> checkpatch said twice:
> 
> WARNING: line over 80 characters
> 
> While I am not super-strict with this limit, it makes sense here IMO.
> The comment stays readable, and we don't even lose a line.

Sorry for that.

> Fixed it this time for you.

Thanks
- David

> Applied to for-next, thanks!
> 
