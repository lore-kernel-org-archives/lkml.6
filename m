Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeDSOOz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:14:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48005 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752593AbeDSOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:14:52 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] Various fixes on STM32 RTC
Thread-Topic: [PATCH 0/4] Various fixes on STM32 RTC
Thread-Index: AQHT1+FlZLElADK3lkeeQ9oamAc10KQH93iAgAApNjA=
Date: Thu, 19 Apr 2018 14:14:17 +0000
Message-ID: <d2d1897e40834a1c84fc1e64309e2c3f@GPXDAG3NODE5.st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <20180419134321.GF7369@piout.net>
In-Reply-To: <20180419134321.GF7369@piout.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.122]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for that! I take note of your new email address. Thanks for your highlight.

Regards,
Amelie

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@bootlin.com]
> Sent: jeudi 19 avril 2018 15:43
> To: Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; linux-rtc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] Various fixes on STM32 RTC
> 
> Hi,
> 
> Both series were not sent to the correct email address. I would suggest
> rebasing on top of v4.17-rc1 ;). No need to resend just for that.
> 
> On 19/04/2018 15:21:39+0200, Amelie Delaunay wrote:
> > This series makes some corrections on STM32 RTC:
> > - update copyright and adopt SPDX identifier
> > - fix alarm interrupt flags
> > - rework DBP (Disable Backup domain Protection) management.
> >
> > This series is a preamble to the serie which will introduce next STM32
> > RTC version.
> >
> > Amelie Delaunay (4):
> >   rtc: stm32: fix copyright and adopt SPDX identifier
> >   rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
> >   dt-bindings: rtc: update stm32-rtc documentation for st,syscfg
> >     property
> >   rtc: stm32: get DBP register and mask from DT st,syscfg property
> >
> >  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 10 ++--
> >  drivers/rtc/rtc-stm32.c                            | 68 +++++++++++++---------
> >  2 files changed, 47 insertions(+), 31 deletions(-)
> >
> > --
> > 2.7.4
> >
> 
> --
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
