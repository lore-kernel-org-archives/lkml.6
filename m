Return-Path: <dhowells@redhat.com>
X-Google-Smtp-Source: AIpwx49rwicgbN6u4QD8qd0ckUREyb5hl/tzxfVFwDTb+CaOTz45mBO6vnFnEt0rH28pAERTe29u
ARC-Seal: i=1; a=rsa-sha256; t=1522853071; cv=none;
        d=google.com; s=arc-20160816;
        b=FUNOHKa992mzuEoSB3LM4bVXRo3CAYxMYB3qhc0OEtr1olIVeyNJXg5o993sgt/4eE
         +PnMRFFCAhJDdkisEK2G/Yi92ZvvGyxGKMd6pbxvvanIAKEkh5/Hp7vf6GOOekJC4hfp
         pvwUnYBjQ5Fuca3nXMCFCl3uYjEv9hZI9rEecGHlD6XOCwK7OILenDGpY+6ILn0IaikP
         QC8uzPgp7ms3Qo1tX9ollakhmVxbXoPZjcZ2jleZrqZlUj6tzJ6TvpO5DB4mB0xOUwEc
         rqXdXPqwuNR0QwK9PhnsOJ6jdSgw0plGOMCDq42BURPYckZKEAkK59fufxSbYhzvoOZ2
         k5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-id:mime-version:subject:cc:to:references
         :in-reply-to:from:organization:arc-authentication-results;
        bh=mNzbxmII1t3nR4ny0zyqZAdK27Ud9LTyAqCJGmbBO/Q=;
        b=Z5tiOfP9kRRqinPprLzPIff7rX+rOmbbFaRMJ63exf3XTpXsvegM4HoXi0Q6sMuGOl
         0cxrPWZNj78PEZ5Erd7lgrHaFuS9Jp9VOl1jNnL4Nj0FfOhJFcidUmMrC/Yxmo3Ao0M6
         k7egs4OPMv2XDucNYDZ4GE74dYRPWzqNfuCedx5RaIcLCjzrHhI3ra8li48RR5Uf4mUI
         uu49jD1jGBVPNr0EOqlJvJfIQNC9zfh1/zJIY/8j/HFnJKMLe7kIKGxXmg5WPJg8og71
         1nSbnobNW4SXyJk9ZHFlkGCPzPO45nHHLBzj6DWZChgvefT1nE0d5bzZKWXl/zW1u+Bx
         19Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrUaKOG1q43W=UBPue5TAL61zzwzgr8QeH3Yh6KsMUA2aQ@mail.gmail.com>
References: <CALCETrUaKOG1q43W=UBPue5TAL61zzwzgr8QeH3Yh6KsMUA2aQ@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com> <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com> <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com> <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com> <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gma
 il.com> <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com> <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com> <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com> <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com> <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com> <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com> <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com> <20736.1522829117@warthog.procyon.org.uk>
To: Andy Lutomirski <luto@amacapital.net>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
    Jann Horn <jannh@google.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Matthew Garrett <mjg59@google.com>,
    Ard Biesheuvel <ard.biesheuvel@linaro.org>,
    James Morris <jmorris@namei.org>,
    Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Justin Forbes <jforbes@redhat.com>,
    linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
    LSM List <linux-security-module@vger.kernel.org>,
    Linux API <linux-api@vger.kernel.org>,
    Kees Cook <keescook@chromium.org>,
    linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23978.1522853068.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 15:44:28 +0100
Message-ID: <23979.1522853068@warthog.procyon.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596827182093384171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@amacapital.net> wrote:

> > Andy Lutomirski <luto@kernel.org> wrote:
> >
> >> As far as I can tell, what's really going on here is that there's a
> >> significant contingent here that wants to prevent Linux from
> >> chainloading something that isn't Linux.
> >
> > You have completely the wrong end of the stick.  No one has said that or
> > even implied that.  You are alleging dishonesty on our part.
> 
> I'm alleging that the idea that Linux seems some particular policy to
> avoid being blacklisted keeps being brought up as a justification for
> these patches.

No, you were alleging that "[we want] to prevent Linux from chainloading
something that isn't Linux.".

This is not true - at least, it's not true on my part; I cannot speak for what
other people may think privately.

David
