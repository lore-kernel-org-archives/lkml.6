Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDDJEq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:04:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDDJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:04:42 -0400
Date: Wed, 4 Apr 2018 11:04:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Garrett <mjg59@google.com>
Cc: luto@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180404090440.GA24169@kroah.com>
References: <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CALCETrVF2vSvoz0sBCrfMKcbJ4hmi=1QJZbUxdvurkimVXr0nA@mail.gmail.com>
 <CACdnJutmTU4U0nMik0oqGHDEd-xd4Vhi06t3RsZ5tpUgugfNbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutmTU4U0nMik0oqGHDEd-xd4Vhi06t3RsZ5tpUgugfNbQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:19:35AM +0000, Matthew Garrett wrote:
> On Tue, Apr 3, 2018 at 5:18 PM Andy Lutomirski <luto@kernel.org> wrote:
> 
> > if your secure boot-enabled bootloader can't prevent a bad guy from
> > using malicious kernel command line parameters, then fix it.
> 
> How is a bootloader supposed to know what the set of malicious kernel
> command line parameters is?

It wouldn't, it, if it really were "secure", would not allow any command
line parameters to be changed.  Which is exactly what those bootloaders
who "claim" to be secure do.

And, just to butt in here, there is no requirement that I have ever
heard of from anyone at UEFI or Microsoft that this type of "kernel
feature" is a requirement to allow for a bootloader/kernel to be signed
with their key.  So that should take the "politics" reason off the table
here, if people thought that somehow it was even a viable reason...

thanks,

greg k-h
