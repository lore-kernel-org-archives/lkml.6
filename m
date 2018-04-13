Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeDMKyg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:54:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37056 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbeDMKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:54:35 -0400
X-Google-Smtp-Source: AIpwx4/vvI42AHfJFKIWagzqpBZIWgyMEuuwSVgr+Uo0I13ma180YlEeDKgBGf/K84aZdhNY88GAnQ==
Subject: Re: [PATCH] sound: soc: intel: bxt_da7219_max98357a: Replace
 GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
 <20180413104130.GA6854@sirena.org.uk>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <32138b5e-843b-3f37-28ee-62d7fa93f0db@gmail.com>
Date: Fri, 13 Apr 2018 18:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180413104130.GA6854@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/13 18:41, Mark Brown wrote:
> On Mon, Apr 09, 2018 at 06:46:21PM +0800, Jia-Ju Bai wrote:
>> broxton_audio_probe() is never called in atomic context.
>> This function is only set as ".probe" in "struct platform_driver".
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

Oh, sorry for my improper subjects.
Thanks for your very helpful advice :)
I looked at previous related patches, and find the subject should be 
"ASoC: Intel: ...."
I will follow it in my future patches.

Do I need to send V2 patches?


Best wishes,
Jia-Ju Bai
