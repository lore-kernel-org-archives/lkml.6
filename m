Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELsKB5yvRSbu576xCLRS2hqRa/igDVsnpMG1zJqC4v7+mmDxW2Uikzzd48rzF4WBuhdjcVHv
ARC-Seal: i=1; a=rsa-sha256; t=1520847675; cv=none;
        d=google.com; s=arc-20160816;
        b=SCqHCmXedX4ud+TokqdopuiyUVV1cVlgb5uRcgF+QzBiW+kOshHXjFfjPVvKsIcOS6
         bo4K6QfFtGUPavAWUjaT1T1PHAKik09jdV+aVNKKoJWhcNH6HtR/Thfpae83I7hndhKd
         AJwTBDJP0yh+hJjwEyuHWxl7ZY/0tc2npZ1dFPeZP0lLSC3B7OpjZDxs6LcNwYHR+8w6
         65SN9gYwzXBzWVaz/ttQridHYX4nEC+wduP6W4kUMsTG0/IyTxQozL8Es2lJG2EL8/jS
         AsxWlKzh4IzN37qsvvAHiIoe8Lr2FqaDYd2v38Z4Vk0opFTFLxaEynY0XVrrYTpbdtnz
         an3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=1HnjeJImNe0DkpuIw69um0j5E7mwGyezNPGI6irG9DM=;
        b=aALpUpp0lI16YHokZdE+/gPSQhBRBrM/0yiZ/PVPGH+gq//c3xDY80f0A5fjLaC/hF
         XDa7oLFe8M/HST2AG9wDL+AGjIN1xt7BJ6t8suweuVyIHmPYUTRfGf0w/5BjbDJaKEva
         lDN9/sPMsoGVovGcp1oCx4D3s81bHI6PeNiW/MVBXrCDyR2VV3Y7pq2K658q/x8gI/Wf
         42ZcUir3LwvVgD9wNTu90r8Az4rAb4NMDkXeZvW5PE42hArRiVu6nPbvPtF+fBf0loVK
         xl1ybnTayHyDg0eTj6OeYpTIRQXQlFf/rNio2TTzSIIKSLzvSU5elyeUrr4IKpIdSwzH
         LE+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f7W5Sgmu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Hnl+34pq;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=f7W5Sgmu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Hnl+34pq;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
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
Message-Id: <20180312094115.3E94960585@smtp.codeaurora.org>
Date: Mon, 12 Mar 2018 09:41:15 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594724372478897415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
