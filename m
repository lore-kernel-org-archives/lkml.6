Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeCQR4O (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:56:14 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57950 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752836AbeCQR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:56:11 -0400
Subject: Re: [RFC 2/4] sh: ecovec24: conditionally register backlight device
To: Rich Felker <dalias@libc.org>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-3-dmitry.torokhov@gmail.com>
 <20180316100748.GH16424@w540> <20180316233800.GA32310@dtor-ws>
 <20180317092516.g5p5ybka57abyhex@apu3b>
 <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
 <20180317171631.GV1436@brightrain.aerifal.cx>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <58c9a323-3897-7677-2780-882dd0f3c164@physik.fu-berlin.de>
Date: Sun, 18 Mar 2018 02:55:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317171631.GV1436@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: 121.85.0.195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/2018 02:16 AM, Rich Felker wrote:
>> Umh, but I’m still using the SH7724 Evovec board. Please don’t
>> remove support for that.
>>
>> The SuperH port of the Linux kernel is still maintained.
> 
> Thanks. At some point it would be nice to remove the board file, but
> only once the conversion to device tree happens. If anyone has a list
> of boards that people are still using or have access to and who can do
> testing, it would be nice to compile that somewhere so we can figure
> out what needs to be tested and who can test it.

We should maybe create a wiki page somewhere. Either in the kernel wiki
(I don't have an account for that) or the Debian Wiki.

Here's what I still use:

- Renesas SH7724 Evovec
- Renesas SH7786LCR Evaluation Board
- LANDISK SH7751
- Sega Dreamcast (although I currently don't use that)
- NextVoD (currently not in the kernel)

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
