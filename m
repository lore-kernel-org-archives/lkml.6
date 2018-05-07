Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeEGLAY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:00:24 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33228 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750881AbeEGLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:00:22 -0400
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, Rob Landley <rob@landley.net>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
Date: Mon, 7 May 2018 13:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 03:40 AM, Yoshinori Sato wrote:
>> @Yoshinori:
>>
>> Did the HDL-160U LANDISK device you have use u-boot by default or
>> did you convert it from lilo?
> 
> Yes.
> Replace sh-lilo's second stage with u-boot.
> With this method it is unnecessary to rewrite Flash for boot.

Great, thank you. I will give it a try on my USL-5P and write down
the individual steps once I have figured it out.

As for the IDE controller: Can you tell me whether there are any
particular patches necessary to get the kernel detect the IDE
controller of the LANDISK devices?

I have been able to boot my own kernel on my USL-5P device, but
I could never get it to detect the IDE controller. Do I need
an additional patch for that?

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
