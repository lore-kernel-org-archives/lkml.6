Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965071AbeB1Xhc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:37:32 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42498 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeB1Xhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:37:31 -0500
X-Google-Smtp-Source: AG47ELvMipZr19RggmRx/9Wu2quIEYtmY7N6E2WCbocQ/VdwFfFixS6w3wbK1cMUffndT1g1aCsYTA==
Subject: Re: [GIT PULL 2/2] bcm2835-defconfig-next-2018-02-28
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20180228213945.6781-1-eric@anholt.net>
 <20180228213945.6781-2-eric@anholt.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cf9c863a-8523-00da-4399-d4be641ad96d@gmail.com>
Date: Wed, 28 Feb 2018 15:37:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228213945.6781-2-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 01:39 PM, Eric Anholt wrote:
> Hi Florian,
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-02-28
> 
> for you to fetch changes up to bb9d91a4e5c87cabfa2c9d35761374aa11150c2d:
> 
>   ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3 (2018-02-26 15:30:43 -0800)
> 
> ----------------------------------------------------------------
> This pull request enables several recent drivers for the Raspberry Pi
> family in the defconfigs (thermal, BT, aux serial).
> 
> ----------------------------------------------------------------
> Stefan Wahren (2):
>       ARM: bcm2385_defconfig: Enable BT support for BCM43438
>       ARM: multi_v7_defconfig: Enable thermal driver for RPi 2/3
> 
> Tuomas Tynkkynen (1):
>       ARM: multi_v7_defconfig: Enable serial console on RPi 3

Merged into defconfig/next, thanks Eric.
-- 
Florian
