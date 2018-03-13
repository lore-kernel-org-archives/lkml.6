Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeCMRxt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:53:49 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:36347 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751394AbeCMRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:53:46 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>
Date: Tue, 13 Mar 2018 18:53:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.18 18:44, Marc Kleine-Budde wrote:
> On 03/13/2018 06:35 PM, Jakob Unterwurzacher wrote:
> 
> [...]
> 
> Please mark all multibyte values going over the USB as either le or be.

This is documented in can_ucan_protocol.rst,

     All multi-byte integers are encoded as Little Endian.

but it's probably worth mentioning here as well.

> 
> Please use standard 'net' comment style:
> 
>  /* this is a multiline
>   * comment
>   */
> 
>> +	struct ucan_ctl_cmd_start cmd_start;
>> +	/***************************************************
>> +	 * Setup Bittiming
>> +	 * bmRequest == UCAN_COMMAND_SET_BITTIMING
>> +	 ***************************************************/

Understood.

Thanks,
Jakob
