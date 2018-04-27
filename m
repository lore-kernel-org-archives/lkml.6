Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZqOyhUUKoh1KTjf1SLHYptqMftZw0fhY4fp0BSJJKhpDHn4HzhbgFSzGalyb0wshSDKRu9j
ARC-Seal: i=1; a=rsa-sha256; t=1524824831; cv=none;
        d=google.com; s=arc-20160816;
        b=GcM5BM13xYi6zqTkF1Q37TuF00qyjyx/MARRSkviC+1f5E2axxfPXwBf7qYhFLzQYK
         qAHhR6/YEVPBYYybjb6cLVC+ZRvAp9zfvsG9eWuYu5CXInFbJI7Sjd2U0qn7wBMshz9e
         NFj8VB9Rb/o5cWDqL+9y/6pm8zZY/O6jZ7bZ6tkqM4caF2h0nW3hwKjQeTZ1zI8Eiosh
         V/W1g/QwYVNITbW1UBzxPs/DNkqOyYcVXiwle1n8scgfoP6iO6e8kmOS7YiJkK8SNoSn
         v8xxPtKvb5FiLzBLfNDGZabG3pY+uyGi7qH4eEa3KM2roINCAPtnR8PN2z1IHdQuhrCp
         Vr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=bWql+dyxEtcgSqevt84SQ5ecvhHlJP2LMhXxDsKYLJc=;
        b=AfGPblzTCZKm5N0s6B4u3E3t/LCWTJrEuA0ey/hTY0I6P9KnilVytHZcb/U5+nuNeA
         fHsUAd06JHFX+q3NfAAnPV2uWfnXpus5r18kNaYCA4XsIFP6rGHzGIgB5u98U0wfZMS7
         0T2YbxQ72RFc1IOurtuZ4P1T5YLs9lzwji3mdoVn6SzbagYJSONGz2ObmVUXIwIYZ0Be
         SO4pv81gG2rppWF+XmCZAoH/BULnJW9lYk5ZyrW7ZSliGMeOpRzgWQyCo1lKoJFqBfJg
         SUJd9hcvOvCDyE5arLBq3UgjnVA5JaBoJs5lrrk6YadiWeDtVKbAckSTcrB1A4Xo/ak2
         8wxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Fri, 27 Apr 2018 11:27:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com,
	linux-arch@vger.kernel.org, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
	james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Message-ID: <20180427102705.giwkzgqp43qiptws@armageddon.cambridge.arm.com>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1598894722257839189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 03:55:08PM +0530, Chintan Pandya wrote:
> Ping...
> 
> On 4/3/2018 1:30 PM, Chintan Pandya wrote:
> > This series of patches are follow up work (and depends on)
> > Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> > panic in ioremap huge pages".

First of all, you'd need to post patches against the latest mainline
(4.17-rcX).

Second, since they depend on another series, we'd have to wait for the
comments on that series to settle.

-- 
Catalin
