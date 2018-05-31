Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbeEaONs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:13:48 -0400
Received: from ozlabs.org ([203.11.71.1]:42597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755093AbeEaONq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:13:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Josef Bacik <jbacik@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
In-Reply-To: <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com> <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com> <87h8mozajv.fsf@concordia.ellerman.id.au> <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
Date: Fri, 01 Jun 2018 00:13:44 +1000
Message-ID: <87zi0fyktj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>> ...
>> 
>> A change log is always nice even if it's short :)
>
> I tried, but really couldn't come up with anything more to write. I'll 
> try harder for v2 :)

Yeah true.

You could just say "All that's required is to define x and y and select
the Kconfig symbol".

>> This looks fine to me, it's probably easiest if it goes in via tip along
>> with patch 1.
>> 
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks for the review. I'll base v2 on -tip

I guess if it doesn't already apply to tip you should rebase it. You've
probably missed 4.18 anyway.

cheers
