Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCNSXb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:23:31 -0400
Received: from gateway20.websitewelcome.com ([192.185.49.40]:29791 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751620AbeCNSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:23:30 -0400
Subject: Re: [PATCH v3] EDAC, sb_edac: Remove VLA usage
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313134449.GA24398@embeddedgus>
 <20180314180305.GI16605@pd.tnic>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <9af09f96-b381-88f1-3f69-0f4ab684aa36@embeddedor.com>
Date: Wed, 14 Mar 2018 13:23:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314180305.GI16605@pd.tnic>
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
X-Exim-ID: 1ewB3h-001v9m-6k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:38566
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/14/2018 01:03 PM, Borislav Petkov wrote:

[..]

>>   
>>   struct interleave_pkg {
>>   	unsigned char start;
>> @@ -1899,7 +1904,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
>>   	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
>>   	int			sad_interl, idx, base_ch;
>>   	int			interleave_mode, shiftup = 0;
>> -	unsigned		sad_interleave[pvt->info.max_interleave];
> 
> Where's the hunk removing ->max_interleave ?
> 

Oh. I forgot to remove it.

I already sent v4: https://patchwork.kernel.org/patch/10283289/

Thanks
--
Gustavo
