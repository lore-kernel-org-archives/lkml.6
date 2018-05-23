Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZpzvJWZzb2Rz1lSKCCuStYN2n30IHCxM+IW7MtiuCgiHe7ZiPDdI15Afvy0AYC56Se7CBDC
ARC-Seal: i=1; a=rsa-sha256; t=1527111354; cv=none;
        d=google.com; s=arc-20160816;
        b=MWhyqwTCvYwDq6A14b7Ua7iWvqoxC9Hh+qgAJcUBV4tu65ixZjmw49qs888B4shcJH
         l/EaTmPEfZ8RD1pi8Wl+QxH1LVavjiqiZFnLepMenXMbcgPHVVk+ajCwGbIOb7mRkkoG
         X2TXdYv+89T96wZP1jM/venV5TPGNaFBo7dVoAfMruywn5xArJZVY3Kbiv6yVhp+Bxrz
         XfcNGn6pwJ7iiSHkmaDbjIvph2VSnThpEbl6vJCkK/rmOZXg3uO4bRAoY2J4TdCj2LDp
         nlyRNo1ZVMM31eJdl/sjc5XCeLWM4UykpwCq6bcGtNMZmoctx1jI6EvEVBPKUo7M5DUj
         jWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=u7KbhJgFqTun3B0laiVJ6YWyeHsljyEnt4IBPxxXSbc=;
        b=0tHCjQiPTS833vi0eZyY3r6vWVddbshpqs1dWvTxzNozwetMfI0uKd0A7GSvapa3Ro
         K9SN7PgfwFAf22UtV2LkMQQ4fYwfD8YQ98Y2aOVGt4bnZC3bLLgdLdgctETVr/V+tO9c
         Z5LZOpXQtsZr+SU+1Pb+IJPsBHYnxxlAolkiaXV4NuSQIeZDePixsM1tA8jmUrH5hBsT
         xze8PHsHMVOwvIjaw4vMcbnxSqHfNhsaLe5v3xJ3WQ42/TDAd4HjrH1a7s54fZjpE3ZX
         ya3h1kILlDKBiU7Ps9QNw2TYFC+dZhxiiE8UbbX2IZ6ycRYVq/Rm/7uPr83Py5tV0z1j
         FqYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 23 May 2018 23:35:51 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, willy@infradead.org,
	geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180523213551.GF4511@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
 <20180516164403.GI27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516164403.GI27853@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039618816101704?=
X-GMAIL-MSGID: =?utf-8?q?1601292315498417481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 06:44:03PM +0200, Luis R. Rodriguez wrote:
> On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> > This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> > definitions into asm-generic headers. Greg asked for a Changelog
> > for patch iteration changes, its below.
> > 
> > All these patches have been tested by 0-day.
> > 
> > Questions, and specially flames are greatly appreciated.
> 
> *Poke*

Greg, since this does touch the firmware loader as well, *poke*.

  Luis
