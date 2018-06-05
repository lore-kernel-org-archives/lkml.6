Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFESvL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:51:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51112 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFESvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:51:10 -0400
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
Date: Tue, 5 Jun 2018 20:51:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605094626.GC4637@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 05/06/18 11:46, Alexandre Belloni wrote:
> On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
>> Adopt the SPDX license identifier headers to ease license compliance
>> management.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
>>  1 file changed, 5 insertions(+), 16 deletions(-)
>>
> Applied, thanks.
> 

Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
a mismatch between what the header says and the MODULE_LICENSE and I wrongly
assumed that the MODULE_LICENSE is the one I should follow. So could you not
apply this patch for now and I'll send another version with the correct license?

Thanks and sorry for the inconvenience this may cause you,
 Enric
