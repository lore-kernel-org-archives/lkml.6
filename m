Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeDYPhv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:37:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:44210 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeDYPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:37:47 -0400
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with
 BPF_JIT_ALWAYS_ON config
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Leo Yan <leo.yan@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
 <a90e398e-c012-2630-6909-6d413e03cc96@iogearbox.net>
 <20180425092547.GA24401@leoy-ThinkPad-X240s>
 <20180425141435.bvolztivms25y2vt@ast-mbp>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <77bce91b-8d92-3be2-e4d1-abbb7f4cc2dd@iogearbox.net>
Date: Wed, 25 Apr 2018 17:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180425141435.bvolztivms25y2vt@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 04:14 PM, Alexei Starovoitov wrote:
> On Wed, Apr 25, 2018 at 05:25:47PM +0800, Leo Yan wrote:
>>
>> If we have concern for security issue, should we remove support for
>> 'bpf_jit_enable = 2' and modify the doc to reflect this change?
> 
> I suggest to fix the doc.

Agree, lets do that instead. Leo, could you cook a patch for that?

Thanks,
Daniel
