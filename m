Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeCLJlR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:41:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:41:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18C8E60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180312094115.1996760452@smtp.codeaurora.org>
Date: Mon, 12 Mar 2018 09:41:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:

> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> it is possible to initiate a device coredump from user-space. This
> patch adds support for it adding the .coredump() driver callback.
> As there is no longer a need to initiate it through debugfs remove
> that code.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Based on the discussion I assume this is ok to take to w-d-next. If that's not
the case, please let me know ASAP.

-- 
https://patchwork.kernel.org/patch/10231933/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
