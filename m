Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEDLHf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:07:35 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43251 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:07:33 -0400
X-Google-Smtp-Source: AB8JxZq9GA1tBSqziAxZsISJaoP/NVv7Ub9DLZ734zoosXwLA5GxZaRRH27J3WI5leDg6HLhoKegeHUH6rkAcltNLws=
MIME-Version: 1.0
In-Reply-To: <882655ee-994a-1aaa-8efc-9e33fb3d7eff@amd.com>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
 <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com> <3734664.7VekyYX7C7@aspire.rjw.lan>
 <0afd036f-9526-f5c8-4bd6-87d145319370@amd.com> <CAJZ5v0iERzne0WNsEPVKN_PT1vwNfyqpoE_YiF33RmqLMryvhw@mail.gmail.com>
 <882655ee-994a-1aaa-8efc-9e33fb3d7eff@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 May 2018 13:07:31 +0200
X-Google-Sender-Auth: hJ20DOSONwMQlIt2MQ9MyD7oduM
Message-ID: <CAJZ5v0hHoyv0LaZrnm2eVfsEEr0OJiJYC=qQpPd0wnGWRuNvGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <Alexander.Deucher@amd.com>, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 12:23 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
>
> On 5/4/2018 3:45 PM, Rafael J. Wysocki wrote:
>> On Fri, May 4, 2018 at 12:09 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>>
>>>
>>> On 5/4/2018 3:36 PM, Rafael J. Wysocki wrote:
>>>> On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
>>>>> AMD SoC exposes clock for general purpose use. The clock registration
>>>>> is done in clk-st driver. The MMIO mapping are passed on to the
>>>>> clock driver for accessing the registers.
>>>>> The misc clock handler will create MMIO mappings to access the
>>>>> clock registers and enable the clock driver to expose the clock
>>>>> for use of drivers which will connect to it.
>>>>>
>>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>>> ---
>>>>> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
>>>>
>>>> Well, where's patch [1/2]?
>>>>
>>>
>>> It's here:
>>> https://patchwork.kernel.org/patch/10380207/
>>
>> So can you please send them both as a series with the same CC list,
>> add all of the relevant maintainers to that CC list and indicate whom
>> you expect to take care of these patches?
>>
>
> Ok sure, I will send both the patches to combined cc list from
> ./scripts/get_maintainer.pl for each patch.

It also would be good to add a cover letter with an outline of all of
the changes together.

Thanks,
Rafael
