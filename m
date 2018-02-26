Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeBZOx7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:53:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbeBZOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:53:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2562C60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next] wil6210: fix spelling mistake: "preperation"->
 "preparation"
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180130192737.8986-1-colin.king@canonical.com>
References: <20180130192737.8986-1-colin.king@canonical.com>
To: Colin Ian King <colin.king@canonical.com>
Cc: Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180226145353.1DECA60592@smtp.codeaurora.org>
Date: Mon, 26 Feb 2018 14:53:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> Trivial fix to spelling mistake in debug error message text.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

77b83829ebf6 wil6210: fix spelling mistake: "preperation"-> "preparation"

-- 
https://patchwork.kernel.org/patch/10192357/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
