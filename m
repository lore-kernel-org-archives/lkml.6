Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeFEP2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:28:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57478 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbeFEP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:27:59 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a93212e3-7965-9ae2-34b0-407f04590567@arm.com>
Date: Tue, 5 Jun 2018 16:27:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/18 16:02, Rafael J. Wysocki wrote:
> On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Currently, ARM64 doesn't support updating the CPU topology masks on
>> CPU hotplug operations. ACPI PPTT support rely on that missing feature
>> which is technically not incorrect. Instead of reverting all the PPTT
>> support, let's keep it simple and disable ACPI PPTT support on ARM64
>> for time-being until the topology updates are added for CPU hotplug
>> operations.
> 
> When is that going to happen?
> > Nobody else uses PPTT now.
> 

No we need it on ARM64. I have even the fixes for the original issue
but it's bit invasive and too late as we are already in the merge
window. It needs to be tested on NUMA platforms, I have asked for that
explicitly.

-- 
Regards,
Sudeep
