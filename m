Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeCCN7e convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 08:59:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:55323 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeCCN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 08:59:33 -0500
Date: Sat, 3 Mar 2018 14:58:45 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Schake <stschake@gmail.com>
Message-ID: <166274019.307112.1520085525833@email.1und1.de>
In-Reply-To: <20180214202454.6e7ebeaf@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:DZQbqeU5p7EFyoVJCOLpPyciAHYp2ElL0/f0EvGbNzne9BGege7
 a0xWBPW+2H8OkzxLjUvYqiOHZsSeoYfsXLY8fHMESyAKRXBFmMWKSdcaOmu83muc3CM8CwO
 GTtWjxydipLDxQEftHkuRaBcIf7kUs/0NYHQooF0Lg4Cc7cRi0f6uvERRts/L5ql+vH0Dnt
 CZ5Z1ziz8zAz+aHLUGEDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eWHaWAa8YbA=:LlQlCCKbODIzYKCd2VcXHw
 Hq+fbgjmUK/mCgf76XJX1TWQz7wDCuCc2MSN6OgfHOw5iKIkVT8rz5TQj7vB1wukrmbp298kO
 uaMCdYVTkwiVeYL9dagT/Tv47NKnsPynsi68Q5KjaEs4L4K9avgPWOOjyv13QS7Uir+4qieb6
 CPjKZ0ep6tiXhh5rtdll/BDwchu3vbX3GofWLedtChQEL53Djv5/pM7wM7Wm6V+VDPYNIedVR
 BV0NcTqK3chA8YSi+5gWVA3kZvz84Ip3HbeIQcuYOMYoG3hDBKIEJj3sXF+hXsiXFhphHjeFC
 n5cq24OpitOWm1gOXjFkZ4K+8daAfZj0YFYc4FSJ67C4HjatchEdnEQ0MXgkDpucySoaZA1YF
 kk6GoSUBd816ls1UypkIBfHExKpTcOoEQnyV0jG2R30wSiuhtdEzK5yd7S7ZbK2xAcXu90SfM
 lQQ/6JbcL9Hxtb6vJz80CKYLv38KShjpZ5NZeF8PGoIA72KTZoe4G3FbQ5oCqhgmh5mOgV5kw
 RePflBLEz0fiLiLIuzNkhXCSC7/nJXqzh4A6bZ5XsVqI4LCq2EtLdttJjao+TBhtr4kziNM0X
 iJ2Y3AkLaaPt/l+Ki6LvcTNGqBCEUukbz3sTNvQ+SLWzdR5eeagL+BJGrTDd7O6ZPh6AHddOf
 c1RO6NAbWLxt1oaaehUPz2ikBkgf6mhH39lkbZuJIf1vypljSP3sA8CJ90tB9IfYdR4ovbXZp
 ZcyiEzs8YGBx95ucvu0Bf2FDzhUYZh6AXi62dtUkDidIUObovc6It8Pg6i4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

[add Stefan to CC]

> Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um 20:24 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 17:49:31 +0100
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Michal,
> > 
> > [add Phil]
> > 
> > Am 14.02.2018 um 17:13 schrieb Michal Suchánek:
> > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > Michal Suchánek <msuchanek@suse.de> wrote:
> > >  
> > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >>  
> > >>> Hi Michal,
> > >>>
> > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:    
> > >>>> The bcm2835 mmc host tends to lock up for unknown reason so reset
> > >>>> it on timeout. The upper mmc block layer tries retransimitting
> > >>>> with single blocks which tends to work out after a long wait.
> > >>>>
> > >>>> This is better than giving up and leaving the machine broken for
> > >>>> no obvious reason.      
> > >>> could you please provide more information about this issue
> > >>> (affected hardware, kernel config, version, dmesg, reproducible
> > >>> scenario)? 
> > > It tends to reproduce when upgrading a few packages with zypper and
> > > otherwise at random during system operation. It seems that for my
> > > card it worsens with age to some degree so perhaps it depends on the
> > > fragmentation of the internal card flash.
> > >
> > > Attaching dmesg and kernel config.  
> > 
> > do you noticed this issue before 4.15-rc4?
> 
> I initially noticed it with 4.4 kernel with some backports to make it
> bootable on RPi.
> > 
> > Could you please test with 4.15 final again?
> 
> Right, I can apply the patches on something more recent.
> 
> > 
> > What kind of SD card (name) triggers the issue?
> 
> Samsung EVO MB-MP16D
> 
> Also see https://elinux.org/RPi_SD_cards#Which_SD_card.3F
> 
> Thanks
> 
> Michal
> 

yesterday i finished my stress tests with Raspberry Pi 3.

Scenario:
- copy Tumbleweed on SD card (openSUSE-Tumbleweed-ARM-JeOS-raspberrypi3.aarch64-2018.02.02-Build1.2.raw, Linux 4.14.15)
- setup locales with yast
- run zypper update
- reboot
- install and remove java 1.8 in a loop for at least 1 hour

Results of the different SD cards:
Toshiba uSDHC Class 10 UHS-1 32 GB: PASS
BASETech uSDHC Class 10 16 GB: PASS
Samsung uSDHC EVO+ UHS-1 16 GB: PASS
Samsung uSDHC Class 6 32 GB: PASS
SanDisk Edge Class 4 16 GB: PASS
Kingston uSDHC Class 10 UHS-1 32 GB: PASS
QUMOX uSDHC Class 10 UHS-1 16 GB: FAIL (zypper segfaulted permantently)
Transcend uSDHC Class 10 UHS-1 32 GB: PASS

I was never able to reproduce this timeout. So i still need the feedback about the 4.15 and i a reliable test scenario.

In a github issue, i've read that badblocks could reproduce the issue more likely.

Regards
Stefan
