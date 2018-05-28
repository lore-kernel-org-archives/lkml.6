Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeE1GiZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:38:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34362 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeE1GiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:38:24 -0400
X-Google-Smtp-Source: AB8JxZo7L7RX+4DUzuIgNIjW/045pgvhXJHvQEGtZTSAVC9sfHtxYeRwKzNF/k6+/kQ5LolYe6RsFA==
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: Vinod <vkoul@kernel.org>, Shreyas NC <shreyas.nc@intel.com>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180525133323.GI3116@snc-desk> <20180528060347.GA5666@vkoul-mobl>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a5444567-2577-f65b-fc16-b234fa5486ec@roeck-us.net>
Date: Sun, 27 May 2018 23:38:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528060347.GA5666@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/2018 11:03 PM, Vinod wrote:
[ ... ]
>>> diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
>>> index f8d1749a2e0c..b0e3d376594c 100644
>>> --- a/sound/soc/intel/skylake/skl-tplg-interface.h
>>> +++ b/sound/soc/intel/skylake/skl-tplg-interface.h
> 
> Don't we want to move these to upai/ as that is right place and use that in
> alsa-lib.
> 

I did that in patch 3 of the series [1].

Guenter
---
[1] https://patchwork.kernel.org/patch/10425387/
