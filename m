Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeC1XnD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 19:43:03 -0400
Received: from smtp-proxy001.phy.lolipop.jp ([157.7.104.42]:37374 "EHLO
        smtp-proxy001.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751052AbeC1XnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 19:43:02 -0400
Subject: Re: [PATCH v2] pcm_native: Remove VLA usage
To: Kyle Spiers <kyle@spiers.me>, perex@perex.cz
Cc: tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
References: <1522275840-14092-1-git-send-email-kyle@spiers.me>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <f9720994-b65b-bbf8-334c-a6643b98c131@sakamocchi.jp>
Date: Thu, 29 Mar 2018 08:42:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522275840-14092-1-git-send-email-kyle@spiers.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mar 29 2018 07:24, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the rstamps array from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> loop.
> 
> Signed-off-by: Kyle Spiers <kyle@spiers.me>
> ---
>   sound/core/pcm_native.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

This bug was already fixed at a commit 5730f9f744cf ('
ALSA: pcm: Remove VLA usage')[1][2].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/core/pcm_native.c?h=for-next&id=5730f9f744cfe20b771adc33f3b476b95d3eebba
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-March/133268.html


Thanks

Takashi Sakamoto
