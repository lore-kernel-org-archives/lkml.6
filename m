Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559521736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfBROr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:47:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731769AbfBROrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:47:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EDED4B7DD1476A1272A;
        Mon, 18 Feb 2019 22:46:51 +0800 (CST)
Received: from localhost (10.47.94.189) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 22:46:48 +0800
Date:   Mon, 18 Feb 2019 14:46:34 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
CC:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael.tsuha@usp.br" <rafael.tsuha@usp.br>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD ->
 RESERVED
Message-ID: <20190218144634.00001d74@huawei.com>
In-Reply-To: <1550141494.9460.51.camel@analog.com>
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
        <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
        <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
        <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
        <20190126181321.1439e485@archlinux>
        <CA+U=DsqwVsXyaDiBa1VLUjWmEcGLCYfk3iVZ5h5xEAcqyrXgQw@mail.gmail.com>
        <CAOeBkLok_PJ-ZbHcTN-yc6+p-qb5RMMmALp4fOpfAr2cqRO5Ug@mail.gmail.com>
        <1550141494.9460.51.camel@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.94.189]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 10:51:49 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> On Mi, 2019-02-13 at 22:25 -0200, Rodrigo Ribeiro wrote:
> > [External]
> > 
> > 
> > Em ter, 29 de jan de 2019 às 07:10, Alexandru Ardelean <ardeleanalex@gmai  
> > l.com> escreveu:
> > >
> > > On Sat, Jan 26, 2019 at 8:13 PM Jonathan Cameron <jic23@kernel.org>  
> > wrote:  
> > > >
> > > > On Fri, 25 Jan 2019 22:14:32 -0200
> > > > Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
> > > >  
> > > > > Em sex, 25 de jan de 2019 às 21:46, Rodrigo Ribeiro
> > > > > <rodrigorsdc@gmail.com> escreveu:  
> > > > > >
> > > > > > Em sex, 25 de jan de 2019 às 06:20, Alexandru Ardelean
> > > > > > <ardeleanalex@gmail.com> escreveu:  
> > > > > > >
> > > > > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gm  
> > ail.com> wrote:  
> > > > > > > >
> > > > > > > > Remove the checkpatch.pl check:
> > > > > > > >
> > > > > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?  
> > > > > > >
> > > > > > > Hey,  
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Thanks for answering.
> > > > > >  
> > > > > > > A bit curios about this one.
> > > > > > > Are you using this chip/driver ?  
> > > > > >
> > > > > > No, I am just a student at USP (University of São Paulo) starting  
> > in Linux  
> > > > > > Kernel and a new member of the USP Linux Kernel group that has  
> > contributed  
> > > > > > for a few months.
> > > > > >  
> > > > > > > Thing is: the part is nearing EOL, and it could be an idea to  
> > be  
> > > > > > > marked for removal (since it's still in staging).
> > > > > > > But if there are users for this driver, it could be left around  
> > for a while.  
> > > > > >
> > > > > > This is my first patch in Linux Kernel, but if the driver will be  
> > removed, I  
> > > > > > can send a patch for another driver. Is there any driver that I  
> > can  
> > > > > > fix a style warning?  
> > > > >
> > > > > Maybe, one checkstyle patch is enough, right? Which drivers can I  
> > truly  
> > > > > contribute to?  
> > > >
> > > > How about the ad7150?  That one is still listed as production.
> > > > What do you think Alex, you probably have better visibility on the
> > > > status of these parts and their drivers than I do!
> > > >
> > > > (note I haven't even opened that one for a few years so no idea
> > > > what state the driver is in!)
> > > >  
> > >
> > > ad7150 is a good alternative.
> > > At a first glance over the driver it looks like it could do with some
> > > polish/conversions to newer IIO constructs (like IIO triggers, maybe
> > > some newer event handling mechanisms?).
> > > I'll sync with Stefan [Popa] to see about this stuff at a later point  
> > in time.  
> > >
> > > I'd also add here the adxl345 driver.
> > > This is mostly informational for anyone who'd find this interesting.
> > > There are 2 drivers for this chip, one in IIO
> > > [drivers/iio/accel/adxl345] and another one in
> > > "drivers/misc/adxl34x.c" as part of the input sub-system.
> > > What would be interesting here is to finalize the IIO driver [ I think
> > > some features are lacking behind the input driver], and make the input
> > > driver a consumer of the IIO driver.
> > >
> > > From my side, both these variants are fine to take on.
> > > The ad7150 is a good idea as a starter project, and the adxl one is
> > > more of a long-term medium-level project.
> > >
> > > Thanks
> > > Alex
> > >  
> > 
> > Hi Alex, thanks for suggestions.
> > 
> > I read the IIO trigger documentation 
> > (https://www.kernel.org/doc/html/v4.12/driver-api/iio/triggers.html) and
> > ask one question: What is the difference between events and triggers? 
> > They are sounds me same things.
> > 
> > I am trying to understand how to implement a IIO trigger by reading
> > the IIO Simple Dummy code but this driver does not implements IIO
> > triggers
> > but only IIO events. Is there a didactic example like IIO Simple Dummy
> > that implements IIO triggers?
> > 
> > Thanks
> > Rodrigo
> >   
> 
> Hi Rodrigo,
> 
> From what I know, IIO Events are not used for passing readings from devices
> to userspace, but rather out of bounds information such as crossing of
> voltage thresholds, proximity detection, motion detection, etc.
> Triggers are typically used to determine when valid data can be read from a
> device which is then stored in the buffer.
> 
> After a quick look over the AD7150, I think that using IIO events, might be
> the correct approach, since it is a proximity sensing device. 

To answer the question on generic triggers (agreed, probably not relevant here
from what Stefan has said), there are several software triggers under
drivers/iio/triggers.

Wasn't a lot of point in adding another one to the dummy driver given you
can use the hrtimer, or sysfs triggers directly.
(loop will result in craziness given the near zero read time of the
dummy driver ;)

Jonathan

> 
> -Stefan
> 
> > > > Jonathan
> > > >  
> > > > >  
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > Em sex, 25 de jan de 2019 às 06:20, Alexandru Ardelean
> > > > > > <ardeleanalex@gmail.com> escreveu:  
> > > > > > >
> > > > > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gm  
> > ail.com> wrote:  
> > > > > > > >
> > > > > > > > Remove the checkpatch.pl check:
> > > > > > > >
> > > > > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?  
> > > > > > >
> > > > > > > Hey,
> > > > > > >
> > > > > > > A bit curios about this one.
> > > > > > > Are you using this chip/driver ?
> > > > > > >
> > > > > > > Thing is: the part is nearing EOL, and it could be an idea to  
> > be  
> > > > > > > marked for removal (since it's still in staging).
> > > > > > > But if there are users for this driver, it could be left around  
> > for a while.  
> > > > > > >
> > > > > > > Thanks
> > > > > > > Alex
> > > > > > >  
> > > > > > > >
> > > > > > > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > > > > > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > > > > > > ---
> > > > > > > > This macro is not used anywhere. Should we just correct the
> > > > > > > > spelling or remove the macro?
> > > > > > > >
> > > > > > > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/staging/iio/cdc/ad7152.c  
> > b/drivers/staging/iio/cdc/ad7152.c  
> > > > > > > > index 25f51db..c9da6d4 100644
> > > > > > > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > > > > > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > > > > > > @@ -35,7 +35,7 @@
> > > > > > > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > > > > > > >  #define AD7152_REG_CH2_SETUP           14
> > > > > > > >  #define AD7152_REG_CFG                 15
> > > > > > > > -#define AD7152_REG_RESEVERD            16
> > > > > > > > +#define AD7152_REG_RESERVED            16
> > > > > > > >  #define AD7152_REG_CAPDAC_POS          17
> > > > > > > >  #define AD7152_REG_CAPDAC_NEG          18
> > > > > > > >  #define AD7152_REG_CFG2                        26
> > > > > > > > --
> > > > > > > > 2.7.4
> > > > > > > >  
> > >   


