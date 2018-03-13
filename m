Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeCMQs7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:48:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeCMQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:48:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C683607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] ssb: use put_device() if device_register fail
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1520490204-10411-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1520490204-10411-1-git-send-email-arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: m@bues.ch, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180313164856.C170F600C1@smtp.codeaurora.org>
Date: Tue, 13 Mar 2018 16:48:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

a24853aab591 ssb: use put_device() if device_register fail

-- 
https://patchwork.kernel.org/patch/10266711/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
