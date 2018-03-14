Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AG47ELvAOglhgx2A/JNUaQmPoR8LhF0FKkqYzD6yfvUW7n9QfnGdE2LVeeSewRT7E336aJF8gG9R
ARC-Seal: i=1; a=rsa-sha256; t=1521032611; cv=none;
        d=google.com; s=arc-20160816;
        b=jUm8hewOtC9B+eXOe+7mOfsyRsK95Fu8diiFiC6b4Z1CMRjiyWx+ZRuT5s3JRGV3zk
         VNunJ9BwCpbYu9p8G0oV4x0mUe5KpCHi8tgKUpb3ZLwhngh9166chRInCQotc6JeOFCk
         vxuBjq/tG73T0tPkhVL19lGq2b7xFGPls+S5/tW3t3Wj0FFF5L+ctiQaDjJ4UkMwvUYz
         PMx2V+hx2FyrGvK2Kf3iq3RjUgZIPSpobhyAvyqCVqH46/PaJuIFzTJRA0ycfNfOIPqK
         TklDcdDAtnnQbCkze0BBKa1zv2+6JuuC00DwlelqHdgweuzw/CWYrLfF6+aupNGKKA4w
         QsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=pUbZ4HCQuvxhSC7Se5dwoTALgbUpDhK+yxazUUQegFk=;
        b=PQX0meWUQpWfkXlb02j75F0SSZNBGJ0R6I9HlG984pGfVoNfESL/RX6fwZST0K4PMG
         bRFdmKc/2E2MC3N0SP+N/02uAxs4VuN2GuQ8T9Md8h3b7doiQef59PO8/qUNezu3Tp44
         ENX7TiijjciKtBivrQFli5BzIx8z+pisKJwOgKFAS6NZIsObNEXzjFMxwaVgsh0I2z7u
         QUaZUUGGOcT1tO+v5nXRtiVLAhRCsVqR8FGa+HgM1TDvQnU5AJcXoNfGDVY+CfkocKuu
         cA4bLS7XY9DZZTjg9/onHYVwqHIfmchvBkF5NOmaS2G8c5gaPO0EZQPT78PaQ3152/Ys
         sR+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 14 Mar 2018 08:03:29 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: tip-bot for Andy Whitcroft <tipbot@zytor.com>
Cc: linux-tip-commits@vger.kernel.org, hpa@zytor.com,
	dave.hansen@linux.intel.com, arjan@linux.intel.com,
	mingo@kernel.org, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, apw@canonical.com, bp@alien8.de,
	luto@kernel.org, dan.j.williams@intel.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	peterz@infradead.org
Subject: Re: [tip:x86/pti] x86/speculation, objtool: Annotate indirect
 calls/jumps for objtool on 32-bit kernels
Message-ID: <20180314130329.cmsc7mqnfrm2iop2@treble>
References: <20180314112427.22351-1-apw@canonical.com>
 <tip-a14bff131108faf50cc0cf864589fd71ee216c96@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-a14bff131108faf50cc0cf864589fd71ee216c96@git.kernel.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594916116672090070?=
X-GMAIL-MSGID: =?utf-8?q?1594918291608229141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 05:28:01AM -0700, tip-bot for Andy Whitcroft wrote:
> Commit-ID:  a14bff131108faf50cc0cf864589fd71ee216c96
> Gitweb:     https://git.kernel.org/tip/a14bff131108faf50cc0cf864589fd71ee216c96
> Author:     Andy Whitcroft <apw@canonical.com>
> AuthorDate: Wed, 14 Mar 2018 11:24:27 +0000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 14 Mar 2018 13:24:31 +0100
> 
> x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels
> 
> In the following commit:
> 
>   9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")
> 
> ... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
> but we did not annotate the 32-bit path.
> 
> Annotate it similarly.

This patch has no effect because objtool only supports 64-bit kernels.

-- 
Josh
