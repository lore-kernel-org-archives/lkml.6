Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeEOHAO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:00:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54563 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeEOHAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:00:12 -0400
Date: Mon, 14 May 2018 23:59:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180515065405.GA31240@gmail.com>
References: <20180507213755.GA32406@avx2> <20fb84fd5eef4c45b2d38d0290235d5d@AcuMS.aculab.com> <5c6762fe-5cbe-42ed-ac4e-a7144b8ef7ad@zytor.com> <83866d054b27419c9d9dd97d9c66c3de@AcuMS.aculab.com> <D6F6643E-1206-4D87-B8ED-5FF17C15A0EF@zytor.com> <20180515065405.GA31240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86: pad assembly functions with INT3
To: Ingo Molnar <mingo@kernel.org>
CC: David Laight <David.Laight@ACULAB.COM>,
        "'Alexey Dobriyan'" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
From: hpa@zytor.com
Message-ID: <E67F8616-B5D4-47E5-9017-A1B127C103EA@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2018 11:54:05 PM PDT, Ingo Molnar <mingo@kernel.org> wrote:
>
>* hpa@zytor.com <hpa@zytor.com> wrote:
>
>> > I guess it won't try to speculatively execute the 'pad'
>instructions - but you 
>> > can never really tell!
>> >
>> >	David
>> 
>> The CPU doesn't speculate down past an unconditional control
>transfer. Doing so 
>> would be idiotic.
>
>I think, when it comes to speculative execution, our general
>expectation that CPUs 
>don't do idiotic things got somewhat weakened in the past year or so
>...
>
>Thanks,
>
>	Ingo

Sort-of-kind-of... the things that have cropped up were reasonable consequences of designing under a set of assumptions which turned out to be incorrect. Speculating through an unconditional control transfer did not make sense under those assumptions either.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
