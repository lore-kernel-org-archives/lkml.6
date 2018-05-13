Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeEMK1o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 06:27:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46821 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 06:27:43 -0400
Date: Sun, 13 May 2018 12:27:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] selftests/x86: Add mov_to_ss
Message-ID: <20180513102740.GA22097@xo-6d-61-c0.localdomain>
References: <67e08b69817171da8026e0eb3af0214b06b4d74f.1525800455.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e08b69817171da8026e0eb3af0214b06b4d74f.1525800455.git.luto@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +#ifdef __x86_64__
> +				, "r8", "r9", "r10", "r11"
> +#endif
> +			);
> +	}
> +
> +	printf("[OK]\tI aten't dead\n");
> +	return 0;

aren't? am not?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
