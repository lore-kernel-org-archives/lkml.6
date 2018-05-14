Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeENJ2w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:28:52 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40805 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeENJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:28:50 -0400
X-Google-Smtp-Source: AB8JxZoO7I3hpd3LL5XzO9GGFH0S82Hmh8JYQy79ceZPbIr9RRM0gmzR0lzVzpSP4GBDgcNpmtQPJA==
Date: Mon, 14 May 2018 11:28:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] selftests/x86: Add mov_to_ss
Message-ID: <20180514092846.GA25365@gmail.com>
References: <67e08b69817171da8026e0eb3af0214b06b4d74f.1525800455.git.luto@kernel.org>
 <20180513102740.GA22097@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513102740.GA22097@xo-6d-61-c0.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > +#ifdef __x86_64__
> > +				, "r8", "r9", "r10", "r11"
> > +#endif
> > +			);
> > +	}
> > +
> > +	printf("[OK]\tI aten't dead\n");
> > +	return 0;
> 
> aren't? am not?

It's a joke, Google it ...

Thanks,

	Ingo
