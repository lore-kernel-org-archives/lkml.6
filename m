Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeCEWW5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:22:57 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.126]:15202 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753053AbeCEWWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:22:55 -0500
Subject: Re: [PATCH] netfilter: ipt_ah: return boolean instead of integer
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180213142557.GA9008@embeddedor.com>
 <20180305221027.vmailsqb5gkvxmcg@salvia>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <c61aff0b-8255-e769-f150-83f3908e6690@embeddedor.com>
Date: Mon, 5 Mar 2018 16:22:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305221027.vmailsqb5gkvxmcg@salvia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.245.224
X-Source-L: No
X-Exim-ID: 1esyVS-002SPy-Bx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net ([192.168.15.106]) [187.162.245.224]:59312
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2018 04:10 PM, Pablo Neira Ayuso wrote:
> On Tue, Feb 13, 2018 at 08:25:57AM -0600, Gustavo A. R. Silva wrote:
>> Return statements in functions returning bool should use
>> true/false instead of 1/0.
>>
>> This issue was detected with the help of Coccinelle.
> This one didn't get in time for the previous merge window.
>
> Now applied, thanks.
Great.
Thanks, Pablo.
--
Gustavo
