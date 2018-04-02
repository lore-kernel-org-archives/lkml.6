Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbeDBVRH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:17:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51146 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbeDBVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:17:06 -0400
X-Google-Smtp-Source: AIpwx4/vzTpVPzjAVze2seszOZGoIfRaChXzphLc742ZC4naGIZQ7cQy29ceTZmExcNUUy8qUxkOfQ==
Subject: Re: [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <17f0767a-2dea-92dd-a88e-a3f3e670d0d2@gmail.com>
Date: Mon, 2 Apr 2018 23:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180327205632.3677-1-k.marinushkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pierre-Louis,

I explicitly clarified with Takashi: to have this patch series merged, we need a
tag "Reviewed-by" from you.

Patches [2] and [5]:
You already tested them. May I put a tag "Reviewed-by" with your name into them?

Patches [3] and [6]:
Those are new for you; I added them to this patch series, because they are
logically similar to [2] and [5].
Could you please review these patches?

Best Regards,
Kirill

[1] [PATCH v3 0/2] ASoC: topology: Improve parsing hw_configs
[2] [PATCH v3 1/2] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
[3] [PATCH v3 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
[4] [PATCH, alsa-lib, v3 0/2] alsa-lib: ASoC: topology: Improve parsing hw_configs
[5] [PATCH, alsa-lib, v3 1/2] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
[6] [PATCH, alsa-lib, v3 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs


On 03/27/18 22:56, Kirill Marinushkin wrote:
> Hello Jaroslav, Takashi, Mark,
>
> This patch series is a resend of [1] and [2], rebased on top of the latest
> head. It was logical to resend them together.
>
> It includes 2 patches for linux + 2 patches for alsa-lib.
>
> Please have a look.
>
> Best Regards,
> Kirill
>
> [1] https://patchwork.kernel.org/patch/10250485/
> [2] https://patchwork.kernel.org/patch/10230611/
>
> Kirill Marinushkin (2):
>   ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
>   ASoC: topology: Add missing clock gating parameter when parsing
>     hw_configs
>
>  include/uapi/sound/asoc.h | 23 ++++++++++++++++++++---
>  sound/soc/soc-topology.c  | 19 ++++++++++++++-----
>  2 files changed, 34 insertions(+), 8 deletions(-)
>
