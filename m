Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AIpwx4+VfDPHSw1jD14jgOXRfHHitme8m1zf+2KeNioLb16/+w8CAKEYUErRGU0eCz3zbtGm6+Gf
ARC-Seal: i=1; a=rsa-sha256; t=1522950839; cv=none;
        d=google.com; s=arc-20160816;
        b=QcAIY5RWmxGhGp/1xtr0sUQmBAz1sd6APCoSyJila79beCtJ1FBPk4+YVGOf4f3mjK
         DAw17zNMw5wHLyiSTk7N2wqHuiEDEUJeny6N1+z9kBJRCG9Kw/I8L3e4fnMm1W97Hz7I
         n1IB2sEeZmE9Km3l4iRVtF3e02BvY7HXb+Y3ZZCWG5pUMo776GkJ5GFTorxLB7Y4pf0Y
         xfFhKb3W5+qaS8ZTMDbQSVNDxqHD6HN98oVZ0oH/m0yFTdnCrAREHov9ilTftQxA0zQ6
         AYmNClDEEQRCX0j6pHwg3ClWVf9t5h2WvTOgRoebE+f0evcG4a+/ej4tuet/qTHPR9GU
         1z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=gTo1SJRTi9AndskhrmEqCaqt8msxKb+PzdHqtIm2K70=;
        b=JrBa3M3yKXPszeKqjz7phd8rb2CwN7H8/EY59j6qcH6mbG8JhY2qBCdvHSGyvTfsjV
         D/BDxWksxwAr3c0KB2kN9lVHmfopNWhQWKjAWN4ydlJWxQD6rgzZB+E16WzZnxmnZCag
         sLK4P98GD73Icpr4i91C+XmFYvOlq2ofpJ9JAaqQDil5XofM/7ggJNUbenwQhXhM5soW
         jVs/wUAwortUIq0OIg0zXp+kF89K+nuYjvB05UighzLqJDsXal10v0/V0c4ttETYPiaL
         kRH+BWd1qInWYpbSjvWQ591hl6VRtT3ZCMiThKRqB2cLQDyTwyGRKcjA42iDTsGrmjPF
         NBKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Thu, 5 Apr 2018 18:53:47 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>,
        linux-efi@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, joeyli <jlee@suse.com>,
        linux-security-module
 <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180405185347.2785eb8a@alans-desktop>
In-Reply-To: <CAKv+Gu9Na0j=T4syinQhPNZTnbhvnpDXR+Za73EmH3FFXV6KHA@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<17792.1522491600@warthog.procyon.org.uk>
	<CAKv+Gu9Na0j=T4syinQhPNZTnbhvnpDXR+Za73EmH3FFXV6KHA@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596848216178927191?=
X-GMAIL-MSGID: =?utf-8?q?1596929699442105474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Furthermore, there is a fundamental deviation from common security
> sense here, where things like command line parameters and other
> lockdown specific tunables are blacklisted rather than whitelisted,

I've been complaining about this from the start but it appears to be a
write only authorship process going on.

Alan
