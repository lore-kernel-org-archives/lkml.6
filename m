Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeFAPUC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:20:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:62288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeFAPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:19:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="59571926"
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
Date: Fri, 1 Jun 2018 10:19:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/18 8:17 AM, Guenter Roeck wrote:
> On 06/01/2018 03:25 AM, Mark Brown wrote:
>> On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
>>> From: Guenter Roeck <groeck@chromium.org>
>>>
>>> Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
>>> DAI") introduced sound topology files version 5. Initially, this
>>> change made the topology code incompatible with v4 topology files.
>>
>> No review on these from anyone at Intel?
>>
> 
> The only actionable feedback I have seen is that the header file
> changes should be in uapi, which is done in patches 2 and 3.
> 
> Other than that, there was a question if this is a Linux issue or
> a Chromebook issue (it appears that only Chromebooks shipped with
> v4 configuration files). I took that as rhetorical since upstream
> kernels (at least v4.4 and v4.5) support topology v4 configuration
> files, and it should not matter which products shipped using those.

I wanted to ack this patch but the Intel validation folks asked for a 
couple of days to finish their tests on a variety of Chromebooks (e.g. 
Lars) and double-check which models used the v4 topology. There is an 
internal thread on all this which remains active. I don't think the 
feedback will be delayed beyond early next week.
