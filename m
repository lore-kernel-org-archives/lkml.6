Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeCLJqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:46:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeCLJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:46:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F31060585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND] rsi: Remove stack VLA usage
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1520819022-15238-1-git-send-email-me@tobin.cc>
References: <1520819022-15238-1-git-send-email-me@tobin.cc>
To: tcharding <me@tobin.cc>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180312094606.7197F607F5@smtp.codeaurora.org>
Date: Mon, 12 Mar 2018 09:46:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcharding <me@tobin.cc> wrote:

> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Tobin, your name in patchwork.kernel.org is just "tcharding" then it should be
"Tobin C. Harding". Patchwork is braindead in a way as it takes the name from
it's database instead of the From header of the patch in question.

I can fix that manually but it would be helpful if you could register to
patchwork and fix your name during registration. You have only one chance to
fix your name (another braindead feature!) so be careful :)

-- 
https://patchwork.kernel.org/patch/10274983/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
