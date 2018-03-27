Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeC0Flt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:41:49 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:33496 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeC0Fls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:41:48 -0400
Subject: Re: [PATCH] ALSA: aloop: Mark paused device as inactive
To: Takashi Iwai <tiwai@suse.de>
CC: <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>,
        <linux-kernel@vger.kernel.org>
References: <20180326052449.3618-1-robertr@axis.com>
 <s5hin9ilwx2.wl-tiwai@suse.de>
From: Robert Rosengren <robert.rosengren@axis.com>
Message-ID: <a142f77d-cc4a-c934-574f-4b1e82ea54b8@axis.com>
Date: Tue, 27 Mar 2018 07:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5hin9ilwx2.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX01.axis.com (10.0.5.15)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 04:43 PM, Takashi Iwai wrote:
> On Mon, 26 Mar 2018 07:24:49 +0200,
> Robert Rosengren wrote:
>>
>> Show paused ALSA aloop device as inactive, i.e. the control
>> "PCM Slave Active" set as false. Notification sent upon state change.
>>
>> This makes it possible for client capturing from aloop device to know if
>> data is expected. Without it the client expects data even if playback
>> is paused.
>>
>> Signed-off-by: Robert Rosengren <robertr@axis.com>
> 
> The code change looks good, but just to be sure:
> you've submitted from the address robert.rosengren@axis.com that is
> different from the sign-off robertr@axis.com.  Is this intentional?
> The former is recorded as the author in git history.
> 
> 
> thanks,
> 
> Takashi
> 

Sorry for the confusion. It is not intentional to use different though both are valid, apparently I have used the longer one in earlier patches to kernel so please change:
Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>

Thanks for letting me know!
Robert
