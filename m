Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965094AbeB1XgA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:36:00 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35890 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964962AbeB1Xf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:35:58 -0500
X-Google-Smtp-Source: AG47ELvyUD0iXwDnOV6/nx1VYU7kMuEfc+ox9IuaCs05U2pcsZv49h4G3wcJ4/oVKpY9y0pHIhqCrg==
Subject: Re: [GIT PULL 1/2] bcm2835-dt-next-2018-02-28
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20180228213945.6781-1-eric@anholt.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1c65dc88-901f-2ad7-0f45-5d2f53dc1048@gmail.com>
Date: Wed, 28 Feb 2018 15:35:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228213945.6781-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 01:39 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2018-02-28
> 
> for you to fetch changes up to bcc76c4014dce4e3834dbd5b7f6593cbcfbfebe0:
> 
>   ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode (2018-02-26 15:02:23 -0800)
> 
> ----------------------------------------------------------------
> This pull request adds automatic BT probing to the Pi Zero W, OTG mode
> for the Zero W, the GPIO expander on the Pi3, and fixes I2S probe
> (which is disabled by default, but often used downstream)
> 
> ----------------------------------------------------------------
> Baruch Siach (2):
>       ARM: dts: bcm2835: make the firmware node into a bus
>       ARM: dts: bcm2837-rpi-3-b: add GPIO expander
> 
> Henry Zhang (1):
>       ARM: dts: bcm283x: Fix pin function of JTAG pins
> 
> Stefan Wahren (5):
>       dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
>       ARM: dts: bcm283x: Fix probing of bcm2835-i2s
>       ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
>       ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
>       ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode

Merged into devicetree/next, thanks Eric!
-- 
Florian
