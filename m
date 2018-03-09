Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCITNx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:13:53 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:37312 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeCITNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:13:51 -0500
X-Google-Smtp-Source: AG47ELsujQSq8joYk6LXxT+7gdkjehCE2gwUjj65/Qypht+6TDBXGfWuoBqng32gjf7+qMlbGB1gfuEORJWjQNiTw0E=
MIME-Version: 1.0
In-Reply-To: <20180309190736.GA4657@beast>
References: <20180309190736.GA4657@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 11:13:50 -0800
X-Google-Sender-Auth: KbLSJp-hoZzFSuVyPEugdQcjNug
Message-ID: <CA+55aFwsggrvj1Xbo8-uV-Vgj5Ekt5vDwhGtjEgk9EJNP1a3Tw@mail.gmail.com>
Subject: Re: [PATCH] exec: Set file unwritable before LSM check
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 11:07 AM, Kees Cook <keescook@chromium.org> wrote:
> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a ToCToU issue between the
> LSM verification and the actual contents of the file later.

Can we please not add random crazy six-letter acronyms that nobody
uses outside of a very small community?

The point of a commit message is to *explain*, not confuse.

            Linus
