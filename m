Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208529; cv=none;
        d=google.com; s=arc-20160816;
        b=nNzdEGONXYWKhgAsqybT8qCJ+Q6JJJs/BcklTApwKBG9j6EPcXQ7eqHrEXxnIddKiC
         4OcSa1rfecWkndOUpSokQ9odblWw9ceVbIjxsb7KqqL4I+efXuyp7JRoSiYkGUMkvsMQ
         g7amV8DPXLJJED8Kl7NDGeUgL0ec9rH7vC5UiG0mZNNc9BSDVZ+W7dmXRb4opm2qU4eN
         82zM6vqIRuof5kPk8EernpvgOVwK+Qyl8v+jZGyKeYvmJfL+pn+gMo9kvyoH7a0ywRkm
         YlqQAim9HIYDbAQr3CE+UBNQgPEU4q5PNvmN9QvWoNcJeq+q5irxf/OZHtDWooNV9/hF
         VZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xNqXsRVoytwhiEi4Fk0Qp86RiOxYYU6TIRMjPJHJBAU=;
        b=Ht1QFycr8UyL2HMNpLAb2LJC/2CACbsji1FUKeh21R7ZoKFbDVIegg7en8BDaX9ZDP
         8ifON4vj5ZkkpgADPYNRN3fl/hKDUYf9m+hVvptk6VI6BCY6Ker/hZjI7qXDxMN4hYVr
         V/WRJzKPfQ/5TZgDY8TLwLTl4Ey7QUknoEIbEPSo48UyXkcK7rT1dGwtyzewz2ySmFKL
         Mzb30PccXTmZ8Z4FwgXaFPfy/0CF01NmvPBnwRhxIk1MwN1PSeiwFdm2F+2teZZSPSRl
         ++dA7AzO+cby7ZX4rveHEM0tMHMex9RnRiPvrXCCNjFFlG4LHi1RK9DNmfNWWsMATbzx
         NNQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DsWumgBJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ohv9Ohvk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DsWumgBJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ohv9Ohvk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48pucnxiI95YGSBr0zZ/qC+qa5xDRzz5L40EpGIjyXYizMtssL3UF/sDujKk5NTog56eN6jiTsSr9EaSkD3Slc=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-9-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-9-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:42:08 -0700
X-Google-Sender-Auth: J9_qF-HHeCmuNykwF_RgRQHidxg
Message-ID: <CAGXu5jL4ff5uUzX+mdmtybjB1+iN=eWED-7ARrFF1d8OF3XH0w@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] kconfig: replace $UNAME_RELEASE with function call
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537399690417?=
X-GMAIL-MSGID: =?utf-8?q?1596151330941693421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that 'shell' function is supported, this can be self-contained in
> Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
