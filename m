Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeE1Ive (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:51:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18886 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753994AbeE1Ivb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:51:31 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40437598"
Subject: Re: [PATCH 0/1] Remove the check of duplicate processors
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180517094658.18707-1-douly.fnst@cn.fujitsu.com>
 <CAJZ5v0hpEf3gxfAtfufGQVyGEWoszMfEciNKiYf0TrUWNXtiuQ@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <3ee08a02-31b0-e993-e236-6eea1f9d4002@cn.fujitsu.com>
Date: Mon, 28 May 2018 16:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hpEf3gxfAtfufGQVyGEWoszMfEciNKiYf0TrUWNXtiuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: A05554B40405.AA64C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

At 05/28/2018 04:40 PM, Rafael J. Wysocki wrote:

> 
> Can you please resend the patch with the above information in the
> changelog of it?

Yes, I resend the patch right now.

> 
> That would make it easier to review and discuss it.
> 
> Also I think that we need some sort of a check against duplicate IDs.
>

Thanks,
	dou
> 
> 
