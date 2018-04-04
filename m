Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeDDTBJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:01:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:55747 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeDDTAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="44917952"
Subject: Re: [alsa-devel] [PATCH v4 0/3] ASoC: topology: Improve hw_configs
To: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <20180404041939.23317-1-k.marinushkin@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1ff8e154-e76f-b57a-cd79-cd42fdecf92b@linux.intel.com>
Date: Wed, 4 Apr 2018 13:57:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404041939.23317-1-k.marinushkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/18 11:19 PM, Kirill Marinushkin wrote:
> Hello Mark,
> 
> This patch series waits since 20th of February, because it modifies UAPI headers
> and should be done in sync with ALSA. I see that previously there was no clear
> understanding, how to do this in sync.
> 
> Two days ago I discussed with Takashi, and he suggested the following steps:
> 
> Step 1. A person from Intel, who knows the topic (Pierre), adds his
> "Reviewed-by" or "Acked-by" tags
> Step 2. I clarify with you to apply the Linux part (this patch series)
> Step 3. After that, I clarify with Takashi to apply the ALSA part (it is ready,
> but not sent untill we apply the Linux part)
> 
> The step 1 is done. Old patches are reviewed by Pierre, so they have his
> "Reviewed-by" tag. New patches are suggested by him, and we agreed on the
> implementation, so they have his "Acked-by" tag.

I just checked all the patches one more time and I am indeed good with 
the changes
Thanks Kirill for clarifying those misleading settings in 
backwards-compatible ways and indirectly helping on our SOF work.

> 
> Now we are on the step 2. If you don't have anything against this patch series,
> please apply it to Linux.
> 
> Best Regards,
> Kirill
> 
> Kirill Marinushkin (3):
>    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
>    ASoC: topology: Add missing clock gating parameter when parsing
>      hw_configs
>    ASoC: topology: Add definitions for mclk_direction values
> 
>   include/uapi/sound/asoc.h | 29 +++++++++++++++++++++++++----
>   sound/soc/soc-topology.c  | 19 ++++++++++++++-----
>   2 files changed, 39 insertions(+), 9 deletions(-)
> 
