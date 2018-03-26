Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeCZHLV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:11:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750864AbeCZHLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:11:20 -0400
Subject: Re: [PATCH] MAINTAINERS: vfio-platform: Update sub-maintainers
To: Alex Williamson <alex.williamson@redhat.com>,
        Alvise Rigo <a.rigo@virtualopensystems.com>
References: <20180323175929.15319-1-a.rigo@virtualopensystems.com>
 <20180323135944.54bb75c1@t450s.home>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3692bd04-52bb-d87b-a57c-2a0113c47fcb@redhat.com>
Date: Mon, 26 Mar 2018 09:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180323135944.54bb75c1@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 23/03/18 20:59, Alex Williamson wrote:
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
>> @@ -14688,7 +14688,8 @@ F:	include/linux/mdev.h
>>  F:	samples/vfio-mdev/
>>  
>>  VFIO PLATFORM DRIVER
>> -M:	Baptiste Reynal <b.reynal@virtualopensystems.com>
>> +M:	Alvise Rigo <a.rigo@virtualopensystems.com>
>> +M:	Eric Auger <eric.auger@redhat.com>
>>  L:	kvm@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/vfio/platform/
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

No objection from me.

Thanks

Eric
> 
> Alex
> 
