Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755180AbeBOJRv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:17:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54156 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbeBOJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:17:48 -0500
X-Google-Smtp-Source: AH8x225/NpQKqUbWRwCLtkVtARUIqa2Cqfc8P5ysPm6+eW/8fq5aOnQwCxaqv6b/yqhaiTY2g4GInA==
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
To: Carlo Caione <carlo@caione.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: Linux Upstreaming Team <linux@endlessm.com>, bardliao@realtek.com,
        oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Carlo Caione <carlo@endlessm.com>
References: <20180209142318.14451-1-carlo@caione.org>
 <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb4736e2-bcc0-c8da-efd9-7d5ea7f23d25@redhat.com>
Date: Thu, 15 Feb 2018 10:17:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-02-18 10:11, Carlo Caione wrote:
> On Fri, Feb 9, 2018 at 2:23 PM, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
>> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
>> the rt5645 driver to enable the jack detection also on non-DT platforms.
> 
> Please do not merge this yet, I'll submit a V3 soon.
> Hans pointed out that on some BayTrail there is indeed an extra GPIO
> but it is used to enable the external speaker amplifier. Better to
> guard this by a quirk.

Thank you Carlo, note that the tablet I was talking about is a rt5651 based
tablet, but yes you never know for what reasons someone will put an extra
GPIO in the resources table, so guarding this with a quirk seems like a good
idea.

Regards,

Hans
