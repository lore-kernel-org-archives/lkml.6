Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeEDIc2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:32:28 -0400
Received: from smtp-proxy001.phy.lolipop.jp ([157.7.104.42]:59208 "EHLO
        smtp-proxy001.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751239AbeEDIc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:32:26 -0400
Subject: Re: [PATCH 1/9] R3Di and SBZ quirk entires + alt firmware loading
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1525407594-25644-1-git-send-email-conmanx360@gmail.com>
 <CAM8Agx0s1Rg5bGCXP5gQftcfsqbQoCvZtNyg4fmUpNaJsix=-A@mail.gmail.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <2d719f92-805a-77bb-dd3e-34c3e1e26940@sakamocchi.jp>
Date: Fri, 4 May 2018 17:25:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAM8Agx0s1Rg5bGCXP5gQftcfsqbQoCvZtNyg4fmUpNaJsix=-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On May 04 2018 13:30, Connor McAdams wrote:
> Sorry for sending these twice, I made a formatting mistake in the
> first series, and they would not apply properly. Hopefully these do
> not show up as spam because of this.
> 
> I went through and fixed them all individually and re-committed them,
> but kept the same commit messages. I still have a lot to learn.

For this case, please use '--subject-prefix' option for 
git-format-patch. Like:

$ git format-patch --subject-prefix='PATCH v2'


Additionally, it's preferable to add 'ALSA: hda/ca0132: ' prefix for 
each patch. Like:

'ALSA: hda/ca0132: R3Di and SBZ quirk entires + alt firmware loading'


Furthermore, when posting several patches as a one series, it's 
preferable to post cover letter as well. Like:

$ git format-patch --cover-letter
0000-cover-letter.patch
...

Of course, it's better to write enough information in the cover letter. 
For its content, please refer to cover letters by the other developers 
in alsa-devel archive.
http://mailman.alsa-project.org/pipermail/alsa-devel/


Thanks

Takashi Sakamoto
