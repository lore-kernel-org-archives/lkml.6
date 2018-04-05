Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDEMs1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:48:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:48:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D5CF602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Joe Perches <joe@perches.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: [PATCH 06/12] wireless: Convert simple uses of a static const Ethernet broadcast address
References: <cover.1522479607.git.joe@perches.com>
        <79196f134a513d50968e8e208a0e56b3c0236ee3.1522479607.git.joe@perches.com>
        <87po3desix.fsf@kamboji.qca.qualcomm.com>
Date: Thu, 05 Apr 2018 15:48:17 +0300
In-Reply-To: <87po3desix.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Thu, 05 Apr 2018 15:39:50 +0300")
Message-ID: <87zi2hlsz2.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Joe Perches <joe@perches.com> writes:
>
>> Use the new ether_broadcast_addr global instead to save some object code.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>>  drivers/net/wireless/admtek/adm8211.c           | 3 +--
>>  drivers/net/wireless/ath/carl9170/mac.c         | 4 +---
>>  drivers/net/wireless/broadcom/b43/main.c        | 3 +--
>>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 3 +--
>>  drivers/net/wireless/realtek/rtlwifi/core.c     | 5 ++---
>>  drivers/net/wireless/rndis_wlan.c               | 6 +-----
>>  drivers/net/wireless/ti/wl1251/main.c           | 5 +----
>>  drivers/net/wireless/ti/wlcore/main.c           | 5 +----
>>  8 files changed, 9 insertions(+), 25 deletions(-)
>
> It would be really helpful if you could CLEARLY document in the patches
> (or in the cover letter but then you need to cc all parties) to what
> tree the patches are meant for. Otherwise I, and other maintainers as
> well, need to waste time trying to guess what's your plan.

Forgot to mention that for me the best approach is to have the tree name
in subject, just like Dave and Linus both recommend:

[PATCH 06/12 wireless-drivers-next] wireless: Convert simple uses of a static const Ethernet broadcast address

This way I can immeaditely see from patchwork to which tree the patch
should go which helps tremendously. And if the tree name is too long you
can always shorten it to w-d and w-d-next.

-- 
Kalle Valo
