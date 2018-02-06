Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeBFR2C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:28:02 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43786 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:27:56 -0500
X-Google-Smtp-Source: AH8x225UNi7WiIzqCxK2apLkJ67VR0jQIT+RHUSAmr4ywBHpehZIdBURH3Nf7G0kvnOU0ltfzEubBQ==
Date: Tue, 6 Feb 2018 20:27:53 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Kees Cook <keescook@google.com>, Willy Tarreau <w@1wt.eu>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Always print RLIMIT_DATA warning
Message-ID: <20180206172753.GD2002@uranus.lan>
References: <1517935505-9321-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517935505-9321-1-git-send-email-dwmw@amazon.co.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 04:45:05PM +0000, David Woodhouse wrote:
> The documentation for ignore_rlimit_data says that it will print a warning
> at first misuse. Yet it doesn't seem to do that. Fix the code to print
> the warning even when we allow the process to continue.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> We should probably also do what Linus suggested in 
> https://lkml.org/lkml/2016/9/16/585
> 

Might be typo in docs I guess, Kostya?
