Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZr/950i1A5ramRDwahtObw/fZQ2Mx7FS80ONROvJiJDHVpCOzcP5aw/JA1QBeDoFIGZ9/Uv
ARC-Seal: i=1; a=rsa-sha256; t=1526509594; cv=none;
        d=google.com; s=arc-20160816;
        b=wfP8VsyFAmfRx1l8z9xpxMF4YOPDOIVRSboxUd5FwfbMgsOMNwyJBVUl7RaKKV1Cek
         XwDNzze6juY+ccIUdDF1aoY7GMMP7S9HZZOxh9bjyOP5tcepU35wlHYMAgZoDfbLcP+9
         Q8cb3KZGs73hoygwy4zHJ6vy20YmOKMVP21A5Wd55sIA1FWlEtJwMcI/Zk7RNsm2Uhlh
         h49k4kKLNvV1f5T44kiFGpcZdBHL85nYuOVFQ/wB3zGHTEwYac1e/JcLgHlP/vGZ1Rkg
         36FeF5QWmrg2RD2a4t2on5caqdLAjdhHZlL233uSpsmajhrLmDXJoxP1lvsoYjDRflnP
         OiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=nJjfDGvIlRDQvKKXY1heHw+ut3AogUeoW3KANsNOxvA=;
        b=nmTPTGZelkW0Eqod+gylwmLPx7WguHK/Nj6e9K/9Lc0Ol1f1g98mRqVWpclHZPXQ+6
         +aqNUUQ6Rlpr+i6+BiamuiJwRdZFulCX4+ZQbINGA3nReEd+SHn3wkLjnVE7ny6jQ8vs
         SGElbKcPsE/Mkp/mUHJdmA9wEzTNBFPgOp4rLryb+VOL81rxPJdxc9OibfUhYlkuSBSs
         2aY85W8e4KZwdEs3+0F1vMqko4sEPt3/9SAalPubt+YrZeKsm2cgHLzbmZcynBuWd6eb
         E3sj/6BPzZ/EteErlXK5RE0khPsT0U52NhzhvKNlcnVkZFAsCwtdreMJyJG6TEWKl0+M
         9iMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=aBjpKwFI;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Ft9LEf1L;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=aBjpKwFI;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Ft9LEf1L;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Proxy: <xmx:GLD8WmkzVxkb2G8xkfjuCcgSPXyZkS-NUvqb3OUFvta31V7ARVQZrw>
X-ME-Proxy: <xmx:GLD8Wv3OIIV_sI81eAeqdydmw8xTpy_r3DLYPMo_0pHKkXNRoxiz_Q>
X-ME-Proxy: <xmx:GLD8Wo5ajgK9a84Mp37STfN8C8BhSYe4Jh8_0qjsXerPSNk37vh-sQ>
X-ME-Proxy: <xmx:GLD8WljoYSw1Lz449B9_Vhy9C0yfd67rM1p3D709ZYq18Bx0ieuvhg>
X-ME-Proxy: <xmx:GLD8WpmUNv00Ao7BrotlsJeAPw1KeNbgCloxI-eOSLY-Ia0csyzOYQ>
X-ME-Proxy: <xmx:GLD8Wp0b548sYEF4nzvmeUzpJF8gM0oxp_fOnIwHkMPRLldbDin0kQ>
X-ME-Sender: <xms:GLD8WpMs_YaePOPwiU2iJhlnmNhmU1UdW2vxdSk_Rjov4Cbs37qy4Q>
Date: Thu, 17 May 2018 08:26:28 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Add command line option debug_boot_weak_hash
Message-ID: <20180516222628.GC25268@eros>
References: <1526359115-5489-1-git-send-email-me@tobin.cc>
 <f9bacaa1-7741-d28e-29d1-4b42ae0c986f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bacaa1-7741-d28e-29d1-4b42ae0c986f@infradead.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600503563774077130?=
X-GMAIL-MSGID: =?utf-8?q?1600661323670031251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 08:29:47AM -0700, Randy Dunlap wrote:
> On 05/14/2018 09:38 PM, Tobin C. Harding wrote:
> 
> >  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
> >  lib/vsprintf.c                                  | 18 ++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3b8032431585..c95dd6704592 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -748,6 +748,14 @@
> >  
> >  	debug		[KNL] Enable kernel debugging (events log level).
> >  
> > +	debug_boot_weak_hash
> > +			[KNL] Enable debugging early in the boot sequence.  If
> 
> That makes it sound like "debug_boot_weak_hash" turns on early debugging.

Thanks Randy, I'll have another go at writing this.


	Tobin
