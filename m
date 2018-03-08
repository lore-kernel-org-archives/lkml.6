Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELvVWotMthKRxj006HTSBHF+YAu1OzsE9zVxL17xA/0ygZtn8YjAEbC8nQ2afSq5TrXsuJ3h
ARC-Seal: i=1; a=rsa-sha256; t=1520530126; cv=none;
        d=google.com; s=arc-20160816;
        b=IGcvyG22tqdsHed2lmk92vz4Tq1sTeeNIzTa8PwVf5pMOEp3G4z0uwD7R8U9+Qzwqe
         VJzAmGMNjAGcG0ZEcbksL3lqYYmf7N6k9FuM88fJY8AyL7QXK/QS1wSQru5b/nS+pxgl
         U9SD/9kda+ux0XeQVa15+tAIqKrK9PXnPMys6GYSonYVOOOewmxps/K1i0DlXu4+HcMt
         yjbAcDYxBRJN6d9bwwUMlVGGXUKe7oTqEGqbDYQH3BUkYzY8XIbfs1AZlfy6rPeRMuUF
         NsdcE9CvI5xnF1wnYVaxQEvi9ngf6E6Db/kQZHHyoxMvfNs4jnsEzw8Vn0uIfnTTGa04
         IYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=d9MvjxX1QYEnFak7fWiXxQcFBS1MT3l2dJEF4URXTuk=;
        b=iU7wshJD6fM22Elg4OUY5MOyt1kszbVNLyVAn6gPVy+YjL9rY3tx3vqtSLdFM/caoD
         uITSTVrugKyqEVezS7ys6rgg8Q4K3/YuXQWZzJx7f17ojXG7EIj9F5+e6rR5Fzk4IOUw
         +JJv1DPVtZ2G30luG+Ej40HRvnBP6tXE6okZBDIZF/VBZdUlWZDB+/wSEYTZl9lGet1J
         k19Idm0ywNIa+BkFa570TyxWXV1hA4YC4KeiNcX+6oXejGrykseiz/NH6m2y7dolXruO
         GOULIQ3k35Y6d0UOpEWsxOANTdjQTMLIRoqAqigGvOOLzrCLfC9ElfvtdIB3Lw7XOn6g
         o2Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Thu, 8 Mar 2018 10:28:44 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, One Thousand Gnomes
 <gnomes@lxorguk.ukuu.org.uk>, Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>, Tim
 Chen <tim.c.chen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
Message-ID: <20180308102844.6c7f7e06@lwn.net>
In-Reply-To: <CA+55aFzii9Sd3MaLz=FPf1Z_aAsZU16_+q-pvkSGHhU4-7QS9Q@mail.gmail.com>
References: <20180307214624.D4361772@viggo.jf.intel.com>
	<CA+55aFzii9Sd3MaLz=FPf1Z_aAsZU16_+q-pvkSGHhU4-7QS9Q@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594391397488270496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018 13:53:06 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm guessing this will go through Jon?

Sounds like a fine guess to me; will apply shortly.

Thanks,

jon
