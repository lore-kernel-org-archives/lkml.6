Return-Path: <kernel-hardening-return-11715-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227kldFaW250IyqjvLAxVvRPv3KVmQ/mgsAQsNQF4/Vv7ky77/rG+qkpAMMeWOc8IL1tkwsN
ARC-Seal: i=1; a=rsa-sha256; t=1518434940; cv=none;
        d=google.com; s=arc-20160816;
        b=aUz7U9kohGZ/Og+2HYfyga1ZMnHiEhfueFb72ZccMpiqxKIGccznMydf9zFAwz6kAM
         qsHoJhQi7KlYJCVnM6UIsqpNxbDARe8xFyKUdRXTYmzBoBAtRsluSmKNjOX1sXNKK4hS
         Y32fEKu0mPDisdGrw82Zcaw/H/y0ASCiQD/ys0cbTMbdH0ok1QdEV/tt48HKXHjmGCU1
         kn5TcSB5UxJjQ5wCYDekiYkBfWgITVkFYWK0eE4io/aiDD6Cjt+g6ahCNy4E/3OEMBCT
         TS2rGgnhQ9LSIueFJ1z1ReXcIpTv2x6bQUsGy7caiAnCHnAaGSc06yrk6qfl1oPqqWGa
         ZIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=bNxvU9e0g6gSKzVst6XpLx+ecm8pQTjN61tNGvKHvCI=;
        b=cWhqQP5SsoihoHTINAv1jNH/7IwMM6hqBMnmXAursD4Rm/iJYu2YOmjuSs9WvooT/D
         zlcjJnGpUR1h5B675hB0iygN7cpa0I5ejAYmgshuhahscK8BCARviDg/b0aMjfnSQgk9
         1hgc1SOqZZdNtjMiHvu8WGA3sbECSrQXFctNo1IydzrfZXS71ksBSZ3Pne4luuU1iTTH
         B14MOGqGPj+5jJTIkIe65j469GALD80iHFHJSscPVBDCY0bjelsyvuy9wPg6e6wmS/Mm
         dHbjY2dn7byzDjctF0kzCfF7VJotHgdEfIGmOSwozvwve5tgrJHXR6/N3ct1Bq4CF/m2
         Zkvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11715-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11715-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11715-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11715-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/6] Documentation for Pmalloc
To: Matthew Wilcox <willy@infradead.org>
CC: <rdunlap@infradead.org>, <corbet@lwn.net>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <jglisse@redhat.com>,
	<hch@infradead.org>, <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-7-igor.stoppa@huawei.com>
 <20180211211741.GD4680@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <f3df57c6-47af-16af-c014-27c9c33c9879@huawei.com>
Date: Mon, 12 Feb 2018 13:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211211741.GD4680@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073290087141082?=
X-GMAIL-MSGID: =?utf-8?q?1592194436276901132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 11/02/18 23:17, Matthew Wilcox wrote:
> On Sun, Feb 11, 2018 at 05:19:20AM +0200, Igor Stoppa wrote:
>> @@ -0,0 +1,114 @@
>> +SPDX-License-Identifier: CC-BY-SA-4.0
> 
> You need the '.. ' before the 'SPDX'.  See
> Documentation/process/license-rules.rst

yes, sorry, I thought I had understood how it works,
but clearly I hadn't :-(

--
igor
