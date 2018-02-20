Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeBTSJs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:09:48 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:45394 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751786AbeBTSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:09:46 -0500
Subject: Re: [PATCH] rds: send: mark expected switch fall-through in
 rds_rm_size
To: David Miller <davem@davemloft.net>, santosh.shilimkar@oracle.com
Cc: gustavo@embeddedor.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180219181020.GA19154@embeddedgus>
 <9b385269-7f13-983c-caf1-72e050acc6d9@oracle.com>
 <20180220.130157.1101637718168743475.davem@davemloft.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <66c0eda0-1863-4fb6-897c-c4e7abcdc344@embeddedor.com>
Date: Tue, 20 Feb 2018 12:09:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220.130157.1101637718168743475.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1eoCML-00414I-4H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:34514
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/20/2018 12:01 PM, David Miller wrote:
> From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Date: Tue, 20 Feb 2018 09:54:09 -0800
> 
>> So coverity greps for commet as "fall through" for
>> -Wimplicit-fallthrough build ?
> 
>  From what I understand, 'gcc' does in the latest versions.  Coverity
> might as well, I don't know.
> 

Yeah, the one that reports those warnings is GCC.

Coverity only knows about missing break, return and continue.

--
Gustavo
