Return-Path: <tobin@apporbit.com>
X-Google-Smtp-Source: AG47ELvrz/0hy4wxZRE1licfXl8pip8zrOufDSnCjMR3HQKeeaZBe6RukNVJTO0yVZcODB6kJ1w2
ARC-Seal: i=1; a=rsa-sha256; t=1520285085; cv=none;
        d=google.com; s=arc-20160816;
        b=XM0Xy//4y0ccAaoy1qReQLn7o5ztShBdbl5l40Ft7jW7nOXKZWeAx5Es8lDKtcGOYh
         amy0q9fDqQjNUnG5YjI2AD66ZQM5VAO3/ITgwU0JTeJw6sNpXosjtk5MH5CEGpYn/8Pl
         2C6ST24IUVvNjKIfBJf5KPXhX1gqNhWSga6xms3x/YYeetFNxnAHfwRSREp17YwNhGRF
         G/eEEt/z+m6b0GQtj/58PhfpYefobBp6V14vK37qGvZOLyx4+t0bGl2kmhFFAFZQP8aC
         PdebeaJlKpdQQXZcoldBPdTYdNwCQL8snOx+qkgCF+k0KCorN/TSDmrOPMnQ1xpZJjNt
         VWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=WetMjRLC503epAZS2/XwuBRA18EmGhABISNGKLVRVkM=;
        b=ea93JkMSMfLzgOq/26HKlHlmZBv9zewEzXhasIxHL1GqmS27hJPJu+0OxPmUG+hZyJ
         toQyPUn/te0vQ97iy5QtYlv749SFvETQyTb+UogUawtHLihvxBhZybqsi400FSb6aFES
         i2jYkByABuIhwXdyBXs+lmEeDqlScDru7Nto5LeOy/4068yNloCFb/ISonSvNH/KAa/B
         lX6HOJ618Vhq9CnP4gv52zoDPmQ8pQlnCNxNBnirTo03LKDIe8hlU40Jvqb1Fh21sIwv
         TZP8V49tmXnQ2qTzfh7C1/JO+KnE4exgdf2DO2jW7T/A1RV2xmNy1DCqljqiC5BQ26aQ
         Je4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Oes2PQoY;
       spf=softfail (google.com: domain of transitioning tobin@apporbit.com does not designate 66.111.4.29 as permitted sender) smtp.mailfrom=tobin@apporbit.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Oes2PQoY;
       spf=softfail (google.com: domain of transitioning tobin@apporbit.com does not designate 66.111.4.29 as permitted sender) smtp.mailfrom=tobin@apporbit.com
X-ME-Sender: <xms:nLWdWtKVtJxJxCyiTCbWhpG7k7D-c9WxVTaMvN-PTClWKzWwx4R6rA>
Date: Tue, 6 Mar 2018 08:24:40 +1100
From: "Tobin C. Harding" <tobin@apporbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Randy Dunlap <rdunlap@infradead.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: add Co-Developed-by docs
Message-ID: <20180305212440.GB21350@eros>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
 <1520222301-11874-3-git-send-email-me@tobin.cc>
 <20180305121135.GA15079@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305121135.GA15079@bombadil.infradead.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068642266552204?=
X-GMAIL-MSGID: =?utf-8?q?1594134453716427144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 04:11:35AM -0800, Matthew Wilcox wrote:
> On Mon, Mar 05, 2018 at 02:58:21PM +1100, Tobin C. Harding wrote:
> > -12) When to use Acked-by: and Cc:
> > ----------------------------------
> > +12) When to use Acked-by: and Cc:, and Co-Developed-by:
> > +-------------------------------------------------------
> 
> +12) When to use Acked-by:, Cc:, and Co-Developed-by:

thanks, sloppy work by me :)


	Tobin
