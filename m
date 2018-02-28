Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeB1KKQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:10:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:34961 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbeB1KKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:10:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="20900104"
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        astone@redhat.com, Jonathan Masters <jcm@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>, James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com>
 <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
 <CACi5LpMv_LB3wi7qn33b6mysdK_weki0YYsG0EkqPhR8FvFq5w@mail.gmail.com>
 <1519812442.10722.248.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <395d024f-b710-3626-f004-e069de0b812b@intel.com>
Date: Wed, 28 Feb 2018 11:10:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519812442.10722.248.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 11:07 AM, Andy Shevchenko wrote:
> On Wed, 2018-02-28 at 00:29 +0530, Bhupesh Sharma wrote:
>> On Tue, Feb 27, 2018 at 8:14 PM, Jonathan Toppins <jtoppins@redhat.com
>>> wrote:
>>> On 02/27/2018 07:40 AM, Bhupesh Sharma wrote:
>>> For arm64 DT is suppose to *not* be the preferred method, yet still
>>> DT
>>> is preferred if the firmware provides both tables to the kernel.
>> However several arm64 products in embedded applications are still not
>> SBSA/SBBR compliant (and I have worked on a couple of such
>> implementations earlier) and still use bootloaders like u-boot (and
>> also closed-source implementations) which have no support for ACPI
>> currently and still rely on a DT to pass the system hardware
>> information to the kernel.
>> So far only open source implementation of a ACPI compliant firmware is
>> EDK2/UEFI which supports ACPI as the preferred boot method
> You mean for non-x86?
>
>>   and I am
>> not sure if all u-boot/in-house firmware implementations are planned
>> to be ported over to EDK2/UEFI for embedded applications.
> Why do you need that? ACPI (if you are talking about ACPI only, w/o EFI)
> is supported in U-Boot for few x86 SoCs/platforms. Moreover, one of them
> had never been shipped with ACPI/EFI complaint services in firmware and
> ACPI layer is purely done in U-Boot.
>
Right, let alone Chromebooks. :-)
