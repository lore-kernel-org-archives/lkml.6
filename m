Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/4vZtciL1p0r9SL1HU221hmdtExt3rBTeEfVtcSHxv+6g5HSlP4PYiZpbR6FLHO11nAajr
ARC-Seal: i=1; a=rsa-sha256; t=1522239784; cv=none;
        d=google.com; s=arc-20160816;
        b=d+6clYFmoosHKIkMmoidcW3VC6ZAVArhaYYysZJBakkZPvEhm4ANlCRpi/29k5rYPY
         cXYdKsm95idgMjLdDKjWwVK3toa7Bw5zA3SKX0BCSQK3kLCOXYmZr3D0GNjXIddhl7xC
         oysWFuMOAJXNzSCCldWnK6jHC96sVpYNVptQnJC0WuQiZF4tx4MJoTQEWPemqExkIsQR
         1eRTee1A6Tl/008Y1oAzxY/JdHBD+Ct68rju0WyHiv4m85MrADAiLoNyk8aPV59Fd3QF
         TjfLvrfdP8u7CU5nBXNNXrs5VoC+s1Jmak1kg0Nqwjl83P7QVVVYSp+oA7UQMtod9oi4
         3VzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=EH4q/5gtoSAv4xHG7L10VywU01TQC4K0qEmoIcoEz0I=;
        b=OK8GHCRWrZIGlt0LaKlgLsOcXNlkEWrCwG+LmbRrVWX+PXjo3lg+eT62ZI9wv/S/3L
         0xB+JhtFp1ANMgda2XlI71eZRlT+w44lFfBakkRQLaMgfwwu4iRLqeSpUdudCGeXW5wN
         0x4E5yPAHHS8ldUdBxC2U1xAgBLodu31+WHnozsh8jWpcGQD9ljYejRrJdQP9Z8Dj9AR
         iMGhVnMdgI3BGqRIX3lkr6IoMEL1IS3oB4F4cDxFUMKzrkLBf4O7OvmNuCetC+4Gnxnp
         +k+mXQdeR9TynnskrPbppEv8gYecWw83gO9yQgOHsoTJ/e0XyiVHAxmuCFVR9Y+O49hK
         T3og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=njXyGKq8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=C2D0mFY9;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=njXyGKq8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=C2D0mFY9;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33684600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v5 1/4] ioremap: Update pgtable free interfaces with addr
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com,
 mark.rutland@arm.com, toshi.kani@hpe.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
 <201803281954.xld7X6dW%fengguang.wu@intel.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <37565406-dc0d-b23a-a8e8-27767590c9f1@codeaurora.org>
Date: Wed, 28 Mar 2018 17:52:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803281954.xld7X6dW%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596097435911624997?=
X-GMAIL-MSGID: =?utf-8?q?1596184103766974782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/28/2018 5:20 PM, kbuild test robot wrote:
>   @725  		if (!pmd_free_pte_page(&pmd[i]))
My bad ! Will fix this in v7

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
