Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756035AbeDDAGR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:06:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36639 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753927AbeDDAGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:06:15 -0400
X-Google-Smtp-Source: AIpwx49QPoO1QGiOwwvWaHYXUz4yAsk+OoKDr80JG7niea+NBhZ9G50Mdj4Tb+g1hzHTGOk1iyrgWAxOPabEH7o5wVo=
MIME-Version: 1.0
In-Reply-To: <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
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
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com> <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:06:13 -0700
X-Google-Sender-Auth: 0iIvTw5Ee6TK_KmEDeXbN0UpXj8
Message-ID: <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 4:59 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> Ok. So we can build distribution kernels that *always* have this on, and to
> turn it off you have to disable Secure Boot and install a different kernel.

Bingo.

Exactly like EVERY OTHER KERNEL CONFIG OPTION.

Just like all the ones that I've mentioned several times.

Or, like a lot of other kernel options, maybe have a way to just
disable it on the kernel command line, and let the user know about it.

That would still be better than disabling secure boot entirely in your
world view, so it's (a) more convenient and (b) better.

Again, in no case does it make sense to tie it into "how did we boot".
Because that's just inconvenient for everybody.

                Linus
