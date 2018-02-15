Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbeBOIa1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:30:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:25903 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754918AbeBOIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:30:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,516,1511856000";
   d="scan'208";a="20224802"
Subject: Re: [PATCH 3/3] ASoC: hdac_hdmi : Ensuring proper setting of output
 widget power state
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Wang YanQing <udknight@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>,
        Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-3-git-send-email-abhijeet.kumar@intel.com>
 <20180214162044.GG12658@sirena.org.uk>
From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Message-ID: <a1e2e283-656b-59b3-fbc3-09851ebd16cd@intel.com>
Date: Thu, 15 Feb 2018 14:00:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214162044.GG12658@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2018 9:50 PM, Mark Brown wrote:
> On Tue, Jan 23, 2018 at 11:00:53PM +0530, abhijeet.kumar@intel.com wrote:
>> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
>>
>> In usecases like hot plug-unplug DP panel or modeset during a playback,
>> sometimes we observe no audio after codec resets. During no audio
>> condition, we have noticed that the power state of the pin or the
>> connector is D3. Optimizing the way we set the power mitigates the
>> issue. With this changes the verb is sent to set the power state and
>> waits until actual state reaches target state. Thus ensuring power state
>> is set.
> This doesn't apply after the recent refactoring to move to components -
> can you please rebase on current code and resend?  I pulled Takashi's
> branch already, it's just this patch needs handling.

Please find the re-based patch here.
https://patchwork.kernel.org/patch/10220549/

Warm Regards,
Abhijeet
