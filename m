Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032013AbeBNXQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:16:38 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44750 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031971AbeBNXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:16:37 -0500
X-Google-Smtp-Source: AH8x227PTB+OKN0n92DkmoIqcRDX7tj78xgVgdkni+OzFtqkiAgkNyRFP7bu2LF2ELOXzWEJ247f0Q==
Date: Wed, 14 Feb 2018 16:16:33 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <srostedt@redhat.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: collecting simple benchmark scripts?
Message-ID: <20180214231633.oxh76uqocisenf4q@smitten>
References: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 02:50:37PM -0800, Kees Cook wrote:
> I'm sure I'm not remotely the first person to bring this up, but my
> attempts at searches for this have failed.
> 
> Thoughts?

There is mmtests: https://github.com/gormanm/mmtests which looks like
it has kernel build and a bunch of other stuff. Are you thinking of
bringing stuff like that in tree?

Cheers,

Tycho
