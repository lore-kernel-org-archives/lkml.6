Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbeE2JZ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:25:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35410 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeE2JZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:25:54 -0400
X-Google-Smtp-Source: ADUXVKLLPPFn6S1J9UfSJeEKC4UFT+4XgPtKLdEjYG+hCmK2s/u+uP3IMi4Vl6+eSv7qB5463mvlpQ==
Subject: Re: [PATCH] brcmfmac: stop watchdog before detach and free everything
To: Michael Trimarchi <michael@amarulasolutions.com>
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
Cc: Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B0D1C9E.4000800@broadcom.com>
Date: Tue, 29 May 2018 11:25:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2018 9:50 AM, Michael Trimarchi wrote:
> Watchdog need to be stopped in brcmf_sdio_remove to avoid
> i
> The system is going down NOW!
> [ 1348.110759] Unable to handle kernel NULL pointer dereference at virtual address 000002f8
> Sent SIGTERM to all processes

[snip]

Please send a V2 with your configuration details to the commit message, 
ie. using built-in driver, no firmware in place, etc.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 7 +++++++
>   1 file changed, 7 insertions(+)
