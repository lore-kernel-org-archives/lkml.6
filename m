Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518700630; cv=none;
        d=google.com; s=arc-20160816;
        b=WVbL6+6DvguuN12Mr89nHRzwB6lVF5GqVTBbgKNTq2MfGgqkURc1hmySpcBSR7y9oC
         8+0F1e/kkFDX6at83XbvuGFwkjqB6wdCao0mrAtde0lX/S+lVGzvePhLvzdWZMNiXEtT
         xCOkTJxf7b21i0KQe1UspDXdCofaw8dqiQDk7E03NgO63wsGPfTWoHtw9VGpNmfPQTVo
         rXZ0KS3iQFBXeIuSq2t/2B9wG4CPM/n6QJgNw4L3RtLcu+0W9nUdcP7jLqaqEtEZ38uX
         Ekox3dhvvgYSM6IF9qqHluiyywLRgzipzba7e84b352A9HgUpO4djtEM4yCXEvNZzygn
         q/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Q5sW8U87JpT4Q9pM+x4lacU5LpLNNY6RwsWFKu0Gi44=;
        b=OB8h1I3A76tM+G4XVbLnJqjW7JyA2Tb6ybu4sSF6srHUR3Btyk47zxw6EakL+96Gjr
         GK9d7MM64N6Nctf69rDgjY9+xlO+5o+wXjvwzzLhwRMn6b+ZwaiWAyU3UlzMV9hvlWST
         U1xR327n/PlGPgFawU8kXJoP3ERU9xH6Gmr6aaIOOkntoOzBtaBsKFfXIxc0rpL10mvr
         aTcRfWvjsMpo2pQ+BX9toEgqkm5eXXoI5wEl9m9ZOLy4Njx0uL6Ra9kzqvMVEKPxl8ol
         TTJBtbZTbFnMGJXKlXK74/OBuJ1eadJ6pas7sst+E6BrlT/+iyXT44/TNLOVh7yzZ9xY
         Nx0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y3t7/w/S;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y3t7/w/S;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225zKV1Rk7MN/e1QdaA40piiE7y8rKibM3lH4kwf+L4zaigxFFMMF8USZIK5FUAdC6PUvilZT6+oNmWDfhVITQ0=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <20180215095320.GA2112@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com> <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org> <20180213210438.GA6569@amd> <20180215095320.GA2112@amd>
From: tedheadster <tedheadster@gmail.com>
Date: Thu, 15 Feb 2018 08:16:49 -0500
Message-ID: <CAP8WD_ZuYCZW42DXeunS8NvKdSA739Sdrr_oBaxJn7MxfzrNAQ@mail.gmail.com>
Subject: Re: What was last kernel that booted on hardware XY? database was Re:
 [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2A
To: Pavel Machek <pavel@ucw.cz>
Cc: Ondrej Zary <linux@rainbow-software.org>, David Laight <David.Laight@aculab.com>,
	Arnd Bergmann <arnd@arndb.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	Eduardo Valentin <eduval@amazon.com>, Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592460207317318961?=
X-GMAIL-MSGID: =?utf-8?q?1592473032122220886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>
> BTW... I'd really like to have a database of machine, kernel version,
> cpuinfo, config... So that questions like "what is the latest kernel
> that is known to be running on this hardware" and "what config should
> I start from".
>
> For example, I have nokia N810 here. It was supported by Linux at some
> point, but then we moved to dts, and stuff changed, and I can no
> longer figure how to boot it.
>
> I guess "what was last kernel that worked on Cyrix MII" is also
> relevant question.
>
> Is there such database? If not, would people be interested in
> contributing if I create one?
>

I am interested and will help. I have i486/i586/Pentium Pro/Pentium
II/Pentium II Xeon/Pentium 4 systems to test on. Oddly, I don't yet
have Pentium III systems.

I think an associated goal would be to fix those broken versions.

I think this is a great project for college students to get experience
with. Who else is interested?

- Matthew Whitehead
