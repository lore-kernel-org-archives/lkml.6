Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeFAAjj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:39:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750736AbeFAAjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:39:37 -0400
Subject: Re: [PATCH v2 16/21] ASoC: max98088: use match_string() helper
To: Mark Brown <broonie@kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
 <20180531114921.GD13319@sirena.org.uk>
 <8009e494-9ba0-bff3-e900-37f8923886a0@huawei.com>
 <20180531160206.GE13319@sirena.org.uk>
CC: <linux-kernel@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <e7c6d379-8413-9af8-9562-17085359b2c5@huawei.com>
Date: Fri, 1 Jun 2018 08:38:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180531160206.GE13319@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018/6/1 0:02, Mark Brown wrote:
> On Thu, May 31, 2018 at 08:25:39PM +0800, Yisheng Xie wrote:
> 
>> Anyway, Here is the cover letter of v1 and I have add v2's cover letter to you:
>>   https://lkml.org/lkml/2018/5/21/303
> 
>> Each patch in this patchset is a separate one, for what this patchset want to do
>> is use match_string() helper for echo subsystem.
> 
> For something like this it's generally easier to not send everything as
> one big series - it avoids any confusion about dependencies and there's
> no actual relationship between the patches.  Instead just sending each
> subsystem as a series or perhaps even just a bunch of separate patches
> should make things smoother.

Thanks, will take this suggestion maybe next time.

Thanks
Yisheng
> 
