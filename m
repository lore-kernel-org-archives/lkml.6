Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523902552; cv=none;
        d=google.com; s=arc-20160816;
        b=YdL7kjCtWzy86TgUrS690QaD8gCP7Nh6IJxalcYBthCiVqpehBPRDNr7zWztV4+bha
         F8Df0zZYy5hJnQammb2zxI/XaRcHeJKQf39jK7l7iXmawmh4sCd0qqLEh4CkPqlIdqzx
         GJ9ZMG0DeMul2eE32ZBjTFl6gOQDm4drSS8RxEtEcOxxwDVRSYiZc+yloRveG7Hf18ef
         muNziiwE1E+j+ClpMzdHlA5An/EHeEiqdpJeaeWn243/fSvA0SJm4zb072yeZhhxC9nr
         va4whoOE48n27X6BUHppJQsz0+/bKtAyjeum+2QDIWyL92gIpwjZJdH7d4Q4tKAvs3cy
         t39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=HN4f4qxGJXNmK8dfH/p1LGTTBC98FLahLIBjRzcUQEE=;
        b=kNScPwwn5M0QH/qIX93UgeW7VkKkORvEV/YZWuf1MdIxN2Tx11t6gs/RDppQEJ+W1P
         i9qx0uqyiU1v5ogg+o498jOUwbM0PSRMn5DdWI48+W/YC5Hwsq58koUz6i8eMsh78mFo
         ys0RMpeeeMhsRvRG1DSrEWmf7ez6Z9z4lexjQb/N3B/PqN8RM4deHo/IbRsHaPOmqMvo
         QdXxqffy1EhVdRBmO+REcS8heQXYpCvOOgtcO4tYuQAKX+1BxWbq432AHsTYADZvnprJ
         SLNPrEnKTmZ5GVs0q4f+mJTaExIB2Q5JanyXz7DIN5eBUKxnIQ8m8c5rEk7Hc1NHNRJE
         DSsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xwc0SlXT;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=SMRBQLQy;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xwc0SlXT;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=SMRBQLQy;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4+rRcCPwf2XJdPKmua6F8wOVSPK31cYxd8VtIzr0q3X2gAgQFTdLkYMd1BTqC8SFwIamTWU6L00qI4omJgsGxQ=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFx=pwEJQHhab3gW6+qdom=ccFoWoK-aZokmqtPxNqTd8g@mail.gmail.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
 <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
 <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
 <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com> <CA+55aFx=pwEJQHhab3gW6+qdom=ccFoWoK-aZokmqtPxNqTd8g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:15:51 -0700
X-Google-Sender-Auth: smOrcMKEiRqlXblG1sfR3Y4NSBI
Message-ID: <CA+55aFwBT7xEKxoVEEgT3vjg960Tpx+CJo+4238P66Q7w-nM-Q@mail.gmail.com>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597927643406976876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:04 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I was going through the bisection, with just a couple more rounds to
> go, but I guess I don't even need it.

Ingo/Thomas: I will be just taking this directly, since it's so
trivial and obvious and I got cc'd on the discussion.

                    Linus
