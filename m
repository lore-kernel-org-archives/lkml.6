Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755128AbeDQQnQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:43:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34837 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:43:13 -0400
X-Google-Smtp-Source: AIpwx4/CdJf/7ezw2QiD9wHmANJ1Bruy2DWqmJA3aPuEyvZ9d0KaNE37yfquTs5WDFqIVm07eN1TuA==
Subject: Re: [RFC PATCH v2 1/4] EDAC, GHES: Remove unused argument to
 ghes_edac_report_mem_error
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-2-mr.nuke.me@gmail.com> <20180417093656.GA18640@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <77318fdf-b6a6-9df4-1e1f-540e03357422@gmail.com>
Date: Tue, 17 Apr 2018 11:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180417093656.GA18640@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/17/2018 04:36 AM, Borislav Petkov wrote:
> On Mon, Apr 16, 2018 at 04:59:00PM -0500, Alexandru Gagniuc wrote:
> 
> <--- Insert commit message here.
> 
> A possible candidate would be some blurb about what commit removed the
> use of that first arg.

I didn't consider any commit message pork to be necessary when the
summary already explains the triviality of the change. I'll add it in
the next rev.

Thanks,
Alex

>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 2 +-
>>  drivers/edac/ghes_edac.c | 3 +--
>>  include/acpi/ghes.h      | 5 ++---
>>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
