Return-Path: <chenl.lei@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523872707; cv=none;
        d=google.com; s=arc-20160816;
        b=Jer2jQvxmskFHmp5GRstHyte/jD+eM44M2PuA147pgWQT6fwPwAVeYokK+fc66aWnW
         r08LOpWYft/+FMjPKOyzxVlZ68DintcpHVxROuSVr7gkqUYeExUZ6ITZeJdxQV6E6tfJ
         KPRWIbJ3jUcjcAqO0gABwPX31aXX4dFsYzWXoAznPiYR/j2rEdBOe1LTvpiJ9BvBgTtn
         cR9jOEKzEBt29VFy/E2BfYJMTloHMHVh5ylRjF1UMYrkDbEyFV3uWJYlp5kdHALTTM5V
         hxnTs3PHdM+GUmHzZ/sy3fqH12gQtqEeISyo/lwpjtOrjG+TRWnbVrOgnFKuE/qVh6rt
         sw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=xKap+xlMdnKoNDfzxxAVd90nJBhQvPifEB2fHWdBkXE=;
        b=Ocvre4irY37xR1F66pZ8xq92cSuDaMo8cbYwUtnkugGCR+7yYXYCGGpgvLy9grCmG2
         yRrShUp7K5HSh+B65o357OU8dx8UUXed832R8eC0bhIFiu+NYQ0CdCnhAnfNPoWkyvLG
         YTiG+/KdO/vciUg/+WvZjdGwMSdWK5GPTQsYyBuBPY+fSZPGmLlcXxHqnCAGXI18yJLj
         zjsGHXxHGYKtG/KWnIb4yghvQnwEN+BlhO6fY/C6iGrRXLdcDZAyM8P4zn6ItEPHnggy
         0y/NVDDX2YExFgXIUB9KQ6+JKidy7x+q39CMoFCmS5EnEJz0ari9ayQMktGOLvoqUEmf
         SbWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MHjZxgcM;
       spf=pass (google.com: domain of chenl.lei@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=chenl.lei@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MHjZxgcM;
       spf=pass (google.com: domain of chenl.lei@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=chenl.lei@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/AtFjWwX3uexxfxPuveV+cAxKfU9VutyTODgxDnyXL8d9rvP321Un7yrvafQcXbABdDVZJ25drzWUu6ov/buY=
MIME-Version: 1.0
In-Reply-To: <20180413202432.GA23021@kroah.com>
References: <20180413202432.GA23021@kroah.com>
From: Lei Chen <chenl.lei@gmail.com>
Date: Mon, 16 Apr 2018 17:58:26 +0800
Message-ID: <CAB5AJuW_09u4kRAM9qj3M05QvZSkcbhDa-CeOC=nxUNt8FU20Q@mail.gmail.com>
Subject: Re: Linux 4.4.128
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597896347963351288?=
X-GMAIL-MSGID: =?utf-8?q?1597896347963351288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,
This release has build failure on file tools/perf/tests/code-reading.c:

tests/code-reading.c: In function =E2=80=98read_object_code=E2=80=99:
tests/code-reading.c:186:19: error: =E2=80=98KMOD_DECOMP_LEN=E2=80=99 undec=
lared
(first use in this function)
  char decomp_name[KMOD_DECOMP_LEN];
                   ^

Thanks,
Lei Chen

2018-04-14 4:24 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> I'm announcing the release of the 4.4.128 kernel.
>
> All users of the 4.4 kernel series must upgrade.
>
> The updated 4.4.y git tree can be found at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
.git linux-4.4.y
> and can be browsed at the normal kernel.org git web browser:
>         http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.g=
it;a=3Dsummary
>
> thanks,
>
> greg k-h
>
> ------------
