Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161652AbeBNSCF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:02:05 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161544AbeBNSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:02:03 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Richard Weinberger <richard@sigma-star.at>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <60748622.exvCVAzLTp@blindfold>
 <e924b563-44c6-d678-a6cc-1181f4b820d5@metux.net>
 <4042675.OEy7g9C5ya@blindfold>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <794929ce-0ecb-4c93-d51e-e94fcf749cfa@metux.net>
Date: Wed, 14 Feb 2018 19:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <4042675.OEy7g9C5ya@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ve0gzImg7RMLEg6fPs1Ba4ZqeeFqMZZWF3io84BRaJkpo16ExVm
 jeamxS0jMUQaX3OgIscQeLhLm/N7qJc2SXNaXq42N/pL7ulH78xGgDJvSGR4u7WwFci9bJQ
 hdtq324nfjKR1Bvb5uCV0GLIKpbUpG0pWzZlXA9qKjdpQD4QBKHM0CmML60ItgT82Mlnwqx
 er3fzZDHN92Ym9QhtmEBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mkujkgM84l0=:HB0YthkJeeX6/OqkojD8mF
 Ibv/VS3MWFa3OQbLKdTx8+y8HzIPhQcj4EPOQ3j91GibRDA4L0CtvjlKdEVCVHIeKOoypEh9A
 OOhaiYEDgpP+qJlZ8t2MkYWBx7mAb5TjXxs8cRX5xC/CpNMFinr/w0sDVndblYwTpePHL4vFO
 z2dJRXobhScQjXeRE6nCgiyHlvNg+5rUhLW8QCgxPjR1x/JGtKGnJCnZ9vYoaaFYIB7TqZEes
 XrjMQgXh5ien7q2QvaPpeDkIsmR/5/eqPXRDuUHaoCrsx5+1kT/0KgVceZK6I4TbNZEqdtCQd
 odt9v2Ufu40w/RaVqpRCr5jdIBsDclAScCIDI114+164NTsUY1JxIEryceRkzxjR/nBmr+pPl
 RDJho/7Y0CmvDVqT/x5dX8DgXn2EBMmncNQGFgHbeCVprwW2uYT+4tNkhHi8zv9YexrlEQL8G
 M1Ru4a/kQk5S1DrMSD/UAaLAGVyMasQQyu3vLoZ17wbLRbSZ5bqhkX3Y0utLXsCRSJKcVmo0S
 qlDqERoYlJnGsWvhXU6l/NIZB0dLwu7U9d3fzqxUV3Bpbv2xoXMQY+UXbC55o1H7NFukBNXiT
 NAK6LKTBuMen6Mv/GI/gIu68+TPqAQvYRJuITtjhCQ5/3gjvv13csQk2eD8y4579cG9CklwzG
 oEzi6pHe1V5mTo6MAHwL2t0TJjHSfOYVFeRvgYGPaZPSvsSWoXSUe/bc9vGbd+hKT2VgwHK9H
 MThNovyrKLIwEuxt/4o2sOI0ko+Tbwc8xbjqr5g7jcniMY9GiManUjKnVvs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 18:50, Richard Weinberger wrote:

>> hmm, now it works, but only when strace'ing it.
>> that's really strange.
> 
> On my box, with my patch applied, also busybox works now.

hmm, w/o strace, too ?
Which version are you using ? I've got 1.27.2

>> But still I wonder whether user_ns really solves my problem, as I don't
>> want to create sandboxed users, but only private namespaces just like
>> on Plan9.
> 
> Well, I'd be surprised if that works out of the box.
> Since you're posting on LKML I assumed you're hacking the kernel to support
> plan9-alike namespaces...

Yes, that's the plan :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
