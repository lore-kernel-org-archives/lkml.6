Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AH8x226EKwWAWiDGKO8OUSj9nzyECG1xGsRJpEOuyTkUQCvPJM3cxh1Zyl7wUB6Y9Y8F51eyy54y
ARC-Seal: i=1; a=rsa-sha256; t=1519742800; cv=none;
        d=google.com; s=arc-20160816;
        b=Wz12f61Kt0IwJPnjlzp/HFBF1kOsKl1W/bj032yAk7hCvYv7UhGB+/GGb8eeRklfSz
         nDNCyGCaca0NF7dpNboHxEHvz3k+l0BkfptzOZk2Ir1z0w68j8nceAtYmje1pQ//pzCT
         cI2lYC8Kyuxxu9IkZRwrXpoMbdv6zilzosgNbUxye83U9h9C+wfwAzr/wzrZkBkoj+Z8
         U6bGZdZkiT2SBtzeRRUJ3M80/Siq/hdkwQYqBANNs/ySe3g+XO14W7OHWlGtJk8J8aCM
         OgdhKrktu5MNAIm0DYGnIbyB64I+/Snn97rIGf8UkBHIG0HxKQnzkGLxDEUGjgDFqkRp
         41rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=LBNVixYMbve7SCSaSpcLHlPlNaBGr0+ixAWCwMEHDd8=;
        b=KgyExPnoGCQbN+zeW0XkhXmI8dAkF1JmpE+DBWchscJVFsINoyjHC9GJz/F6GGZh85
         QV3OsO9D4OZhQZfiZlwNjJ6R7lV2Zq1s8g7HVcNdbhdoEXob5PvL4JiVo8kuIX680GqW
         lLmtXbAMRdN+exm5owjQKyIXydn//N63bdT+0oR0JRZXoMHU9iJEAs5BXTtdBm+Kg+T1
         HOvD2YMjh8QbzCDJVntGNkdwyDmgdnRNLpHOR97xeLltiet/n06stumdxmSgwXBs8wzU
         ObcluWufgITUan00o31mWA4TunURt+kIMgQ6rntF2zOgVfviIT5vt4e+V1WaXisngb4e
         EN7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=evDuliJC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZR8FZ5lq;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=evDuliJC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZR8FZ5lq;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
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
Message-Id: <20180227144640.0BEE26024C@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 14:46:39 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007399539898108?=
X-GMAIL-MSGID: =?utf-8?q?1593565826328697506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
