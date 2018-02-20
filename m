Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeBTQ4L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:56:11 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38729 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeBTQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:56:10 -0500
X-Google-Smtp-Source: AH8x2247lzh7Pb9olijCOxtecCFfJuE1sWoxeUHCLZojJ18w3EACokDmpoRbCEQ8//23YUMloNJiog==
Subject: Re: Applied "ASoC: topology: Add missing clock gating parameter when
 parsing hw_configs" to the asoc tree
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20180219203636.3692-2-k.marinushkin@gmail.com>
 <E1eo6jW-00039l-Ts@debutante> <20180220134527.GF6378@sirena.org.uk>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <3036a35d-ab93-c7aa-edf7-5872faeacfe7@gmail.com>
Date: Tue, 20 Feb 2018 17:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180220134527.GF6378@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/18 14:45, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 12:09:18PM +0000, Mark Brown wrote:
>> The patch
>>
>>    ASoC: topology: Add missing clock gating parameter when parsing hw_configs
>>
>> has been applied to the asoc tree at
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> This broke the build so I dropped it.

This patch is part 2 of 2. I failed to send both of them as a single patch series.
I will resend them properly in a new thread.

Best Regards,
Kirill
