Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCZBWP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:22:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49605 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZBWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:22:14 -0400
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
To: Borislav Petkov <bp@alien8.de>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Eric Dumazet <edumazet@google.com>,
        x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
 <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
 <20180325141242.GC21878@pd.tnic>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <69c614fb-5c3d-b1fb-99be-15dc8775483c@zytor.com>
Date: Sun, 25 Mar 2018 18:21:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325141242.GC21878@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/18 07:12, Borislav Petkov wrote:
> 
> So I'm wondering if poking at the hardware like that is a really optimal
> design. Maybe it would be cleaner if the OS would provide properly
> abstracted sysfs interfaces instead of raw MSRs. For a couple of
> reasons:
> 

It's most definitely not.

	-hpa
