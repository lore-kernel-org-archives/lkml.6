Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeB0Oqm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:46:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbeB0Oqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:46:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCEF56024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [3/3] btmrvl: support sysfs initiated firmware coredump
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1519210220-22437-4-git-send-email-arend.vanspriel@broadcom.com>
References: <1519210220-22437-4-git-send-email-arend.vanspriel@broadcom.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227144639.DB9426070A@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 14:46:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:

> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> it is possible to initiate a device coredump from user-space. This
> patch adds support for it in btmrvl_sdio adding the .coredump()
> driver callback. This makes dump through debugfs obsolete so removing
> it.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

This is for bluetooth tree, dropping from my queue.

Patch set to Not Applicable.

-- 
https://patchwork.kernel.org/patch/10231923/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
