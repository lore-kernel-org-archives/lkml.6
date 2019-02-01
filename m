Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E28021907
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfBALQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:16:10 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfBALQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:16:10 -0500
Received: from [192.168.178.52] ([109.104.54.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkHhB-1ha61119dR-00keUY; Fri, 01 Feb 2019 12:15:58 +0100
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
 <10832eda-69a1-1c47-3fe6-7e8da02884d6@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4ef803bf-2596-845b-1ebe-942478e94325@i2se.com>
Date:   Fri, 1 Feb 2019 12:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <10832eda-69a1-1c47-3fe6-7e8da02884d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:8KW0CsAmAfCrguBSJl0sp32qXC6Z+oRNjRPGJas5oF3ZTVov/z0
 NCCpelW3qpNx907FsOFjPiw9wLBm/F/Rl0I+rFu/Gmj2eiGZBO/3gDWzrXBBi04x/1aPa6c
 RKvQpNs9FGD8Cat/197kIvcgTFOuDUwKrvaihV+G9YMgXJQtYQuN4AsTYNI67ofRor0zdMG
 seLhd0uFOiT93ZRGwBhBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxCQ3PLQtlY=:gREkCXWROINeTPULsGQMa7
 rqCtZsAr50/U4jsQDdsj68aKXFeZCym/KpdTq5Tp1mrjlLQEPjlE0J5iWzrry5EjJrTg+OJoY
 5b0jSKzNVMY0WhXMdfJ4jcGXNFLUvERaZKa7dhFthAuDTxx41Ogvj5hJSSLvQZJ6mmp02aF4L
 Lq+IXoscN+DlfLpKfAqwoRjUOn4oFcXvPNlM1gCWeKtndvPJMcGpqqFEei7EFkwUy9cyu/FS/
 vM9JLON9AgYKSMrjOdNj5KB8fJnFW+Eogttkv9ytLd3YmUDnK3+sNl2rc5+w/5X6mDZFdRu/J
 nWbMM7Ym2hJPFjobImPOBl5GOtm2OryzRnR5EyR680m7G1oMwQUHnp/n4sOjiEghPD2i8vp2r
 rJgP5ivpoqmTKniUJ+CwgbFHw8Zs7Dq7D0a7xKi5jaJTKIvAKD1I/6veDc6oC4+R9eEg2r+3V
 ACNrA0Tf6CqK78Mja359TGRsQgq5HXmQZ4X9mu9QlB4mLaCZdaNDmCd7W9TjyoIPlHwjbH/lK
 TIT116wvAb+0hnpij8hW7DPjkEUzlOgmc4FXVrBMZTxQLDzQ5BOXPSF2fZP+9tiBd/Ze8f4HX
 J1f+L4wRVcMM5+JKpInkExclzpK0omwEDv+RudC77d35x441JAF2e5GGiT7676BM/HFuSTDhC
 ZZQHEACMiD9Slx8ZAvLdaWJsPldLIq9Qc+zzpeM5JjdzcpTeAnhxkxmKZGW/dPyxDLZx4xDam
 Z1UtSu5PKYdS2LuTiHB6fncbQRGXVbaF+evnSLp2Uuw7ZP+hEWb2Njwcgqw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 01.02.19 um 06:02 schrieb Florian Fainelli:
>
> On 1/31/19 8:10 PM, Florian Fainelli wrote:
>>
>> On 1/29/19 10:53 AM, Stefan Wahren wrote:
>>> Hi Florian,
>>>
>>> sorry for being that late and hoping it's not too late.
>>>
>>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>>>
>>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29
>>>
>>> for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:
>>>
>>>   ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)
>>>
>>> ----------------------------------------------------------------
>>> This pull request adds the necessary changes for the new BCM2835 PM driver,
>>> support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
>>> Additionally it contains some minor DT fixes.
>>>
>>> ----------------------------------------------------------------
>> Merged into devicetree/next, thanks Stefan!
> And backed out, integration failed with the following results:
>
> [X] aiaiai build results:
> Tested the patch(es) on top of the following commits:
> bfeffd155283 Linux 5.0-rc1
> 85e1ffbd42f6 Merge tag 'kbuild-v4.21-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> ac5eed2b4177 Merge branch 'perf-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 574823bfab82 Change mincore() to count "mapped" pages rather than
> "cached" pages
>
> --------------------------------------------------------------------------------
> Failed to build : 22065550c391 ARM: dts: bcm2835-rpi-zero-w: Drop
> unnecessary pinctrl
> Configuration: "multi_v7_defconfig, architecture arm".
>
>
> In file included from arch/arm/boot/dts/bcm2835.dtsi:2:0,
>                  from arch/arm/boot/dts/bcm2835-rpi-a.dts:3:
> arch/arm/boot/dts/bcm283x.dtsi:6:10: fatal error:
> dt-bindings/soc/bcm2835-pm.h: No such file or directory
>  #include <dt-bindings/soc/bcm2835-pm.h>
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [arch/arm/boot/dts/bcm2835-rpi-a.dtb] Error 1
>
> --------------------------------------------------------------------------------
> Failed to build : 22065550c391 ARM: dts: bcm2835-rpi-zero-w: Drop
> unnecessary pinctrl
> Configuration: "bcm2835_defconfig, architecture arm".
>
> It looks like commit "ARM: bcm283x: Switch V3D over to using the PM
> driver instead of firmware." is failing here and we should also have
> "soc: bcm: bcm2835-pm: Add support for power domains under a new
> binding." present as a preriquisite to build this branch.
>
> Alternatively, if you prefer to put "ARM: bcm283x: Switch V3D over to
> using the PM driver instead of firmware." in your drivers pull request,
> that might work too.
>
> I have kept pull request 2 and 3 applied for now, let me know how you
> want to proceed.

oh dear. I apologize for this crap. I thought that i tested this before.

Unfortunately none of your suggestions works without conflicts. All the
PM patches depend on each other. So my suggestion is to move all PM patches out of bcm2835-dt-next and apply the following on top of bcm2835-drivers-next:

ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block
ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

Would it be acceptable?

Thanks Stefan

 

