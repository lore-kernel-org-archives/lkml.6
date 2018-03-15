Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCOA76 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:59:58 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:55672 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeCOA75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:59:57 -0400
Subject: Re: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table()
 should not return (signed) int
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
 <20180314175824.GG16605@pd.tnic>
 <b913d9fd-9722-d5cc-cf94-426885947890@maciej.szmigiero.name>
 <20180314235812.GB11061@pd.tnic>
 <21fe4521-0fc7-c5ed-5a2a-4c7e93097385@maciej.szmigiero.name>
 <20180315005634.GC11061@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <cbb43e6b-17b2-22bd-b331-b23de4384523@maciej.szmigiero.name>
Date: Thu, 15 Mar 2018 01:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315005634.GC11061@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 01:56, Borislav Petkov wrote:
> On Thu, Mar 15, 2018 at 01:13:07AM +0100, Maciej S. Szmigiero wrote:
>> This can be done if this function is modified to return only the CPU
>> equivalence table length (without the container header length), leaving
>> its single caller the job of adding the container header length to skip
>> to the fist patch section.
> 
> Sure, it leaves the function to deal with the equiv table length only
> and the caller then adds the header length. Which is actually cleaner.
> 

OK, will do then.

Maciej
