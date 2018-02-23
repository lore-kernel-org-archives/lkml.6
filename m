Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224BuONZUbjdblwEwPfmS+B76vbFHaQRCRO1PTD4sXR5bqZJL2F46HLBjXyU9DZK7dm/u9WH
ARC-Seal: i=1; a=rsa-sha256; t=1519398838; cv=none;
        d=google.com; s=arc-20160816;
        b=IzxM1+VQH2txbosp1PBNpwdWTZRJu8peLYP4Q/WE9hwrMtvIo3nkZCzuAjZQW5CsDu
         xWTG3ZywJPbjNdlGBR+feA5mxMrLX9RX4WgCqPOw4N7q9Z5dPzvSLFeVD/rcUBNFv3aa
         8gPViJ0HRYRqtrbnXh0VQHMbv5giaVLSbKXqSsuClyOjCitL0sILyl3BwFmcf3NXflFs
         4CdC2EDodXcYOAYM6wFjG6PnSB7K9cpRCQ8FAW2c5Oep08a2VqpfBXICowT7M1AMKFGP
         QTaydq4EWoPaO58mQJB3EOGMcDQnilHApGkGQbOpP4qXc3RwhkF97nP/HwOTYQwo8ru4
         pWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=LUPJn4HU2SninrHWaFrPTegK0YaOl2lTGz31ufyz+7M=;
        b=IfauDsShdc30dbzz1wpB6kHxzAkcsJabpufD/wz3CYIGNbHhgYqr/tJEOxATNJx4HG
         U0oEI80Bhmi07lZ9EpNLEUwymWoSJUSgLwboiIDPCgObddfG5HMgME8BbvUnBGMbyQQG
         9LE4GAE6SzhbOFX0zmjIGnB4iUBccqgJ/hat9WYIOI1v0qQZDx74GP1yq2zzWD9c6vlV
         0sNnlqIvP5G+iBLL35ujuEEF6E8Fy4DpZxmzqJk7wZBPdSS44FhyIxIzPxJtvvYbshd6
         JdXQc+GDgCHbZDptX7LSzBkaON+hhJrMCuMMBU4MavUUE1TKEG7N4ywa1UGMW2TIbmrD
         jv6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:13:56 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej
 Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RESEND PATCH v2] Documentation/ABI: add sysfs interface for
 s6e63m0 lcd driver
Message-ID: <20180223081356.507a4ff1@lwn.net>
In-Reply-To: <20180223132352.GA25436@mordor.localdomain>
References: <20180223132352.GA25436@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593198237571612180?=
X-GMAIL-MSGID: =?utf-8?q?1593205156710808199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 18:53:52 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Document sysfs attributes of s6e63m0 lcd panel driver by looking through
> git logs and reading code.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied, thanks.

jon
