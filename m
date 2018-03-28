Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeC1QdI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:33:08 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:43339 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeC1QdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:33:06 -0400
X-Google-Smtp-Source: AIpwx48BbYr0Rp0DfZdX3GfvzUy61FhEemrupCirEvM8fANfqRzRtZ9f9Q/EAffqN6Q19jdT9vs0og==
Subject: Re: [PATCH] x86, msr: fix rdmsrl_safe_on_cpu()
To: Borislav Petkov <bp@alien8.de>, Eric Dumazet <edumazet@google.com>
Cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
References: <20180328032233.153055-1-edumazet@google.com>
 <20180328100844.GA20533@pd.tnic>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fa5f8441-5734-a2be-defc-c28fc3269a36@gmail.com>
Date: Wed, 28 Mar 2018 09:33:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328100844.GA20533@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/28/2018 03:08 AM, Borislav Petkov wrote:

> I guess now that the rdmsr* side does this, you probably should convert
> the wrmsr* side as well.

Yes indeed, thanks for the reminder.
