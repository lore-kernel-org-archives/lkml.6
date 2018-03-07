Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520459587; cv=none;
        d=google.com; s=arc-20160816;
        b=titSfvxTTmN7+LPqfwwB3ZyqxfuR1Q5x9dWgAHon+SBZ6dyHywJ0dg2I8RdQDTB0Fb
         9IviIEyYGHGdD6Km180qeZxiAIOYgp5XSB4+iJv8jJB9GkMVRT9ETC1B3HgGZ02hzHUr
         D46ApM1p4/iSWOrLFHtmWasqhogC200Kagz6SmmkliasncLU7cwCJYKrUR1HSv9nQB2r
         3iu40S9YM5pqctKaOtha17C02Z3W73+idaa3ASBh9klyg2kz7dHCTGdhFotXLDYYocYq
         sKlehQObCU99mxLKF6jPqMcjAClZD8gM4xN6ons0+oZQXmflk1dxEtI5X6STkq6e4zGX
         XD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=llujYmQ2KWvfZDiWHIFL+mX74UfO9k+yC+yslKEUSFY=;
        b=Timd62XGKCkD/xhZkR7R2bu73BiNRJZnB02DB+EYSfrdHjSPI4mePSOEOtRyoFnJPk
         L0QFJa57ATCKBpVfpxT/HHp67mQ/g2QhsdtOP/wqrstuDR5Fj2QBxXEtOdPl43uavRhN
         uq6C2QEG6OKYypUcBeqL+/yycDYSo4kxS19V6QbJh8BHDItlAOFUlY/vga+AutjY2MMs
         bEFEifbOb73uhB9yF1BZlKj3C3FstnKBM2eGQlPvOI0P61XDZQNmIR6Qj9hWoPJBRUVb
         b09gVkl0dibs+4wtLDzgL5JOYr2fv0r0VU7WMPGjfo050GBFtRI7FmY4Loa+lbiGQagN
         i4mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oelUtQNe;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=hHjtjo1v;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oelUtQNe;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=hHjtjo1v;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELt3i92X+FmsdkxaZM67HgK16RbFJhlyHvV8P7f3owV1RpYaUC34Tw0YE7t93VmJ2qw1gwKDyLpK2/1VjVx2j+k=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180307214624.D4361772@viggo.jf.intel.com>
References: <20180307214624.D4361772@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 13:53:06 -0800
X-Google-Sender-Auth: DkcwR7WGEq3R0VaIUnNQB2lzfwE
Message-ID: <CA+55aFzii9Sd3MaLz=FPf1Z_aAsZU16_+q-pvkSGHhU4-7QS9Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594317432350274559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

That patch looks fine to me, avoiding any terms that might be
misunderstood, and being pretty straightforward.

I'm guessing this will go through Jon?

               Linus
