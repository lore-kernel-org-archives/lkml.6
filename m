Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBTH3H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:29:07 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35658 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBTH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:29:05 -0500
X-Google-Smtp-Source: AH8x226D3VFyU9g6ThwCAsHadoQJFJn3gtNWAEappzPAebtoXCZ1Kl1sIOJ8KUB+7cJOZQ/TjZgP088IM3/Z11SZLYg=
MIME-Version: 1.0
In-Reply-To: <1518845990-20733-6-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com> <1518845990-20733-6-git-send-email-changbin.du@intel.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:28:24 +0100
Message-ID: <CAOFm3uE78DosAoZDNfD_YRaGPhpxW=4_cd3d9MafV-mdk5BuxQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] trace doc: convert trace/ftrace.txt to rst format
To: changbin.du@intel.com, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin, Steven,

On Sat, Feb 17, 2018 at 6:39 AM,  <changbin.du@intel.com> wrote:
> From: Changbin Du <changbin.du@intel.com>
>
> This converts the plain text documentation to reStructuredText format and
> add it into Sphinx TOC tree. No essential content change.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  Documentation/trace/ftrace.rst | 3332 ++++++++++++++++++++++++++++++++++++++++
>  Documentation/trace/ftrace.txt | 3220 --------------------------------------
>  Documentation/trace/index.rst  |    1 +
>  3 files changed, 3333 insertions(+), 3220 deletions(-)
>  create mode 100644 Documentation/trace/ftrace.rst
>  delete mode 100644 Documentation/trace/ftrace.txt
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> new file mode 100644
> index 0000000..636aa9bf
> --- /dev/null
> +++ b/Documentation/trace/ftrace.rst
> @@ -0,0 +1,3332 @@
> +========================
> +ftrace - Function Tracer
> +========================
> +
> +Copyright 2008 Red Hat Inc.
> +
> +:Author:   Steven Rostedt <srostedt@redhat.com>
> +:License:  The GNU Free Documentation License, Version 1.2
> +          (dual licensed under the GPL v2)


Do you mind using an SPDX id per [1] rather that this?

Steven, are you OK with this? Can you ack?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
