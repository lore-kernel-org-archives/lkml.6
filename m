Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbeBAHcQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:32:16 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:46799 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:32:13 -0500
X-Google-Smtp-Source: AH8x225aBQTuBZfqun9z9bQdqaPFi6N184xctm69KPQu60BN0H+3e0rUR78h2CLYyzHV33rBZ6Fx5vcMarzKbodjTNg=
MIME-Version: 1.0
In-Reply-To: <fde756f4-eb74-4002-6ac4-a44405bad2da@codeaurora.org>
References: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
 <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org> <20180116214939.GC10860@bhelgaas-glaptop.roam.corp.google.com>
 <fde756f4-eb74-4002-6ac4-a44405bad2da@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2018 08:32:11 +0100
X-Google-Sender-Auth: 6BjeKe7DSySJTQFQ8BmTdLQ34F4
Message-ID: <CAJZ5v0jNVENRq-3QjF6nY9_5-0ff=6j_qneLqCQ57h6t1R4Fow@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 8:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Rafael,
>
> On 1/16/2018 4:49 PM, Bjorn Helgaas wrote:
>> On Tue, Jan 16, 2018 at 01:53:00PM -0500, Sinan Kaya wrote:
>>> Correcting linux-pci email.
>>>
>>> On 1/16/2018 1:51 PM, Sinan Kaya wrote:
>>>> When ACPI Link object is enabled, the message is printed with a warning
>>>> prefix. Some test tools are capturing warning and test error types as
>>>> errors. Let's reduce the verbosity of success case.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Looks like this was a result of 4d9391557b68 ("ACPI: add missing KERN_*
>> constants to printks"), which I think added the wrong level in this case.
>>
>
> Any chance of merging this for 4.16?

There is.

I've just got back home from travels and will be looking at patches to
pick up for 4.16 shortly.
