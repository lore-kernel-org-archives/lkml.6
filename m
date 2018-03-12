Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCLVY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:24:57 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34721 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeCLVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:24:56 -0400
X-Google-Smtp-Source: AG47ELsoQOyjfEhStLtf25hxJCwITwwF9OC9ng0A+KPrlp1E6NmMhGFXfd2tBqq107DdBhPQFx9vOQ==
Subject: Re: [PATCH] ARM: bcm2835: Add the DPI hardware to the device tree.
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180309233639.2029-1-eric@anholt.net>
 <258037433.356163.1520876736286@email.1und1.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fbfe832f-3253-277a-2b8a-a159cd323052@gmail.com>
Date: Mon, 12 Mar 2018 14:24:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <258037433.356163.1520876736286@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 10:45 AM, Stefan Wahren wrote:
>> Eric Anholt <eric@anholt.net> hat am 10. März 2018 um 00:36 geschrieben:
>>
>>
>> It's currently marked disabled, as it's not useful without a panel
>> associated with it and the GPIO pins routed to ALT2.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
> 
> FWIW, Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Eric, do you want me to apply that directly to my upcoming ARM SoC pull
request (next couple of days)?
-- 
Florian
