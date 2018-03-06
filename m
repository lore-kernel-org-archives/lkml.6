Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeCFQuQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:50:16 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.91]:11623 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753785AbeCFQuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:50:14 -0500
Subject: Re: [PATCH] HID: hid-ntrig: use true and false for boolean values
To: Jiri Kosina <jikos@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180306000624.GA2680@embeddedgus>
 <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <28d2c1a8-2ef3-c8cb-6fed-b29bc4b68f0e@embeddedor.com>
Date: Tue, 6 Mar 2018 10:50:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1803061519430.15778@cbobk.fhfr.pm>
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
X-Exim-ID: 1etFn3-002SSu-KS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:56390
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 03/06/2018 08:20 AM, Jiri Kosina wrote:
> On Mon, 5 Mar 2018, Gustavo A. R. Silva wrote:
> 
>> Assign true or false to boolean variables instead of an integer value.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I've commited this (and the hid-multitouch variant of it as well) to
> for-4.17/upstream.
> 

Good to know.

Thanks
--
Gustavo
