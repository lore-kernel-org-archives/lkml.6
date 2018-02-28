Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeB1KcU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:32:20 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42562 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeB1KcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:32:18 -0500
X-Google-Smtp-Source: AG47ELvilq82n1W2vBbDoIuhBThPSiPZiTmTx51eCsffSabebWE0Di6O5xEnVv3/FULLo+jrYEf6yH3BptSTolMfHrg=
MIME-Version: 1.0
In-Reply-To: <1519812442.10722.248.camel@linux.intel.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com>
 <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com> <CACi5LpMv_LB3wi7qn33b6mysdK_weki0YYsG0EkqPhR8FvFq5w@mail.gmail.com>
 <1519812442.10722.248.camel@linux.intel.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 28 Feb 2018 16:02:16 +0530
Message-ID: <CACi5LpM31cVtw1QKMaQXoc-Dq7twX_z-rZFth0WTGPHp2WJJCQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Toppins <jtoppins@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Al Stone <astone@redhat.com>, Jonathan Masters <jcm@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, rafael.j.wysocki@intel.com,
        Ingo Molnar <mingo@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 3:37 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-02-28 at 00:29 +0530, Bhupesh Sharma wrote:
>> On Tue, Feb 27, 2018 at 8:14 PM, Jonathan Toppins <jtoppins@redhat.com
>> > wrote:
>> > On 02/27/2018 07:40 AM, Bhupesh Sharma wrote:
>> > >
>
>> > For arm64 DT is suppose to *not* be the preferred method, yet still
>> > DT
>> > is preferred if the firmware provides both tables to the kernel.
>
>> However several arm64 products in embedded applications are still not
>> SBSA/SBBR compliant (and I have worked on a couple of such
>> implementations earlier) and still use bootloaders like u-boot (and
>> also closed-source implementations) which have no support for ACPI
>> currently and still rely on a DT to pass the system hardware
>> information to the kernel.
>
>> So far only open source implementation of a ACPI compliant firmware is
>> EDK2/UEFI which supports ACPI as the preferred boot method
>
> You mean for non-x86?

Yes the patch in discussion is for arm64. So my comments above are in
context to arm64.

>>  and I am
>> not sure if all u-boot/in-house firmware implementations are planned
>> to be ported over to EDK2/UEFI for embedded applications.
>
> Why do you need that? ACPI (if you are talking about ACPI only, w/o EFI)
> is supported in U-Boot for few x86 SoCs/platforms. Moreover, one of them
> had never been shipped with ACPI/EFI complaint services in firmware and
> ACPI layer is purely done in U-Boot.

AFAIK upstream arm64 u-boot doesn't support ACPI boot method for
armv8/arm64 yet.

Regards,
Bhupesh
