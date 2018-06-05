Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeFEQer (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:34:47 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37175 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeFEQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:34:45 -0400
X-Google-Smtp-Source: ADUXVKK9gMhD7XwyQrp38WPchKo9pc/bsXhjlHR7JX8MvFzZbQLxMrLmCMyVwJ8VHjs0eFRsbYwknhjqRsxIQ3Alwpk=
MIME-Version: 1.0
In-Reply-To: <54785881-da7c-db68-c6a4-70cfd489c1fe@arm.com>
References: <1526898749-17263-1-git-send-email-sudeep.holla@arm.com>
 <1526907189-10031-1-git-send-email-sudeep.holla@arm.com> <CAHp75Vd_rQFX1s6jCbj-uLC3K70sSD=s0rt3sWme_f2m90NE5A@mail.gmail.com>
 <54785881-da7c-db68-c6a4-70cfd489c1fe@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 19:34:43 +0300
Message-ID: <CAHp75Vcf5dbcbu-mCeWX7N98HU-hDaOniEXHMuoCGp4yZyAgPg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: base: cacheinfo: use OF property_read_u32
 instead of get_property,read_number
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:26 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 05/06/18 17:21, Andy Shevchenko wrote:
>> On Mon, May 21, 2018 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> of_property_read_u32 searches for a property in a device node and read
>>> a 32-bit value from it. Instead of using of_get_property to get the
>>> property and then read 32-bit value using of_read_number, we can
>>> simplify it by using of_property_read_u32.
>>>
>>
>> LGTM.
>> Thanks!
>>
>
> Thanks, can I take is Ack ?
>
> Anyways it's too late for v4.18, will repost after the merge window for
> v4.19 with your Ack if you agree.

You can consider like this, though it makes a little change here since
I'm not a maintainer of the code.

-- 
With Best Regards,
Andy Shevchenko
