Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeBIEVs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 23:21:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55025 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBIEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 23:21:46 -0500
X-Google-Smtp-Source: AH8x2279AUBv7AoEDsq5bNfZnkIPLsamyCpzt7JxdSmkbrGlZ9u+jvK/IJ24CUXK2xOZux5+gILVXA==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.9\))
Subject: Re: [PATCH] ath9k: turn on btcoex_enable as default
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name>
Date: Fri, 9 Feb 2018 12:21:36 +0800
Cc: kvalo@codeaurora.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <A5972CE9-8325-404A-A63D-ED29E44FB67B@canonical.com>
References: <20180208052801.15670-1-kai.heng.feng@canonical.com>
 <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
X-Mailer: Apple Mail (2.3445.6.9)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

> On Feb 8, 2018, at 7:02 PM, Felix Fietkau <nbd@nbd.name> wrote:
>
> On 2018-02-08 06:28, Kai-Heng Feng wrote:
>> Without btcoex_enable, WiFi activies make both WiFi and Bluetooth
>> unstable if there's a bluetooth connection.
>>
>> Enable this option when bt_ant_diversity is disabled.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1746164
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> I think this might cause regressions on devices that don't have
> bluetooth. This probably either needs more EEPROM checks, or something
> to selectively enable it only on affected platforms.
>

I think it’s better not to use dmi_match. This issue should affect more  
ath9k.
And bluetooth peripherals are more than ever now, so it would be great to  
use BT out of the box.

Can you take a look at the bug link, maybe there are other things caused  
the erratic behavior that I didn’t notice?

Kai-Heng

> - Felix
