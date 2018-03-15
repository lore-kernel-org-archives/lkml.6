Return-Path: <daniel.lezcano@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521099870; cv=none;
        d=google.com; s=arc-20160816;
        b=Wb5OwvO0C78Uvu6jeavcK8wUK/cpro0ZN9wnke9zud1y+gWV4OocfQ7geZ8VWujJjM
         u45Hj5AyzifZKMql4kDLF7QOYgBT5CssnpfOo6STMJdmAWP1OlMuQ2fk5effRv05Vj9M
         bFXxSQ2ep+7PTBi0IXd6g4HPkgNRJfMe5nkVsLXcImK8DPp3dZqILZT58dhjmSz9ikZY
         75PM5HjTgjvqLBIbYMRDqub3G44TMYXPm7lkpEOpY4l3VeBdaEljEEpeEfQ1J453QcDe
         GYR/05aZ7pFJ5Wt+I6eAuvG0OWtxQ8kFM6IWm52HRcrdlxuSqgrZ34jjL9A85t1UHvdm
         AYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ruah4gzcjmBmT7MIk5aLRHu5BY31zoteMt4rszjeR8g=;
        b=RO//vslVYGaWinx26K8AaObn5N73kGdhPPN+0EPOdOqalDshJQMUpw2gDxqn1MAMXm
         IFYDGzeGlA/XFLV7CKqI101ai5Lr+JeP5g5Bx+6A7pSAvB2gOygljn47bxSue71hqP8i
         iPGRXjpL9lnd/EemCk+GXENkAwQ/+0kdTDJeTbnS5l3luT8bOzD6nlk5R5TDnXgQTFWK
         4EJl0hx7SrQ8KMiwxgNgAnszxEGvRFHCRkpOD1jyCxlp/OYj8R+FetAtdt0FZkQYEc9U
         dqR6VRI+MFoIjo00Es5LJNMMV1l3vNzAs6EZxUU5nnbD4moTLUIfWyKyNeb6P5297mtP
         pr4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LJD/Ltpq;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LJD/Ltpq;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuAfnr0B4RUs8GYCdjCHSUlYQEpiy7ss7uzfId/8dnX/ZHhGqhJYbdmVCTTskDf9ecq0ZVJLg==
Subject: Re: [patch 3/4] genirq: Convert various GPL references to SPDX
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "H. Peter Anvin" <hpa@zytor.com>
References: <20180314211515.429128440@linutronix.de>
 <20180314212030.571811184@linutronix.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d62ec96-815c-2f4e-7d4d-081382c9c8ed@linaro.org>
Date: Thu, 15 Mar 2018 08:44:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314212030.571811184@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949829799092079?=
X-GMAIL-MSGID: =?utf-8?q?1594988817920141735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


These files contain various forms of boilerplate language and sloppy GPL
references.

Replace all of them with the proper SPDX identifiers.

[ ... ]

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
