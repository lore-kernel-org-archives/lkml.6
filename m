Return-Path: <kernel-hardening-return-11695-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227UZwf30XfZ5/Yw7TqxXP51gCW28Y7hZa5hvzxGFibHsD+pCjMxWB0B3kn4ADh/sXUvB1Ye
ARC-Seal: i=1; a=rsa-sha256; t=1518314521; cv=none;
        d=google.com; s=arc-20160816;
        b=ACPLIylEj+/RgwrFvV4NHjGIQweLuVxNLp3bNzFzjPgFsNl6VUjB/vZ9K5CtJDBksk
         d9QxPZ+JbqQCwE+y5iEdKRCpon8Xra77ncATCKOmR6AclDVazwerKz4wRC2L2S796fxg
         0/eb9GMh2CuhSFcibHbMeF+LrOMOPLCu03eqao0jvFdZCv1zj76zEoWKxao+oqQnTWTb
         rvgUrVRU/8BDOeXnCOA0ugUWRNyQ0d50anuTF0PNezS2z9O8LFiAGgZG+mnI685Ox3s1
         wo7+VdhPOkTf+A/DYz/c78uQPe2LFNotTiMyEq4XbD3Tei2YmavBtBiuaS2gcq5x4zZC
         UJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=LLjRRUiVzJq2qeXVsEmR54m9qXIvGQqSPj8gBR5Cpmg=;
        b=Y29hmuA0DYanz0yCU8ThhUQxLmnJr25hVUZVq1Z8QtM9zCar3GAzd6gcTUA2akOtYQ
         +iyChq0+/+g7zN+7IUlA5rnQRY55F14c6X5a8822DLaWxirDzBzWmgCUQVgUTWHYiXqE
         cIy0U0+QTs+PUJJJ6rXM7ma4tfwa8LIppLPb4Ipkk2GR/oBssPonYMkliY3kiiAD0eK3
         lPi3ZITUgP5r7L8oihG7fIvX3Nhj5FX21oSZ3n69fnKKDkzGBGY38NSEodFtKwQKanAE
         hxjzNU6SSTI3fKtFi3foVem40fICOT1e0w0KsimSCV4P8kJCDDe5R5TjPG3evzipQh9h
         nGUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11695-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11695-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11695-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11695-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <jglisse@redhat.com>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <hch@infradead.org>,
	<willy@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-3-igor.stoppa@huawei.com>
 <201802080423.jTtuTsUK%fengguang.wu@intel.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <78f8d652-220f-05e9-ed69-39108517531c@huawei.com>
Date: Sun, 11 Feb 2018 04:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802080423.jTtuTsUK%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1592068167853099969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/02/18 22:25, kbuild test robot wrote:

[...]

>>> lib/genalloc-selftest.c:17:10: fatal error: asm/set_memory.h: No such file or directory
>     #include <asm/set_memory.h>

This header is unnecessary and will be removed.

--
igor
