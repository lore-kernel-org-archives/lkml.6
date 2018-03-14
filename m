Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeCNITo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:19:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47496 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753589AbeCNITl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:19:41 -0400
Subject: Re: int3403_driver_init needs over 330 ms to finish
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
 <1521012744.2087.13.camel@intel.com>
From: Paul Menzel <pmenzel+linux-pm@molgen.mpg.de>
Message-ID: <6ce0b246-b2ba-c251-3506-df3e3b71da84@molgen.mpg.de>
Date: Wed, 14 Mar 2018 09:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521012744.2087.13.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rui,


On 03/14/2018 08:32 AM, Zhang Rui wrote:
> On 二, 2018-03-13 at 20:39 +0100, Paul Menzel wrote:

>> Booting the Dell XPS 13 9370 with Linux 4.16-rc4+ and
>> `initcall_debug`,
>> shows it is shown that int3403_driver_init needs over 330 ms to run.
>>
>>       [    2.524839] initcall int3403_driver_init+0x0/0x1000
>> [int3403_thermal] returned 0 after 333972 usecs
>>
> I guess most of the time are spent in evaluating ACPI ASL code.
> But anyway, please create a bugzilla report and attach both dmesg and
> acpidump there.

I created bug report #199113 [1], and attached the requested files.


Kind regards,

Paul


[1] https://bugzilla.kernel.org/show_bug.cgi?id=199113
