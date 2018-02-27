Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeB0OzX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:55:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbeB0OzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:55:22 -0500
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: jtoppins@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: prarit@redhat.com, Jon Masters <jcm@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astone@redhat.com, James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
 <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0f9d2d3-9029-1581-9330-807fab3b2d44@arm.com>
Date: Tue, 27 Feb 2018 14:55:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/18 14:28, Jonathan Toppins wrote:
>> 'only intended to be booted via ACPI' is a property of the system, not
>> of the OS. If you need this functionality for development, you can
>> append 'acpi=on' to the kernel command line via kconfig.
> 
> This is not for development this is for production rate shipping firmware.

Obvious question: if this is "production" firmware on systems which "do 
not support DT", what the hell is a non-trivial DT doing in there in the 
first place?

Robin.
