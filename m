Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933289AbeCMQwM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:52:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeCMQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:52:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6929E60853
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] rsi: Remove stack VLA usage
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1520819022-15238-1-git-send-email-me@tobin.cc>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180313165208.07EFA60A24@smtp.codeaurora.org>
Date: Tue, 13 Mar 2018 16:52:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Tobin C. Harding" <me@tobin.cc> wrote:

> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

There were conflicts. Can you rebase on top of wireless-drivers-next and
resend, please?

Recorded preimage for 'drivers/net/wireless/rsi/rsi_91x_sdio.c'
error: Failed to merge in the changes.
Applying: rsi: Remove stack VLA usage
Using index info to reconstruct a base tree...
M	drivers/net/wireless/rsi/rsi_91x_hal.c
M	drivers/net/wireless/rsi/rsi_91x_sdio.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/rsi/rsi_91x_sdio.c
CONFLICT (content): Merge conflict in drivers/net/wireless/rsi/rsi_91x_sdio.c
Auto-merging drivers/net/wireless/rsi/rsi_91x_hal.c
Patch failed at 0001 rsi: Remove stack VLA usage
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/10274983/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
