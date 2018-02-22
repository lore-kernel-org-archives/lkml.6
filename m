Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBVTpI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:45:08 -0500
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:47884 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750916AbeBVTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:45:06 -0500
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
 <01000161be4dbc6d-571d7479-35a2-4c6d-b3e0-f2405fc2064a-000000@email.amazonses.com>
 <722a48c6c0354609bf34f86c4269aef9@ausx13mpc120.AMER.DELL.COM>
 <01000161be64cac2-b17509ef-f7e5-4134-9188-941d7f5ac687-000000@email.amazonses.com>
 <88473a72368b43bdacebca279092ab0f@ausx13mpc120.AMER.DELL.COM>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <01000161bf0c3bf3-3d6f8448-0bfd-40f6-bf2c-f7034ea47002-000000@email.amazonses.com>
Date: Thu, 22 Feb 2018 19:45:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <88473a72368b43bdacebca279092ab0f@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2018.02.22-54.240.8.242
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 12:05 PM, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
>> owner@vger.kernel.org] On Behalf Of Jeremy Cline
>> Sent: Thursday, February 22, 2018 10:42 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
>> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
>> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
>>
>> On 02/22/2018 11:17 AM, Mario.Limonciello@dell.com wrote:
>>>> -----Original Message-----
>>>> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
>>>> owner@vger.kernel.org] On Behalf Of Jeremy Cline
>>>> Sent: Thursday, February 22, 2018 10:17 AM
>>>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
>>>> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
>>>> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
>>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
>>>>
>>>> On 02/22/2018 11:14 AM, Mario.Limonciello@dell.com wrote:
>>>>>> -----Original Message-----
>>>>>> From: Jeremy Cline [mailto:jeremy@jcline.org]
>>>>>> Sent: Thursday, February 22, 2018 9:59 AM
>>>>>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; notmart@gmail.com
>>>>>> Cc: pali.rohar@gmail.com; andriy.shevchenko@linux.intel.com;
>>>>>> mjg59@srcf.ucam.org; dvhart@infradead.org; platform-driver-
>>>>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>>> Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
>>>>>>
>>>>>> On 02/22/2018 10:21 AM, Mario.Limonciello@dell.com wrote:> I guess that
>>>>>> means we got this wrong and the patch should be reverted
>>>>>>> until we figure this out.
>>>>>>>
>>>>>>> Jeremy,
>>>>>>>
>>>>>>> Can you please confirm what BIOS version you are on?
>>>>>>> Also Is this a 9360 with 7th or 8th gen Intel CPU?
>>>>>>
>>>>>> Hi Mario,
>>>>>>
>>>>>> I've got BIOS version 2.5.0 with the 7th gen Intel CPU.
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Jeremy
>>>>>
>>>>> Jeremy,
>>>>>
>>>>> Thanks.  Do you have any of the Dell docks (TB16/WD15)?  If so are you
>> connected
>>>> to any dock
>>>>> when reproducing this problem?
>>>>
>>>> Mario,
>>>>
>>>> I do have a TB16. I can reproduce this whether or not I'm connected to
>>>> the dock, though.
>>>>
>>>>
>>>> Regards,
>>>> Jeremy
>>>
>>> Jeremy,
>>>
>>> Can you try booting up from a cold boot with it connected to see if it still
>> happens?
>>>
>>
>> Mario,
>>
>> Yup, it still happens from a cold boot when connected to the dock.
> 
> OK thanks for confirming.  Here's what I've concluded:
> 
> * So looking through the ACPI tables on the 9360 it initializes that status
> (slate vs laptop mode) bit to "slate" mode.  The 9360 isn't a 2-in1- so that
> seems wrong to me, but that's what it does.
> It only gets updated based on dock status.
> 
> The 9365 (which is a 2 in 1) however seems to initialize the status properly.
> 
> So that's an impasse of what to do.
> It's not clear to me what is really happening:
> a) We're missing something else in this driver (eg something else that 
> indicates whether to trust VGBS output)
> 
> b) Mis-interpreting the results from it (we shouldn't report the switch for 
> tablet mode based on what we do)
> 
> c) 9360 has a BIOS bug (seems unlikely since Windows doesn't freak out and
> show virtual keyboard at wrong time)
> 
> I'm leaning on it's probably <a>.
> We should check for tablet mode should only be run if chassis type 
> matches 2-in-1 (chassis type 0x1F).  
> 
> I believe that should fix the problem on the 9360, let it continue to work on
> the 9365 (and other 2-in-1's).
> 
> Can you guys please test this?  If that works I'll split up the routine and submit
> it.
> 

Hi Mario,

There's one small error in the patch, after I fixed it, it works.
Thanks!

> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index b703d6f..07bc489 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
> @@ -102,6 +103,7 @@ static int intel_vbtn_probe(struct platform_device *device)
>         struct acpi_buffer vgbs_output = { ACPI_ALLOCATE_BUFFER, NULL };
>         acpi_handle handle = ACPI_HANDLE(&device->dev);
>         struct intel_vbtn_priv *priv;
> +       const char *chassis_type;
>         acpi_status status;
>         int err;
>  
> @@ -123,22 +125,24 @@ static int intel_vbtn_probe(struct platform_device *device)
>         }
>  
>         /*
> -        * VGBS being present and returning something means we have
> -        * a tablet mode switch.
> +        * Running on 2-in-1 chassis, VGBS being present and
> +        * returning something means we have a tablet mode switch.
>          */
> -       status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
> -       if (ACPI_SUCCESS(status)) {
> -               union acpi_object *obj = vgbs_output.pointer;
> +       chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
> +        if (chassis_type && strcmp(chassis_type, "31")) {This should be "chassis_type && strcmp(chassis_type, "31") == 0" since
strcmp returns 0 for equality.

> +               status = acpi_evaluate_object(handle, "VGBS", NULL, &vgbs_output);
> +               if (ACPI_SUCCESS(status)) {
> +                       union acpi_object *obj = vgbs_output.pointer;
>  
> -               if (obj && obj->type == ACPI_TYPE_INTEGER) {
> -                       int m = !(obj->integer.value & TABLET_MODE_FLAG);
> +                       if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +                               int m = !(obj->integer.value & TABLET_MODE_FLAG);
>  
> -                       input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
> +                               input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
> +                       }
>                 }
> +               kfree(vgbs_output.pointer);
>         }
> -       kfree(vgbs_output.pointer);
> -
>         status = acpi_install_notify_handler(handle,
>                                              ACPI_DEVICE_NOTIFY,
>                                              notify_handler,
> 

Regards,
Jeremy
