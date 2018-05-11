Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeEKMUe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:20:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeEKMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:20:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94B5C6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgens?= =?utf-8?Q?en?=
        <toke@toke.dk>
Subject: Re: linux-next: build warning after merge of the mac80211-next tree
References: <20180509145624.643d2e56@canb.auug.org.au>
Date: Fri, 11 May 2018 15:20:23 +0300
In-Reply-To: <20180509145624.643d2e56@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 9 May 2018 14:56:24 +1000")
Message-ID: <87po221j08.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the mac80211-next tree, today's linux-next build (arm_multi
> v7_defconfig) produced this warning:
>
> drivers/net/wireless/marvell/mwifiex/uap_event.c: In function 'mwifiex_process_uap_event':
> drivers/net/wireless/marvell/mwifiex/uap_event.c:333:1: warning: the frame size of 1680 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>  }
>  ^
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_notify_connect_status_ap':
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5530:1: warning: the frame size of 1680 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>  }
>  ^
>
> Maybe introduced by commit
>
>   52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to userspace")

Btw Stephen for mac80211 reports it would be a good idea to also cc
linux-wireless list, in case Johannes is not around etc.

-- 
Kalle Valo
