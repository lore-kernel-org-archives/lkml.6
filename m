Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeB0QZz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:25:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeB0QZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:25:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E30A86021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmsmac: remove duplicated bit-wise or of IEEE80211_CHAN_NO_IR
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180223133622.25700-1-colin.king@canonical.com>
References: <20180223133622.25700-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227162552.B676C607E5@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 16:25:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Bit pattern IEEE80211_CHAN_NO_IR is being bit-wise or'd twice;
> remove the redundant 2nd IEEE80211_CHAN_NO_IR
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

47c8a3956a60 brcmsmac: remove duplicated bit-wise or of IEEE80211_CHAN_NO_IR

-- 
https://patchwork.kernel.org/patch/10237695/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
