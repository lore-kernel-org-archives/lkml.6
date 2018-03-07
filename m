Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbeCGXkJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:40:09 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36570 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755010AbeCGXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:40:08 -0500
X-Google-Smtp-Source: AG47ELu8njS3UCtEbxOYHEVma3NnjfNKtpkm8Mt8AxOtbG++s9U+E09uRLM9jkwLDIntEiqfnVCrrxqrvnjP4k4JsKs=
MIME-Version: 1.0
In-Reply-To: <20180214174718.4445-1-mcroce@redhat.com>
References: <20180214174718.4445-1-mcroce@redhat.com>
From: Matteo Croce <mcroce@redhat.com>
Date: Thu, 8 Mar 2018 00:39:26 +0100
Message-ID: <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
Subject: Re: [PATCH] bloat-o-meter: fix typo in help
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
        Maninder Singh <maninder1.s@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 6:47 PM, Matteo Croce <mcroce@redhat.com> wrote:
> the bloat-o-meter script has two typos in the help, fix both.
>
> Fixes: 192efb7a1f9b ("bloat-o-meter: provide 3 different arguments for data, function and All")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  scripts/bloat-o-meter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
> index 94b664817ad9..d84a5674e95e 100755
> --- a/scripts/bloat-o-meter
> +++ b/scripts/bloat-o-meter
> @@ -15,7 +15,7 @@ signal(SIGPIPE, SIG_DFL)
>  if len(sys.argv) < 3:
>      sys.stderr.write("usage: %s [option] file1 file2\n" % sys.argv[0])
>      sys.stderr.write("The options are:\n")
> -    sys.stderr.write("-c       cateogrize output based on symbole type\n")
> +    sys.stderr.write("-c       categorize output based on symbol type\n")
>      sys.stderr.write("-d       Show delta of Data Section\n")
>      sys.stderr.write("-t       Show delta of text Section\n")
>      sys.exit(-1)
> --
> 2.14.3
>

Ping, anyone willing to review and eventually merge it?

Regards,
-- 
Matteo Croce
per aspera ad upstream
