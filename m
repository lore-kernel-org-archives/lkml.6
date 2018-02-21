Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932077AbeBUJQM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:16:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:52733 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbeBUJQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:16:08 -0500
Subject: Re: [RFC PATCH tip] x86/acpi: u64_x86_init_noop() can be static
To: Ingo Molnar <mingo@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
 <20180220123819.GA20499@lkp-wsm-ep1>
 <20180221085148.rs3t7zad73wbpktm@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <bad54214-f182-d1ed-9593-3ffc66aa33b4@suse.com>
Date: Wed, 21 Feb 2018 10:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221085148.rs3t7zad73wbpktm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/18 09:51, Ingo Molnar wrote:
> 
> * kbuild test robot <fengguang.wu@intel.com> wrote:
> 
>>
>> Fixes: 62d8b7fba8d3 ("x86/acpi: Add a new x86_init_acpi structure to x86_init_ops")
>> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
>> ---
>>  0 files changed
> 
> -ENOPATCH?

I'll send a patch to add "static" to the noop functions of x86_init.c
(not only the new one).


Juergen
