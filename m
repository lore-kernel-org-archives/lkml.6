Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeDYIYF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:24:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:24:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97EE860500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmsmac: phy_lcn: remove duplicate code
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180405000944.GA22743@embeddedor.com>
References: <20180405000944.GA22743@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180425082401.5442F607C6@smtp.codeaurora.org>
Date: Wed, 25 Apr 2018 08:24:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Remove and refactor some code in order to avoid having identical code
> for different branches.
> 
> Notice that this piece of code hasn't been modified since 2011.
> 
> Addresses-Coverity-ID: 1226756 ("Identical code for different branches")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied to wireless-drivers-next.git, thanks.

863683cfbbfc brcmsmac: phy_lcn: remove duplicate code

-- 
https://patchwork.kernel.org/patch/10323665/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
