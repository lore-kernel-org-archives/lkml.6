Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755268AbeBPIwV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:52:21 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55632 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755229AbeBPIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:52:19 -0500
X-Google-Smtp-Source: AH8x227hSg70E4E5j6jU41YK9D+xeSbE331D7tlm78nox7epsqfKfsyH8oONT0HrX/o5bq2o8GS9gw==
Subject: Re: [PATCH v2 0/3] power: supply: Fix AXP288 fallback when not needed
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Carlo Caione <carlo@caione.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
References: <20180216082616.25084-1-carlo@caione.org>
 <da070fa2-9678-5a53-6984-2f200ac93862@redhat.com>
 <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e1f34ae-54d3-8daf-e531-976f36f3cb07@redhat.com>
Date: Fri, 16 Feb 2018 09:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-02-18 09:51, Rafael J. Wysocki wrote:
> On Fri, Feb 16, 2018 at 9:41 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 16-02-18 09:26, Carlo Caione wrote:
>>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
>>> using the ACPI drivers for AC and battery when a native PMIC driver was
>>> already present. While this is in general a good idea (because of broken
>>> DSDT or proprietary and undocumented ACPI opregions for the ACPI
>>> AC/battery devices) we have come across at least one CherryTrail laptop
>>> (ECS EF20EA) shipping the AXP288 together with a separate FG controller
>>> (a MAX17047) instead of the one embedded in the AXP288.
>>
>>
>> Thank you for the new version. This looks good and surprisingly
>> clean / small given amounts of warts surrounding this all.
>>
>> The entire series is:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Well, to be honest, I very much prefer it when changes are made to one
> driver at a time.

I understand completely, Carlo can you do a v4 with the changes
Rafael requested please? Feel free to keep my Reviewed-by for the v4.

Regards,

Hans
