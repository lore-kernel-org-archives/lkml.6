Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEQUxR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:53:17 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.229]:14323 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751626AbeEQUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:53:16 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 0/2] bpf: sockmap, fix uninitialized variable and
 double-free
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526565461.git.gustavo@embeddedor.com>
 <b429e5e5-12cb-e05f-f9d9-1f4d1d066428@iogearbox.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1ca692d8-081a-7645-dcfd-95d9ecc656f5@embeddedor.com>
Date: Thu, 17 May 2018 15:53:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b429e5e5-12cb-e05f-f9d9-1f4d1d066428@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.93
X-Source-L: No
X-Exim-ID: 1fJPtj-001V3r-9g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-93.static.axtel.net ([192.168.15.106]) [187.162.252.93]:33606
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 05/17/2018 03:51 PM, Daniel Borkmann wrote:
> On 05/17/2018 04:04 PM, Gustavo A. R. Silva wrote:
>> This patchset aims to fix an uninitialized variable issue and
>> a double-free issue in __sock_map_ctx_update_elem.
>>
>> Both issues were reported by Coverity.
>>
>> Thanks.
>>
>> Gustavo A. R. Silva (2):
>>    bpf: sockmap, fix uninitialized variable
>>    bpf: sockmap, fix double-free
>>
>>   kernel/bpf/sockmap.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Applied to bpf-next, thanks Gustavo!
> 

Glad to help. :)

> P.s.: Please indicate that next time in the email subject via '[PATCH bpf-next]'.
> 

OK. Will do that.

Thanks
--
Gustavo
