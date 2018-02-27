Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeB0QQu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:16:50 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35372 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeB0QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:16:48 -0500
X-Google-Smtp-Source: AG47ELtaWXWNfdEGs7MRbTnMnESAsUV5xFgpoDoRs+tfuSw7vkbIBalQVMLSyhl7LF1I1/zmngBIXktvA8NThf4uFCM=
MIME-Version: 1.0
In-Reply-To: <92c22f39a7df439a9e18cb975eec086e@ausx13mpc124.AMER.DELL.COM>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
 <1519747014-17561-3-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcNWo0Mh8jYU0vV+RRt3ZudKns_ZStcp_7ueebJfwL_nQ@mail.gmail.com> <92c22f39a7df439a9e18cb975eec086e@ausx13mpc124.AMER.DELL.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 18:16:46 +0200
Message-ID: <CAHp75VchPrF8ndHck9pzjOOScTS627x9TFLsnr+LWxiwTgck9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: Darren Hart <dvhart@infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 6:13 PM,  <Mario.Limonciello@dell.com> wrote:

>> > --- a/drivers/platform/x86/dell-smbios.h
>> > +++ b/drivers/platform/x86/dell-smbios.h
>> > @@ -75,4 +75,10 @@ int dell_laptop_register_notifier(struct notifier_block
>> *nb);
>> >  int dell_laptop_unregister_notifier(struct notifier_block *nb);
>> >  void dell_laptop_call_notifier(unsigned long action, void *data);
>> >
>> > +/* for the supported backends */
>> > +int init_dell_smbios_wmi(void);
>> > +void exit_dell_smbios_wmi(void);
>> > +int init_dell_smbios_smm(void);
>> > +void exit_dell_smbios_smm(void);
>> > +
>>
>> ...here...
>
> So do you mean you would rather see inline functions in header
> file for the #else case then?

At least is sounds as a standard practice to me.

-- 
With Best Regards,
Andy Shevchenko
