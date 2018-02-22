Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeBVQRE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:17:04 -0500
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:52114 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933130AbeBVQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:17:02 -0500
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
To: Mario.Limonciello@dell.com, notmart@gmail.com
Cc: pali.rohar@gmail.com, andriy.shevchenko@linux.intel.com,
        mjg59@srcf.ucam.org, dvhart@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos>
 <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
 <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
 <b9b9ad823d9e49df82fc4626124c2a14@ausx13mpc120.AMER.DELL.COM>
 <01000161be3d1072-1c155203-359c-4566-9af6-2ebc33ad43ee-000000@email.amazonses.com>
 <c7694c9b4780413cb9621b0f3dd1501d@ausx13mpc120.AMER.DELL.COM>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <01000161be4dbc6d-571d7479-35a2-4c6d-b3e0-f2405fc2064a-000000@email.amazonses.com>
Date: Thu, 22 Feb 2018 16:17:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c7694c9b4780413cb9621b0f3dd1501d@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2018.02.22-54.240.8.242
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 11:14 AM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Jeremy Cline [mailto:jeremy@jcline.org]
>> Sent: Thursday, February 22, 2018 9:59 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
>> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
>> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
>>
>> On 02/22/2018 10:21 AM, Mario.Limonciello@dell.com wrote:> I guess that
>> means we got this wrong and the patch should be reverted
>>> until we figure this out.
>>>
>>> Jeremy,
>>>
>>> Can you please confirm what BIOS version you are on?
>>> Also Is this a 9360 with 7th or 8th gen Intel CPU?
>>
>> Hi Mario,
>>
>> I've got BIOS version 2.5.0 with the 7th gen Intel CPU.
>>
>>
>> Regards,
>> Jeremy
> 
> Jeremy,
> 
> Thanks.  Do you have any of the Dell docks (TB16/WD15)?  If so are you connected to any dock 
> when reproducing this problem?

Mario,

I do have a TB16. I can reproduce this whether or not I'm connected to
the dock, though.


Regards,
Jeremy
