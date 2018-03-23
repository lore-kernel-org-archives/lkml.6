Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELtwjTOOpzptulwQsDAem6PBtDwGF2NvRfCriKWMNYvhjiiQd3knFYxCCM3fBzvC6W8chPJc
ARC-Seal: i=1; a=rsa-sha256; t=1521829742; cv=none;
        d=google.com; s=arc-20160816;
        b=BhA1tv5WfSihlcZcG5m3GBhc+QVrY5lKjprlrjtgzGHYSibrrH8cRU/QEUUHUxSMVz
         TWMe0ALqca5zajd8/VqLwraN/3JG6kmtc3BU2Fb5V+oFiEt3CdHyALtEPtbkEGRC441m
         kurhgvIu1uOXJOvN+ro5BKe+JsuyQmLhdEdAtaFbN8v2nLE/AGeh9V6Nf9/idGNpKBVo
         d6a6uL7nHStzZANc/9TmVYfpJ9loqi9EtxsbJnxHVzB3Y2apMf4NengslduhzDJCxfeH
         vG8kPboyPxAZ8bhpUHz64sY93V5esY5AxC+fe3E1idLBV1dLM5r6xvzDpXYLOBTwvISk
         i7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=n41gt2yzZWzim8ldPctZ5GktlQzEVrxR8jE/UlzXkoQ=;
        b=LbVHYpmu6zBgtT75ksmwOafnDvoN89iP9Gd0kyCHmBVa2LMob/k8QFUsf6ylsfCYmj
         7BuUOANb0yCimQYjcC01ivLljO8lZoZ3Ob+JpnMY+0WyQ3KEznAWpqWe5wnFlJNCKn85
         hTEzzcl2WRktZwOm4SgtnIDFTAj+25ns4bqS9nPBbxTlbLvzXTxjDVwFZKR1g7iO36RA
         pBuR/rGjEUkOgApkbFr9P4vAm1V6qa6gwPuYdMxo254NwUyo2gMmP++K365XazVq0B90
         ZX9pR2HQ5p2Er0Dg7QI21vHUlZheAYK395h31iFnB1VlPe3lfr2RM5qYk4GUPdZ0Uzjk
         w0nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Mar 2018 12:29:00 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-doc
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] COPYING: create a new file with points to the
 Kernel license files
Message-ID: <20180323122900.733d9d42@lwn.net>
In-Reply-To: <20180323095106.23108-1-mchehab@s-opensource.com>
References: <20180323095106.23108-1-mchehab@s-opensource.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595754144301143291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 06:51:04 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:

> The contents of COPYING file is now duplicated at two other
> files under LICENSE:
> 	LICENSES/preferred/GPL-2.0
> 	LICENSES/exceptions/Linux-syscall-note
> 
> Also, a new file was added, with describes how SPDX should work at
> the Kernel source files:
> 	Documentation/process/license-rules.rst
> 
> Instead fo having it copying the contents of two files, and not
> even mentioning the third one, replace it by a file whose content
> points to the other tree files, preserving the Kernel's license.
> 
> Adjust license-rules.rst accordingly.

It looks like we're about there with these, so I went ahead and applied
them.

Thanks,

jon
