Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x2267VQkDtexCTfD9yNPajmqI9BNq4vngMmxSWInFLVp7m3RvaEhGFtUfBdnoCzii+pFyumr8
ARC-Seal: i=1; a=rsa-sha256; t=1519618960; cv=none;
        d=google.com; s=arc-20160816;
        b=UgxG1M4U9KBOBRfQ7jXYMV6uUsm+la3wBucfvq+4AEDhvazolz8hwfQFSbD+Mhzr5L
         ZRbvlLl+C+P755+qqskPG8PpF6E0e6/VCJv2r93+MmkziRuaO3dJdiPbds/wBM3tnsDZ
         tqSBJwYaUmgc4Dul5JlZjdoFtKU/Ioqldzi8OUCkVvnSSTqE+84ebPZ8ZX6ypHIg/5LC
         iksVqaAUOlr6Hz/P1td7G1TmxtRnc55nRvH62Igg6AouTEp7zr1MxuegAiQGR+kIC7Th
         CbqRhz0yy9E2yYNC9VQDfgeG4vTx60Mdfbghq6ZJTl/JWogBYwkDi/+riM1e6FdaKEES
         hgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=++tuMAxs7wseHUUQL+HiCg2vdW5dbVaW8NdiDK0DBno=;
        b=PeTd771d3LvTMC2OjbkaqRTx3/57G2xLCMYFTCsSJ4kW1UCOIbX6I5qHp3d2c8Jdjx
         ZmCfu0Y1+HoYMmkoNW6n2W4bVE/vvBsV0pGuNB9qrA/f51ccu0IhshBARw67U1iuTCsc
         3j4klnmiC5zvvjvIbrFEoNet3kqS6I/mPnRuBjhMlZYlcnrmscntqr+HSkrw4L8pIHQl
         Ts1JsKx1lkhqanuqF7SISibxLh/WVoYlWnXcT26gi0QIwlZnrkAKmE2y/w37bUU81RJp
         UmhySpx67K/cPVURyKOBM0YYcJvbMeguUyyaxaCO3W6Knwb37+3CePq79qY9/UroDxE5
         vbQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ZSgGt1Q2;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ZSgGt1Q2;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] linux-next: SLIMbus: doc: Fix a warning "Title underline
 too short"
To: Matthew Wilcox <willy@infradead.org>,
 Masanari Iida <standby24x7@gmail.com>
Cc: sdharia@codeaurora.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20180219135550.28627-1-standby24x7@gmail.com>
 <20180219143226.GA24352@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25e0e5fa-b79b-b076-3744-fdd01b089984@infradead.org>
Date: Sun, 25 Feb 2018 20:22:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219143226.GA24352@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592837884320180932?=
X-GMAIL-MSGID: =?utf-8?q?1593435970851834750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/19/2018 06:32 AM, Matthew Wilcox wrote:
> On Mon, Feb 19, 2018 at 10:55:50PM +0900, Masanari Iida wrote:
>>  Driver and Controller APIs:
>> ---------------------------
>> +---------------------------
>>  .. kernel-doc:: include/linux/slimbus.h
> 
> Is this the right fix?  Shouldn't we rather delete the : instead?
> We don't normally have a colon at the end of subsection titles.

Agreed -- no ending colon.

-- 
~Randy
