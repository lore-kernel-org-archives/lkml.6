Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELv/e/BBT4nMaEsiRebYzeMGc4PHh1PpOrnH+gRmFxHOHcF5IrknE6u939QO9PoReylYRmao
ARC-Seal: i=1; a=rsa-sha256; t=1521720841; cv=none;
        d=google.com; s=arc-20160816;
        b=nfk9tQ3mL7KaCVxnzBylnewRbSrTvtbo7DP3KsZM7sNkO9HpPhd00dl9iXjpSWkWpV
         B7rHhMonrEWW2XetpUgBe5I8GlGg7HUmZEmjZR3bgbfK5WF1cUHr0gZJpqTBXtNLr0x9
         XR7cJM56x89xXDMZlOKHxnnzx+sF+eKyYHcCxdarcGxr5WqMU0Qu2XjyAxRZF2GXMnEZ
         0XH77WfCOJrrBn+WITSFCrl4AfwEC74G27MH4LNsnIfkUnmJ2lgiQGdKN1hDcHOHeJtG
         mlbyT9tdv1MmdKtSdSK0O9wPRfryGBvt1Dtj3JQvgh3RVbGmKRbTw8lEImnZ8F9aYKr6
         ZRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lZIutr6gtbbFpuS0zZDPfguJNG8bxszrBBoTu2KiFTo=;
        b=jkxNp34XOAZdIWopjCuQNx7xVZkGVkFz7Kgli8J9CBV0fnz1azvx37QvG58+HXBqrk
         LiQzXlg0NSa25svn4nVbbRJ3jaD86u8VtUFYl6Ny7DXtsQBls0t64jTJYAADV/AQ862n
         wpST2Cq0b8e4oADFHrUsQpmK8Xsm9djeW9Jr/hPHb9jkww70jMXQ36GTwwLk9j0YBfDi
         VxtBjux+5T887qyaSnYRvJonqk0sCnol9JbP5rczhDgEc1En4dkGA3o6H5VqeVbN8oJU
         3ZlJsnTbBA1TGtav7tgToGb0vZ7qMJKM/fJttPKybVCRXpf8VNLFNBW3t4DjIFwYrNe/
         q2LA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=bjD562Re;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=bjD562Re;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Thu, 22 Mar 2018 05:13:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
	Linux-doc <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] COPYING: create a new file with points to the Kernel
 license files
Message-ID: <20180322121355.GA16195@bombadil.infradead.org>
References: <20180322095414.24019-1-mchehab@s-opensource.com>
 <20180322095414.24019-2-mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322095414.24019-2-mchehab@s-opensource.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595639953273299154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:54:13AM -0300, Mauro Carvalho Chehab wrote:
> +++ b/Documentation/process/license-rules.rst
> @@ -4,15 +4,17 @@ Linux kernel licensing rules
>  ============================
>  
>  The Linux Kernel is provided under the terms of the GNU General Public
> -License version 2 only (GPL-2.0), as published by the Free Software
> -Foundation, and provided in the COPYING file.  This documentation file is
> -not meant to replace the COPYING file, but provides a description of how
> -each source file should be annotated to make the licensing it is governed
> -under clear and unambiguous.
> -
> -The license in the COPYING file applies to the kernel source as a whole,
> -though individual source files can have a different license which is
> -required to be compatible with the GPL-2.0::
> +version 2 only (GPL-2.0), as written at LICENSES/preferred/GPL-2.0,

^^^ you dropped the word 'License' here

Also, I think this should read "as provided in", not "as written at".

> +with an explicit syscall exception described at

s/at/in/

> +LICENSES/exceptions/Linux-syscall-note, as described in the COPYING file.

This phrasing is awkward with "desribed" used twice in the same sentence ...

> +This documentation file is not meant to replace the Kernel's license,
> +but provides a description of how each source file should be annotated
> +to make the licensing it is governed under clear and unambiguous.

I'd rather this said:

This documentation file provides a description of how each source file
should be annotated to make its license clear and unambiguous.
