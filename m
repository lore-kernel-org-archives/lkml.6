Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeEHPuB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:50:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60308 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbeEHPuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:50:00 -0400
Subject: Re: [PATCH v2 12/27] coresight: tmc-etr: Allow commandline option to
 override SG use
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-13-git-send-email-suzuki.poulose@arm.com>
 <20180503204035.GA15555@xps15>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <3610e97f-87aa-3bfe-c89d-161a6bd09047@arm.com>
Date: Tue, 8 May 2018 16:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503204035.GA15555@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/18 21:40, Mathieu Poirier wrote:
> On Tue, May 01, 2018 at 10:10:42AM +0100, Suzuki K Poulose wrote:
>> The Coresight TMC-ETR SG mode could be unsafe on a platform where
>> the ETR is not properly connected to account for READ operations.
>> We use a DT node property to indicate if the system is safe.
>> This patch also provides a command line parameter to "force"
>> the use of SG mode to override the firmware information.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Hi
>>
>> This is more of a debug patch for people who may want to
>> test their platform without too much of hacking. I am not
>> too keen on pushing this patch in.
> 
> I am not either nor do I personally need it to test this feature.  We can leave
> it in for now (and subsequent version) if you need it but we agree that I won't
> queue it to my tree when the time comes.

OK, I was expecting this view from most of us here. I will drop it from my series in
the next version.

Cheers
Suzuki
