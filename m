Return-Path: <mchehab@s-opensource.com>
X-Google-Smtp-Source: AG47ELvw1ih4b09wMdY7gIapZSC6+YJ8k75HZ8JmTCXzIHHurXjmVPYL4TzOf7za12sQGlyM2k5Y
ARC-Seal: i=1; a=rsa-sha256; t=1521798284; cv=none;
        d=google.com; s=arc-20160816;
        b=dV8hYUl6+qylsUGpScOe5NXP0g9UUd/1faVM7F73GQLi6AiYYrELk9aeDDyNysSzZc
         9er+BoHd+6Q7kMHXSgee4HAden+cptCkw3kfZyeNBsBaUlo+8DC9HrkaxaTfCtyUk/Xo
         jh79b/wS/mcWMp1pdHc6HvOBq1/981gCrsQL9hPlZmqfbyD12xJ+oxCqshOXTvGbiyLg
         bfiOcVP1kAZoclIq+k/MvRQrvbQ2qhIGAsXrTMizrUHNrS50X/+6l87LI1TztjL530Id
         JEzuA4GPHzXmWOI8WBOa41ZVfyLfQ2Qe62tOwHcjQ1zycx5NWT95DrIhSkkOe6fxABD+
         xoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=QCgh2nV1yHTSb6kxaWtV43AyNdNCGOx9BvtUScTUACg=;
        b=oz4ZICnaU4w6yHSkk6rNItzPtH/+Llvmixo6i2OCQA6HCCNX1ff5icPzxdH23eqxDm
         D016tuyMljNyqPTJyI7kIC9Nbpm0F/RHrGRCv7KeOG9Kl5iwSdudYCwllj5ck3c7aLiH
         Pr7afEW1w0YiaGGhSMcl1RPsaHY8Hqv3F73MKy+GYDM9kCGHKfvszhBuAdypj7zBugQy
         +D6xAG1QWsgWtEe3rCityfRi16Cq/Qb2emTXPjKGhWSs4vYvbOwaJ0tsnt+l9rUHjeff
         KCL2BpTRH3plM1YcJ+U3fV1O0Lag69wsiN7gicgermJQoTZ27dEK/pZrHMb02coR8NlH
         HwZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Date: Fri, 23 Mar 2018 06:44:35 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 Linux-doc <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab
 <mchehab@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 1/2] COPYING: create a new file with points to the
 Kernel license files
Message-ID: <20180323064435.39df8bdc@vento.lan>
In-Reply-To: <20180322121355.GA16195@bombadil.infradead.org>
References: <20180322095414.24019-1-mchehab@s-opensource.com>
	<20180322095414.24019-2-mchehab@s-opensource.com>
	<20180322121355.GA16195@bombadil.infradead.org>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595631169729056837?=
X-GMAIL-MSGID: =?utf-8?q?1595721158256627129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Thu, 22 Mar 2018 05:13:55 -0700
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Mar 22, 2018 at 06:54:13AM -0300, Mauro Carvalho Chehab wrote:
> > +++ b/Documentation/process/license-rules.rst
> > @@ -4,15 +4,17 @@ Linux kernel licensing rules
> >  ============================
> >  
> >  The Linux Kernel is provided under the terms of the GNU General Public
> > -License version 2 only (GPL-2.0), as published by the Free Software
> > -Foundation, and provided in the COPYING file.  This documentation file is
> > -not meant to replace the COPYING file, but provides a description of how
> > -each source file should be annotated to make the licensing it is governed
> > -under clear and unambiguous.
> > -
> > -The license in the COPYING file applies to the kernel source as a whole,
> > -though individual source files can have a different license which is
> > -required to be compatible with the GPL-2.0::
> > +version 2 only (GPL-2.0), as written at LICENSES/preferred/GPL-2.0,  
> 
> ^^^ you dropped the word 'License' here
> 
> Also, I think this should read "as provided in", not "as written at".
> 
> > +with an explicit syscall exception described at  
> 
> s/at/in/
> 
> > +LICENSES/exceptions/Linux-syscall-note, as described in the COPYING file.  
> 
> This phrasing is awkward with "desribed" used twice in the same sentence ...
> 
> > +This documentation file is not meant to replace the Kernel's license,
> > +but provides a description of how each source file should be annotated
> > +to make the licensing it is governed under clear and unambiguous.  
> 
> I'd rather this said:
> 
> This documentation file provides a description of how each source file
> should be annotated to make its license clear and unambiguous.

Thanks for your review!

I'll be submitting it again as a v2, with the following text at the
license-rules.rst preamble:


Linux kernel licensing rules
============================

The Linux Kernel is provided under the terms of the GNU General Public
License version 2 only (GPL-2.0), as provided in LICENSES/preferred/GPL-2.0,
with an explicit syscall exception described in
LICENSES/exceptions/Linux-syscall-note, as described in the COPYING file.

This documentation file provides a description of how each source file
should be annotated to make its license clear and unambiguous.
It doesn't replace the Kernel's license.

The license described in the COPYING file applies to the kernel source
as a whole, though individual source files can have a different license
which is required to be compatible with the GPL-2.0::



Regards,
Mauro


> 



Thanks,
Mauro
