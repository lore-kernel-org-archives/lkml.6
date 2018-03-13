Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeCMVBH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:01:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbeCMVAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:00:46 -0400
Date: Tue, 13 Mar 2018 14:00:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rdunlap@infradead.org, apw@canonical.com, joe@perches.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clang-format: add configuration file
Message-Id: <20180313140037.7717460162192c99775b135e@linux-foundation.org>
In-Reply-To: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 00:39:52 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> --- a/Documentation/process/4.Coding.rst
> +++ b/Documentation/process/4.Coding.rst
> @@ -58,6 +58,12 @@ can never be transgressed.  If there is a good reason to go against the
>  style (a line which becomes far less readable if split to fit within the
>  80-column limit, for example), just do it.
>  
> +Note that you can use the clang-format tool to help you with these rules
> +and to quickly re-format parts of your code automatically. It is specially
> +useful for new files/code and to spot coding style mistakes. It is also
> +useful to sort #includes, to align variables or comments, to reflow text
> +and other similar tasks.

It would be rather helpful to tell people how to invoke clang-format. 
Is it just "clang-format foo.c" or what?
