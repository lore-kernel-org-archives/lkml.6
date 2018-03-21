Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeCUAiu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:38:50 -0400
Received: from www62.your-server.de ([213.133.104.62]:40061 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeCUAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:38:49 -0400
Subject: Re: [PATCH] kbuild: disable clang's default use of
 -fmerge-all-constants
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, psodagud@codeaurora.org,
        Network Development <netdev@vger.kernel.org>,
        Chenbo Feng <fengc@google.com>,
        Richard Smith <richard-llvm@metafoo.co.uk>,
        Chandler Carruth <chandlerc@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180321001824.8395-1-daniel@iogearbox.net>
 <CA+55aFw94wSeOvs1JO2iPHXgpwWQ-EF6v0XYwjFrQN1wr5tY-A@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bd7b0d23-519e-ca8b-a768-1440a4bc90d3@iogearbox.net>
Date: Wed, 21 Mar 2018 01:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFw94wSeOvs1JO2iPHXgpwWQ-EF6v0XYwjFrQN1wr5tY-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 01:36 AM, Linus Torvalds wrote:
> On Tue, Mar 20, 2018 at 5:18 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> Prasad reported that he has seen crashes in BPF subsystem with netd
>> on Android with arm64 in the form of (note, the taint is unrelated):
> 
> Ack. This looks good to me. And thanks for noticing the behavior wrt
> the correct gcc merging.
> 
>>  [ Hi Linus, feel free to take this fix directly if you want.
>>    Alternatively, we could route it via bpf tree. Thanks a
>>    lot for your feedback! ]
> 
> So since it's your patch and the only known issue comes from the bpf
> side, I think it should just go through the bpf tree, and I expect it
> to get to me through all the usual channels.

Yeah, that's fine, thanks for letting us know!

Best,
Daniel
