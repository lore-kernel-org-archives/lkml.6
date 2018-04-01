Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522557513; cv=none;
        d=google.com; s=arc-20160816;
        b=loYVuSlaq/gzWQa3zTcY5TWUoGMB8HYfMWNrHYqNpLnJ2jETE5E6Tbz3Gn4EBkagwu
         cUNIdH4jNyRL8uwfP3lrPW3zlnJ6adEYTd2mZlLEtvWNYVHS9nGZpSxeIRNOB09Oo5ac
         JEDLXokOFMhu1IZHBgEFvLyhA8EZX3lwHVYdgzd/r5IUhc0M3XYsEBMrUeKFy4Z8a+u0
         Om1H4CE/d6q+JV1/6lWNfECPTadu/oEGQpIsYPyVJgXEhL5D4ZmmX99s/rizxQ29CHxc
         TKGy9GINkOOY6VWqteOtI5m2m+prYJDLoJS9AdIpt+0FwIdw60uDDnilgDDhm5iJCRrN
         olPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=RFP+z678jcyJqfc4jn7aUlMsngnLbzRNTq0aJnXBOPw=;
        b=UFJwNh52eVYM4tsM1PqFaPQyKLvo3i/Bq2UAOhOguohqrYFPcYG2MHh9ybeUFEmtKB
         df34t/o0+av185bgCYgwIVlj5tXNxgN7aemVQy1ywJn7xCE+F0dYvMExnpyxY/mw2VSl
         oD5KgwEydD1Qf2oMsUQeWdkG6CSSl4DKmcAqtH/3dg2ZhT2d21xmBm/tUqz4ak8lRv3w
         Ad9VGdWrbDsHf2o+bgw4zaIe1Rl8ZppdLtXNkKviRYJr/b7Huh1ztjDshL0Gj4Np50+o
         4tIYYF/4NVieyQmQj9rfFyWuT8TvVRg5/dtXvvbRAoGKGH2Vw9pEtklIfs42tkM3ZA1i
         LHzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nMnh1xRV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nMnh1xRV;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+x87gywMMMGFcrH77sf83Slhhw0sIeqpFIg/t6BgWhBhJPKiKnRI//SLlaP1nYLct824VgCHRNO2QcOMVlq7g=
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-9-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-9-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 1 Apr 2018 06:38:32 +0200
Message-ID: <CAFkk2KSs-Xw7rYaYW8F78B+NNP+7uDr=Aom5k3EKGKZU_nhc1g@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] kconfig: replace $UNAME_RELEASE with function call
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537399690417?=
X-GMAIL-MSGID: =?utf-8?q?1596517267122909087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that 'shell' function is supported, this can be self-contained in
> Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
