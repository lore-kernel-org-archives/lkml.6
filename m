Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCNKTz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:19:55 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:43265 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750818AbeCNKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:19:54 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
 <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
 <5b3df9d5-3e65-1114-4b51-9dcc329cbc31@theobroma-systems.com>
 <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <ed41c2d8-b231-fa8f-9802-b18382dde32e@theobroma-systems.com>
Date: Wed, 14 Mar 2018 11:19:51 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.18 11:04, Wolfgang Grandegger wrote:
>>>      controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
> 
> Just,
> 
>         controller-problem{rx-error-passive,tx-error-passive}

Ok.

>> (1b) cable gets connected:
>>
>>>   (000.000883)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   ERRORFRAME
>>>      controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive}
>>>
>>>      transceiver-status
>>>      no-acknowledgement-on-tx
>>>      error-counter-tx-rx{{128}{0}}
>>>   (000.000996)  can0  20000004   [8]  00 0C 00 00 00 00 7F 00   ERRORFRAME
>>>      controller-problem{rx-error-warning,tx-error-warning}
>>>      error-counter-tx-rx{{127}{0}}
> 
> Back to error active is missing!? Have a look to:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L364

Should be sent out once the error counter drops further, will check.

Thanks,
Jakob
