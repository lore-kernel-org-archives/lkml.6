Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeERGzx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:55:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35897 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:55:51 -0400
X-Google-Smtp-Source: AB8JxZpigbfR2HrGxiNvQAWXA1KEKZuwunjOUQStq/u4KP52EjSgyFzk7mgBsDZ3H9mizkgCEf66zQ==
Date: Fri, 18 May 2018 08:55:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jslaby@suse.cz>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/6] x86/stacktrace: do not unwind after user regs
Message-ID: <20180518065547.GA18262@gmail.com>
References: <20180518064713.26440-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518064713.26440-1-jslaby@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Slaby <jslaby@suse.cz> wrote:

> Josh pointed out, that there is no way a frame can be after user regs.
> So remove the last unwind and the check.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Josh: an Acked-by or Reviewed-by for the whole series from you would be nice.

Thanks,

	Ingo
