Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZpPukNRVRsZ8xB14/1Xd9v+KAuA3+OLb341H9J0XJ0aXGcDaJPV6UymxHAKp06/EVxZYEwn
ARC-Seal: i=1; a=rsa-sha256; t=1526467657; cv=none;
        d=google.com; s=arc-20160816;
        b=cqrjJ9YLGl7ApSv8ZTfiUEiyKTzCAdQoeC0IzmGZVfWDC7BZ2wd0WXmLmLyLanFrxG
         JmyHTHwDbkARdqq4fO+UcbQ4dNc7icoUn38zNRhTRPfqZFT1Z+r8E09Y+zihvnn5a7HG
         rZXNdjdm82I3+J5BB8ZG21nP6DbVKBj2N6XCEq79xpCyb2NXyI+sZz0zlI0iYuknzbOP
         +dWOucgHY59e6w6ucmLEsHL2Qzr3NArM+Zsp6tGQddHQxvEZLRQCYlg/XR1Mw3sUKufN
         WmB+hXMaQAyGkco6coL46nuCuxUntl85rAlPdpFP3fMh9k6dne4i3Zw6o9zkzv0i7Md+
         GCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OvSE4DPvC4kO1SvMnXQC8bAWSYimKiO7I8//Fih2o2Y=;
        b=hYROtWGt6XowXoBMyqVqeKHH4PTqwRMem6O+VLY4pQmgKfqNhh9/58xjC2fm/s4lSv
         0zazcAHhFFstkmq19f6aOayifmzxfSzQJLiPX8XrzG0K06SHoDAr09/9jompkLx+3hkH
         35aWBaxuC1/E77Cx35R4A+Kq+FKFoqKHhMbeWaXxUCAC/VSn8LHrcGUY3hoNXg8Z/FUS
         jcag/5w2vCASnKHWP3SirK+NLQ3s71RcG9cyunzi0pryRb06K5RmUtvTwVgKoL/Oxe66
         Wuxr/M/6vPhFsi8AvFw6EFm+KVSmP+CTl6eGBZZBrKqq1p2uy83ux1wXG1r1mWTQ7mO1
         qdwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Wed, 16 May 2018 11:47:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Steve Capper <steve.capper@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
Message-ID: <20180516104732.dxt7di6t4hcss23e@armageddon.cambridge.arm.com>
References: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599971818353626759?=
X-GMAIL-MSGID: =?utf-8?q?1600617351168087910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 04:46:26PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for ARM64-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 4.18. Thanks.

-- 
Catalin
