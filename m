Return-Path: <kernel-hardening-return-11684-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224v75kMT5eK4KoJGn8v98M12556pAiw4o7Z4otMBEh5wRVAmjSDTBgMlNFMwxxkApbCnh35
ARC-Seal: i=1; a=rsa-sha256; t=1518183972; cv=none;
        d=google.com; s=arc-20160816;
        b=sou6JoCQSqb4mNW9xczQ/732FxOvDP90ozWWkm0sMoQEv43HswuLf+v6XOkSpKvw2+
         WoGKZlmrtCJ3FRrD6NdBDplLvYpcVoGjRkHO61WaNFQ44K92PzrjLOUPego68tbqVmxi
         lcGuNu2BwPnyXACMv/Z7VHiJMp0d9F4HmVkbIEYTMH4sOrggk3o1c6XdaAEOVHHeADDG
         FJoumlxXo341rr6OIguCrhkdrKSmWk4HxRy91XF9ycw4j1xHXSrdamREqKOLMQCb3zyd
         lqmiRinClbBSuYiHNqHP/7dO+ot/KLu9guiL11UiCaPdU/qT5eJ/KGzCKGcz7eGmtIf2
         ciOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=wE2r3mb+AwVoVhYxY6s2bhSrLQoi1NcIegRXzpda44Q=;
        b=odmAme2R9QxbHS2Z6nQNbJoHYVSBbT8cUe79dzhdnLs1HSlebDHFUnzkRckYe2TT/t
         f/M3dizYiBA4npx3RDA5bNMa0Oki31BWVs6fxWClZ0QVIEyNQ0TuD6bIKvGkjLlegsTY
         eq0/sKp+04/kGSQHZIHWFx3ntLbJe8gFexudaJhapWjctdijXm3aRx0wK2FRh3ZC0EPO
         1U2wTUv3RuIUkRO1qdzVq/l7pI3BsnWdOP83JYoQJ9JhvDw7X0OgM7OWUafip5Z9RKTO
         3GPQQV9RH5yQkW3sNxehWQ8OXA1GX0RPBO3YmNZf3QrwpLEkAQQIkkgZXa6rRjRWkXkR
         DRjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11684-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11684-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11684-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11684-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Matthew Wilcox <willy@infradead.org>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com>
 <20180206123735.GA6151@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <822b2358-4c62-b832-01f4-84756b1f02b0@huawei.com>
Date: Fri, 9 Feb 2018 15:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180206123735.GA6151@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591931277036411437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/02/18 14:37, Matthew Wilcox wrote:

[...]

> LOCAL variable names should be short, and to the point.

[...]

> (Documentation/process/coding-style.rst)

ok, will do, thanks for the pointer!

--
igor
