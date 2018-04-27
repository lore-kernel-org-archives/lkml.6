Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757594AbeD0LjN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:39:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeD0LjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:39:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A18960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next] ath10k: fix spelling mistake: "servive" -> "service"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180426091244.9160-1-colin.king@canonical.com>
References: <20180426091244.9160-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180427113911.1640460213@smtp.codeaurora.org>
Date: Fri, 27 Apr 2018 11:39:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> Trivial fix to spelling mistake in ath10k_warn warning message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

785281342d0c ath10k: fix spelling mistake: "servive" -> "service"

-- 
https://patchwork.kernel.org/patch/10365081/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
