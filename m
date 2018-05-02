Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525229473; cv=none;
        d=google.com; s=arc-20160816;
        b=ibQG9bXcoR7BzPB+I7VsSAw7l5JPbBJ+Ycym4eb2RLc81trbFs9HGCTL2vYp0gG+D3
         fB3eIg6Ecu0p+LsqP+DAVb7h7001yZTrG+bnbshM/hTK/clcejE1eQxIs5TXOdgUIOqZ
         rqU+DVUW/jVaGnGtAPfdMcTz6j0Tw3A625DA1qnWi1kfWs64oG3GgIXoImbYbYRDSij6
         exBCUMsq1RNQW7uHRgiLxZt7TklTtHEfRdmKisjjeHEfL6VmF4e6dOIvx772kU37H9XW
         5qIZg/L7c47e7aCsUvI/jsTyGsofELVlMPYzNqjzU3sOOyHH86J62k8jpGlGbWnJHoYs
         CvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EXuvHus5bPhIdgT94QeQIGzoCVY/NP0okj8br+zPRug=;
        b=cEyGnnpnrtSpdZzsKomnybqlPAPFU2lglNvpmgkfPEEIKd6mEa33mH0o/N6Haa6qxO
         PCyAUeiXEBRUSmCNZ8N9UaGTHADWwnBjcJW87561a/SbMqFRQE17gK8tWWqdnZEMZmfa
         wMLxBAhhXklTpLI9Nv0dLuvM3H1RH5jogbqu4yNAQKZffUrrlXfiBgQPm9MO5FC8gEMk
         9eurx/VVtKacAMy9LLgX/umpPuucFsKNnwp9UJHknHeiGLNN7WaZxXM/0FHmPpqqLokP
         ZvMmLPcWiM+o0B7nI8KlmCc7ZZmqjV05EP6pK4u0aF9ABvZJdy8uE7AynHfhALFNBJVE
         wMRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DaGBUf2g;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DaGBUf2g;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZpGI75sK/bAUb3r19lj2FBWcOx8lXluofgGE3AsnRNtHp9KxQrp37yoz+bhlA1LVLJXP+AYHQ8t6w2YWKRlUbo=
MIME-Version: 1.0
References: <1525217620-4107-1-git-send-email-me@tobin.cc> <1525217620-4107-4-git-send-email-me@tobin.cc>
 <CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
 <20180502012758.GD3791@eros> <20180501214507.22138131@vmware.local.home>
In-Reply-To: <20180501214507.22138131@vmware.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 02 May 2018 02:51:03 +0000
Message-ID: <CA+55aFyabvPf__dooGg-E7jmdt9qG1cypVZYkWhaBD3UBBbqzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tcharding <me@tobin.cc>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	"Theodore Ts'o" <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599319021068307452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 6:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> Except for where hardware vendors control what random bytes you
> actually get ;-)

In which case you should just use "nordrand" and be done with it.

.. and you might also want to reconsider your other life choices, because
honestly, there are bigger problems you should worry about.

                Linus
