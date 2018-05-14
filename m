Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeENPE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:04:57 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:37499 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbeENPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:04:54 -0400
Subject: Re: [PATCH v3 0/3] ti_am335x_tsc: Fix suspend/resume
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Grygorii Strashko <grygorii.strashko@ti.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
References: <20180424062741.7891-1-vigneshr@ti.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <45161a15-8804-561c-18af-0c9b45a2eac1@ti.com>
Date: Mon, 14 May 2018 20:34:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424062741.7891-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-Apr-18 11:57 AM, Vignesh R wrote:
> This patch series fixes couple of issues wrt suspend/resume with TI AM335x
> TSC driver. Disable and clear any pending IRQs before suspend, and
> handle case where TSC wakeup would fail, if there were touch events
> during suspend.
> 
> 

Gentle ping on this series... Any comments?

> Grygorii Strashko (2):
>   Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
>   Input: ti_am335x_tsc - Prevent system suspend when TSC is in use
> 
> Vignesh R (1):
>   Input: ti_am335x_tsc - Mark IRQ as wakeup capable
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
