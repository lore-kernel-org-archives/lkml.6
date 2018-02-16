Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755224AbeBPIvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:51:07 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35805 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755126AbeBPIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:51:05 -0500
X-Google-Smtp-Source: AH8x227+dON+ojRUJTmCrLGPWv0yt5LH6Q4ekxSkdA7FobQGLF3//mEGxSOEMcquVdWCeJOmOb3POD5ms5uQEVUkuGY=
MIME-Version: 1.0
In-Reply-To: <da070fa2-9678-5a53-6984-2f200ac93862@redhat.com>
References: <20180216082616.25084-1-carlo@caione.org> <da070fa2-9678-5a53-6984-2f200ac93862@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2018 09:51:04 +0100
X-Google-Sender-Auth: jP128vBLXyuNThDCQcIksURpms0
Message-ID: <CAJZ5v0hLa5O18OPnX9zke9F0PMNdyy+3wgAvT4GXBJGaqngTzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] power: supply: Fix AXP288 fallback when not needed
To: Hans de Goede <hdegoede@redhat.com>
Cc: Carlo Caione <carlo@caione.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 9:41 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 16-02-18 09:26, Carlo Caione wrote:
>>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
>> using the ACPI drivers for AC and battery when a native PMIC driver was
>> already present. While this is in general a good idea (because of broken
>> DSDT or proprietary and undocumented ACPI opregions for the ACPI
>> AC/battery devices) we have come across at least one CherryTrail laptop
>> (ECS EF20EA) shipping the AXP288 together with a separate FG controller
>> (a MAX17047) instead of the one embedded in the AXP288.
>
>
> Thank you for the new version. This looks good and surprisingly
> clean / small given amounts of warts surrounding this all.
>
> The entire series is:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Well, to be honest, I very much prefer it when changes are made to one
driver at a time.
