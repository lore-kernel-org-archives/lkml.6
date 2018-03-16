Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965037AbeCPQO5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:14:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33260 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934677AbeCPQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:14:54 -0400
X-Google-Smtp-Source: AG47ELsGa33awudjubLDlRUHWXJJZSL2c0As+zwQTowBVQxfF8vSM82KBrrUwoyWuVz81fMieYyuKw==
Subject: Re: [PATCH v2] block: sed-opal: fix u64 short atom length
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
References: <1520379912.4178.83.camel@intel.com>
 <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20180316153808.bwhyhwxgne7oqtoh@sbauer-Z170X-UD5>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27d404ea-6aa1-6347-fc8d-a8fade43aae8@kernel.dk>
Date: Fri, 16 Mar 2018 09:14:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180316153808.bwhyhwxgne7oqtoh@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/18 8:38 AM, Scott Bauer wrote:
> On Wed, Mar 07, 2018 at 05:55:56PM +0100, Jonas Rabenstein wrote:
>> The length must be given as bytes and not as 4 bit tuples.
>>
>> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>> ---
>> v2:
>>   - use fls64
>>   - shorten loop body
>> ---
>>  block/sed-opal.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Scott Bauer <scott.bauer@intel.com>
> Tested-by: Scott Bauer <scott.bauer@intel.com>
> 
> Hi Jens,
> 
> When you get time can you apply this if you have no objections?

Done.

-- 
Jens Axboe
