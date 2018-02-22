Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBVVy2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:54:28 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:50321 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeBVVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:54:26 -0500
X-Google-Smtp-Source: AH8x226JCttXwPpSemRDMo0yOM1EK2VYG+pHaLV1oNP2WxeCdtweKDvZC5qWI+b0IptJYXpYd22VRyZwuBC7xFj7+nQ=
MIME-Version: 1.0
In-Reply-To: <CA+55aFywUNouK-Y1qbnkwxM3G_WLdDVFdC0po-Xj01G4UsfSAw@mail.gmail.com>
References: <20180222174140.GA3154@beast> <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk> <CA+55aFywUNouK-Y1qbnkwxM3G_WLdDVFdC0po-Xj01G4UsfSAw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 13:54:25 -0800
X-Google-Sender-Auth: daCeVIh5uHRJhUebjrOfEWOtLzQ
Message-ID: <CA+55aFyHhbw0VDeUOaxj1UWr7AH=8n_jg8_cXH29+avKg0rcpQ@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
        Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hah. So it was the lack of kconfig.h dependency that bit my testing ;)

Confirmed. Rasmus was right, doing a full build after cleaning
everything up did fix this. So it's really just <linux/kconfig.h>
itself that is missing from dependencies.

              Linus
