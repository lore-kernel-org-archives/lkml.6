Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeE3OQS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:16:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41368 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeE3OQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:16:16 -0400
X-Google-Smtp-Source: ADUXVKLzeEERElLFgBgnHxMB7MWWBbfFAZMap2R+G73+g2eix5X9JH5Wl7bEpE8tddTv39td7p24ZVeOzT1hyX7Mhco=
MIME-Version: 1.0
In-Reply-To: <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com> <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Wed, 30 May 2018 17:16:14 +0300
Message-ID: <CAAaskFAGRUU3APZbsY2w9hW9jbBJfeMbHt8ttg7vXHidp025=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
To: Josh Boyer <jwboyer@kernel.org>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        hmh@debian.org, Rudolf Marek <r.marek@assembler.cz>,
        suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is still not addressing the outdated 15h microcode version issue
that Rudolf Marek has pointed out. Also, we still hope to see an
updated microcode for 16h architecture as well - it has not received
any updates for two years already

Best regards,
Ivan Ivanov

2018-05-25 15:10 GMT+03:00 Josh Boyer <jwboyer@kernel.org>:
> On Thu, May 24, 2018 at 10:13 PM Sherry Hurwitz <sherry.hurwitz@amd.com>
> wrote:
>
>> * Processor Revision ID 0x00610f01 was accidently not included in the
> previous
>>    submitted microcode container file.
>> * Update the Version for family 15h microcode .bin file
>
>> Key Name        = AMD Microcode Signing Key (for signing microcode
> container files only)
>> Key ID          = F328AE73
>> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73
>
>> Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
>> ---
>>   WHENCE                                 |   2 +-
>>   amd-ucode/microcode_amd_fam15h.bin     | Bin 5356 -> 7876 bytes
>>   amd-ucode/microcode_amd_fam15h.bin.asc |  14 +++++++-------
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>
> Applied and pushed out.
>
> josh
