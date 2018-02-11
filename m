Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeBKKuj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:50:39 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33897 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeBKKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:50:38 -0500
X-Google-Smtp-Source: AH8x225fidDgQte/jYow+u74xUBrbgBATU7oxZl8VzBGe9UjFa3AJ94/F77sR3WP/giuIw7//nkq9w==
Date: Sun, 11 Feb 2018 11:50:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
Message-ID: <20180211105034.gjw2wkbqlvpfc6cm@gmail.com>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
 <20180210113629.jcv6su3r4suuno63@gmail.com>
 <20180210113842.7j62u7rxp4jscei2@gmail.com>
 <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But regardless, that least version looks perfectly fine to me even
> without that random tweak.

Thanks, I turned this into:

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

	Ingo
