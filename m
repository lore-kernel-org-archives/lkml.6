Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeBVBFP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:05:15 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:46394 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeBVBFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:05:14 -0500
X-Google-Smtp-Source: AH8x226qv0/WwFfYv60AAias0BWuM9DcOISWbDhjMUiv17Wqw7mQpjuFSzvIH0hWGPThHjglF4WfmjaldAE59a8SCGw=
MIME-Version: 1.0
In-Reply-To: <20180221024747.9659-1-tycho@tycho.ws>
References: <20180221024747.9659-1-tycho@tycho.ws>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 17:05:10 -0800
X-Google-Sender-Auth: YHI3eU4HxE88lg1jRiZRLA0-So8
Message-ID: <CAGXu5jLToG-sJS5LJtGxrMZ6BrurCWkwzKWb3q03bkDXSV=jRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] some fixups for PTRACE_SECCOMP_GET_METADATA
To: Tycho Andersen <tycho@tycho.ws>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 6:47 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> Hi Kees,
>
> Here are a couple of tweaks/fixes people suggested to the get_metadata
> functionality, plus a test to ensure that things work the way they're supposed
> to and stay that way.
>
> Cheers,
>
> Tycho
>
> Tycho Andersen (3):
>   seccomp, ptrace: switch get_metadata types to arch independent
>   ptrace, seccomp: tweak get_metadata behavior slightly
>   seccomp: add a selftest for get_metadata

Thanks! I've applied these and asked James to get them pull for 4.16.

-Kees

-- 
Kees Cook
Pixel Security
