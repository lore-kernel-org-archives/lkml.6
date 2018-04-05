Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522893615; cv=none;
        d=google.com; s=arc-20160816;
        b=kT7ZoZSdkapJBXGXw9GtHgpmgxT4EoG7k7FQDUaVQeucAXWhNNIDcdEH1nKRPpyEsX
         2n9R06wAPaY1D+KfBruZP1PGS8Q5mjKzaRNiRmQ630MXBE8qjCONl5oYaeO7Zx9NvL6K
         Zij7Eom4FFt/8Xqi2lqg3uK5nPmqL7J/2mgmoDd9iO/EVOr7kSKnORTrXRurA4KwJGkN
         5y6kf+WKpFKX/S6UvPU8h18i/7TcYSpLT67RjQBKAxCe5PXtftS6p0A2NdV8Ry7ocsB6
         ZIoEFqUEj9dhLwI16szfAg8WR6FlCH4JrEzgkpZQkF5WJcprpThnzMAfJeuKSbqlYnQm
         gE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GT+JtDq8EjErCLuWN1uZOY1yhf5GuOXnH44PuMP143o=;
        b=c1o3JGQUchNeQ/z0A0zJnoRmPDJg5Pu6p4hS1BML+4+rjMeOD0eVHAN9yDWi6XBbng
         dd+3nN+AUiC4iZdqA/VhfJ5PpEqvEoerHb+vIv6lZ91T4/v6hAaFxJK9tnYehLth/mXX
         yTw9KcH5HnRZmbrGfu+VKiqmYNaGwPK1IqG1H/NREQPbCUpVA4jsprWXZL+N8+sfzCn6
         kH19QqaWLad+q3PZv6aU3pVdsUzr5vh0sbZMn6us19zIsR1D0eMZWNtqkKCZPTWDvIl1
         Y1x+2m52krVsvqXZaIutnSH4LgkkxAMGeXfM2peipQsFfDOrLRxfQ1Jn0BqnuVAk9w65
         qiqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C5qsElO+;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=V8Z/UCGu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C5qsElO+;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=V8Z/UCGu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4+YKxl3Z+Lkz2BPKhQkrED8tkFsZ779EtRZcW1koeWr931g+/U5sz8/O2vSmOZ2mw6s9727W27yep3Rc3qK9a8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180404103219.GA11115@kroah.com>
References: <20180404103219.GA11115@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 19:00:14 -0700
X-Google-Sender-Auth: 0YhRtzKZGH7FMMvKVcmL5TTaAUw
Message-ID: <CA+55aFyD_KAqxxNSg795Z+49gimEU09MpfCKd7RvLuhk2vwYsA@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver changes for 4.17-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Driver Project <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596869696171346128?=
X-GMAIL-MSGID: =?utf-8?q?1596869696171346128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:32 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> It is a lot, over 500 changes, but not huge by previous kernel release
> standards.  We deleted more lines than we added again (27k added vs. 91k
> remvoed), thanks to finally being able to delete the IRDA drivers and
> networking code.

Hmm. The irda sysctl tables are still there in the kernel. Overlooked?

                Linus
