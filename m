Return-Path: <luto@amacapital.net>
ARC-Seal: i=1; a=rsa-sha256; t=1522852541; cv=none;
        d=google.com; s=arc-20160816;
        b=izo4I0jLcQPexFQb64Ss/NG7HN7lz/XZe05Gd/3Pmj6cbH23IoVBzqy+svN5b3NS7p
         MmD1fRQlZsV+8NjxDmIMFN8yOoZEwhICL2XTMwfcQFmVnrYfFnnobwKO7w82VXMV1Rcq
         mS4Zv8+q3DVF0KDEz1R264O4Fmq4nYQOu469/Y0xThqMMOjUd1CKFjgambQvclbbpRaQ
         0IwnPCEvu1+qUqL8uEn+nFHakysYAZwu56HszdoN6HIV2P1/6eE1+EgNzZEJAyyr7Fxu
         zCgj6rbMgnOZC/K6mVDiN5p/1qXFN4VAE1o3Un8xiPvtrFWuJ3CL7YAKqVcY/HReKSCG
         Z4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9gf2YKMTqTO5UFPJ6VOF98XiPNso8BhGN/R6e2xICjk=;
        b=QqPhEtMMzrA8L/9L2W5M/ibwzSyQyBADqPCtpRyc9YBzFIAV9ft0DmC/HCVPyZfvWi
         umUdZriGu1FICfP8Dq1YxC5aFkfgsvxwntBoUOojP+gYQF0pxmsVdDraNyCJNc7b1Qr9
         8/JLM7rMb1b2X9gbHKK1Wa9vtGEHUHQTEkrBEI1ryF3Jmr4LJZevbpbrGBIdVAmcRfFp
         ItXJd1Sz+uaoS4lV6qdmjNn+r/OSjedSXPvp+xz+P8havNGz0AJk3tN6tlxkgubPvv4d
         nfSckVFYTV0oRfSYDT5Q4qq5i/XXZIgpSEaF64AnSHHJ4BFAB6eGBUEaSWAt3A4lKKIY
         5/0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=dtwELxtt;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=dtwELxtt;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AIpwx4/Aa7eNSEpB6Tod1fOQ4CEBlzaIhrmujXMPcwe3cBDniTd47s85j9AaoR/OO1V/70ptwjwaK+07zNklGYr/9Bw=
MIME-Version: 1.0
In-Reply-To: <20736.1522829117@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com>
 <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com> <20736.1522829117@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 4 Apr 2018 07:35:20 -0700
Message-ID: <CALCETrUaKOG1q43W=UBPue5TAL61zzwzgr8QeH3Yh6KsMUA2aQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Garrett <mjg59@google.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, James Morris <jmorris@namei.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>,
	linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596826626613782887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've reordered your email to make my email more coherent.

> On Apr 4, 2018, at 1:05 AM, David Howells <dhowells@redhat.com> wrote:
>

>
> What we *have* said is that *if* we want to pass the secure boot state across
> kexec, then we have to make sure that:
>

What do you even mean "pass the secure boot state across kexec"?  All
I can come up with is that you want a kexeced Linux kernel to also be
passed a flag saying "I was secure booted" and to enable or disable
lockdown accordingly.  Let's consider the cases:

1. First kernel is verified (secure boot or otherwise) and locked
down.  Certainly that lock down needs to enforce that the next kernel
in the chain is locked down, otherwise lockdown gets defeated.

2. First kernel is not verified but is locked down.  It still needs to
enforce that the next kernel is verified and locked down, otherwise
lockdown gets defeated.

3. First kernel is verified but not locked down.  There's very little
point in trying to force the next kernel to be locked down.

4. First kernel is neither verified nor locked down.  There's still no
point in trying to force the next kernel to be locked down.

Isn't the right solution to have a flag saying "force lockdown" that
kexec can pass to the child kernel?  A locked down parent kernel would
refuse to load an unsigned child kernel and would always set that
flag.

> Andy Lutomirski <luto@kernel.org> wrote:
>
>> As far as I can tell, what's really going on here is that there's a
>> significant contingent here that wants to prevent Linux from
>> chainloading something that isn't Linux.
>
> You have completely the wrong end of the stick.  No one has said that or even
> implied that.  You are alleging dishonesty on our part.

I'm alleging that the idea that Linux seems some particular policy to
avoid being blacklisted keeps being brought up as a justification for
these patches.  And, in fact, you bring it up again right here:

>
> And if someone tampers with the aim of breaking, say, Windows, then someone,
> e.g.  Microsoft, might blacklist the shim.

In other words, if you chainload an intentionally corrupted copy of
Windows, you get blacklisted?  This sounds awfully like what I said
upthread.  Is this actually a real concern?  Greg seems quite
convinced that it isn't.
