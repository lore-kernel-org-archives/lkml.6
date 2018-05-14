Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AB8JxZp9m34KHBpZkQZ+941v8prgMAB7KbCVKg10NOe+IhNvuj9Ky+RJWvmi4BviS54x6FLcKpxW
ARC-Seal: i=1; a=rsa-sha256; t=1526295500; cv=none;
        d=google.com; s=arc-20160816;
        b=TpYy+aRolaMIGWtz1C9KH9Vad0qNTvCR6zUpC8lkGeutQV5FfZrn/Wjjb1Ie2C3OOL
         VbNPC48ADH/tCprQwggYpBAMpdPULhu+4sRNIwRbEwPCcfsJep8d6mfBEkHdIfTBNjEw
         IiX90/wkCSt9Kw1Ix3ELtBaX4sBInbzyKIis8b4ZfAGVPNsMWVhozbGzThQLYjf/PfoR
         OpNgbwgJ67qyEPAfXNDsJsF31BISSoLrLItoHQvpJckx3WnE/VjzGZywz/BqXpDDBlvu
         /0xAm1yWr77dF9K1jQkLeYEEGC1gurWVP/GBGp3L9Vt03IzPufJcJAJFtpS07heoRUOo
         A7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=pg78eEfIitlhSdtryA61Wanv54sDeuWZIMRjEEnZGok=;
        b=yEZx8sCPo8Z/Iw3EgOtfEApcfDTP1dzt6f5Lbc3K6vA/SOKTJoGsp9JYs/Pb7LKxCH
         Q4NlPKd+7p1Oh0Qs2c8fvppX9d6VurUjUzEm1iTug3L7faMg23mfsoOLrUgjrOhyz18s
         Lj0mN/R70OZPL6xSFk9Kwrdx0ct0iOCANYpRkP/e852tcRKDn+a8uDkJMJ9My1qbWxVH
         YK34U4lmXPEhL2Gkj1rvMS9nU+OF/Rw7BSeZTQgz1xSTvk5HJ9Nl8xfNGG3yAI6WS0jM
         1Xh/izTU2IWSCO77Is9PbJ3SWAm+8zkeFtsRdANUVUfTwQlmD1RZ2XE+1TKtuvz3ONku
         Dhcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="228349638"
Date: Mon, 14 May 2018 13:58:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc: peterhuewe@gmx.de, tweek@google.com, jgg@ziepe.ca, arnd@arndb.de,
	gregkh@linuxfoundation.org, javierm@redhat.com,
	sonnyrao@chromium.org, enric.balletbo@collabora.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: replace kmalloc() + memcpy() with kmemdup()
Message-ID: <20180514105812.GG8228@linux.intel.com>
References: <CGME20180509001258epcas1p4e8db163d8babd90284dd6afb6a96eb0f@epcas1p4.samsung.com>
 <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525824757-21835-1-git-send-email-ji_hun.kim@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599943245926622446?=
X-GMAIL-MSGID: =?utf-8?q?1600436829982992890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 09:12:36AM +0900, Ji-Hun Kim wrote:
> Use kmemdup rather than duplicating its implementation.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
