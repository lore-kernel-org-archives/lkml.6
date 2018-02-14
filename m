Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163014AbeBNT3v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:29:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:32591 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162999AbeBNT3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:29:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="20058356"
Subject: Re: [PATCH] platform/x86: intel_turbo_max_3: Remove restriction for
 HWP platforms
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180212195047.23671-1-srinivas.pandruvada@linux.intel.com>
 <CAHp75VdUnw0NjcNDKzFp-hZWho4A8RV=9Xthz-foZ6wTaT+Ftg@mail.gmail.com>
From: Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <7791d2f2-3a74-6dee-7055-feeaa6bbe2d8@linux.intel.com>
Date: Wed, 14 Feb 2018 11:29:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdUnw0NjcNDKzFp-hZWho4A8RV=9Xthz-foZ6wTaT+Ftg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 11:29 AM, Andy Shevchenko wrote:
> On Mon, Feb 12, 2018 at 9:50 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> On systems supporting HWP (Hardware P-States) mode, we expected to
>> enumerate core priority via ACPI-CPPC tables. Unfortunately deployment of
>> TURBO 3.0 didn't use this method to show core priority. So users are not
>> able to utilize this feature in HWP mode.
>>
>> So remove the loading restriction of this driver for HWP enabled systems.
>> Even if there are some systems, which are providing the core priority via
>> ACPI CPPC, this shouldn't cause any conflict as the source of priority
>> definition is same.
>>
> 
> Pushed to my review and testing queue, thanks!
> 
> P.S. Should it go to stable?

older stable at least did not have the problem
