Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeCPOvB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:51:01 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36155 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeCPOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:50:56 -0400
X-Google-Smtp-Source: AG47ELs20zY0OBqvUwybZLoFTz/9sZBgzc4Gsa/14itxu02qRRNMbJdgHGsJdsLkFfOfdvJY5X98OQ==
Subject: Re: [PATCH v5 1/3] x86/msr: Add AMD Core Perf Extension MSRs
To: Radim Krcmar <rkrcmar@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
 <7cf7bd5fa6d24cd46a9ea50024b0010bf3d01088.1517850303.git.Janakarajan.Natarajan@amd.com>
 <20180306210338.GD12128@flask>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <150643f7-b464-0bd0-6ae8-6403b4d34700@redhat.com>
Date: Fri, 16 Mar 2018 15:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306210338.GD12128@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 22:03, Radim Krcmar wrote:
>>  /* Fam 15h MSRs */
>>  #define MSR_F15H_PERF_CTL		0xc0010200
>> +#define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
>> +#define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
>> +#define MSR_F15H_PERF_CTL2		(MSR_F15H_PERF_CTL + 4)
>> +#define MSR_F15H_PERF_CTL3		(MSR_F15H_PERF_CTL + 6)
>> +#define MSR_F15H_PERF_CTL4		(MSR_F15H_PERF_CTL + 8)
>> +#define MSR_F15H_PERF_CTL5		(MSR_F15H_PERF_CTL + 10)
>> +
>>  #define MSR_F15H_PERF_CTR		0xc0010201
>> +#define MSR_F15H_PERF_CTR0		MSR_F15H_PERF_CTR
>> +#define MSR_F15H_PERF_CTR1		(MSR_F15H_PERF_CTR + 2)
>> +#define MSR_F15H_PERF_CTR2		(MSR_F15H_PERF_CTR + 4)
>> +#define MSR_F15H_PERF_CTR3		(MSR_F15H_PERF_CTR + 6)
>> +#define MSR_F15H_PERF_CTR4		(MSR_F15H_PERF_CTR + 8)
>> +#define MSR_F15H_PERF_CTR5		(MSR_F15H_PERF_CTR + 10)
>> +
> x86 maintainers,
> 
> are you ok with this going through the kvm tree?

Boris, can you ack these new MSRs?

Thanks,

Paolo
