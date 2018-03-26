Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeCZIBU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:01:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39637 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeCZIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:01:18 -0400
X-Google-Smtp-Source: AIpwx4+NCICotxWgHIbYXaWlqZivjZgOJsTDSeohP5omnyljSsxxDRMoyO2arM+aP3MBDSvnaBmrt3v1IHnb9DuSYJ4=
MIME-Version: 1.0
X-Originating-IP: [80.15.154.113]
In-Reply-To: <20180323135944.54bb75c1@t450s.home>
References: <20180323175929.15319-1-a.rigo@virtualopensystems.com> <20180323135944.54bb75c1@t450s.home>
From: Alvise Rigo <a.rigo@virtualopensystems.com>
Date: Mon, 26 Mar 2018 10:01:01 +0200
Message-ID: <CAH47eN3XvOxoqaht2_7sSXfrh+OWJQ=osx8_DRazBK_RA3M=aw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: vfio-platform: Update sub-maintainers
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, Auger Eric <eric.auger@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 8:59 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Fri, 23 Mar 2018 18:59:29 +0100
> Alvise Rigo <a.rigo@virtualopensystems.com> wrote:
>
>> Update the sub-maintainer entry as Baptiste has moved.
>>
>> Add me and Eric Auger as sub-maintainers of the VFIO plaform driver.
>>
>> Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
>> ---
>>  MAINTAINERS | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 73c0cdabf755..9619c41c2316 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14688,7 +14688,8 @@ F:    include/linux/mdev.h
>>  F:   samples/vfio-mdev/
>>
>>  VFIO PLATFORM DRIVER
>> -M:   Baptiste Reynal <b.reynal@virtualopensystems.com>
>> +M:   Alvise Rigo <a.rigo@virtualopensystems.com>
>> +M:   Eric Auger <eric.auger@redhat.com>
>>  L:   kvm@vger.kernel.org
>>  S:   Maintained
>>  F:   drivers/vfio/platform/
>
> Hi Alvise,
>
> Thanks for updating this file, I haven't heard from Baptiste for a long
> time and I already look to Eric as the de-facto sub-maintainer of vfio
> platform.  However, I don't have any experience with your reviews, nor
> do I see any commits in vfio platform or elsewhere in the kernel
> attributed to you.  I certainly welcome you on as a designated reviewer
> (ie. R:), but I would probably only consider Eric to be the
> sub-maintainer at this point.  Any objection, Eric?  Thanks,

Hello Alex,

Go on as you suggest, I don't have any objection.

Best regards,
alvise

>
> Alex
