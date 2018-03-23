Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755835AbeCWK5t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:57:49 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:43346 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752088AbeCWKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:12:49 -0400
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
 <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
 <e6d4bfc8-d43f-20ef-7b00-43ecf0a87f96@grandegger.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <01b11c3d-76df-0e4c-1479-1321a6ecd96c@theobroma-systems.com>
Date: Fri, 23 Mar 2018 11:12:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e6d4bfc8-d43f-20ef-7b00-43ecf0a87f96@grandegger.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.18 11:04, Wolfgang Grandegger wrote:
> 
>> But I'm open to other suggestions (use a fixed "ucan: " prefix?) or to
>> drop it entirely if you think it is not worth it.
> 
> But there is already a device prefix, e.g.:
> 
>    peak_usb 1-6:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
>    peak_usb 1-6:1.0 can0: attached to PCAN-USB channel 0 (device 255)
>    ^^^^^^^^

Interesting. Looks like the UCAN driver is missing something to make 
this work:

[   67.792947] usb 5-1.4: ucan_probe: registered UCAN device at can0

I'll take a closer look.

Thanks,
Jakob
