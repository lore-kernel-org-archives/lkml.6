Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeFANRq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:17:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46597 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeFANRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:17:09 -0400
X-Google-Smtp-Source: ADUXVKIE8aLX3vk7vS/kav2oEpy+zNinBhgqHs87eql/IqSmqjwa11v+j6WYwXgXUUjbfSpqf9s9UQ==
Subject: Re: [PATCH v2 1/3] ASoC: topology: Improve backwards compatibility
 with v4 topology files
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Chintan Patel <chintan.m.patel@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <groeck@chromium.org>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
Date: Fri, 1 Jun 2018 06:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601102506.GB8677@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 03:25 AM, Mark Brown wrote:
> On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
>> From: Guenter Roeck <groeck@chromium.org>
>>
>> Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
>> DAI") introduced sound topology files version 5. Initially, this
>> change made the topology code incompatible with v4 topology files.
> 
> No review on these from anyone at Intel?
> 

The only actionable feedback I have seen is that the header file
changes should be in uapi, which is done in patches 2 and 3.

Other than that, there was a question if this is a Linux issue or
a Chromebook issue (it appears that only Chromebooks shipped with
v4 configuration files). I took that as rhetorical since upstream
kernels (at least v4.4 and v4.5) support topology v4 configuration
files, and it should not matter which products shipped using those.

Guenter
