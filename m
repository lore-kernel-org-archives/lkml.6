Return-Path: <mchehab@s-opensource.com>
X-Google-Smtp-Source: AIpwx49eAezApoXpM+f1lbIEISgUO073csFaqoEbg8OOKDXocBxreyRQyhshsChJ7zhi2dkhEbkL
ARC-Seal: i=1; a=rsa-sha256; t=1524478886; cv=none;
        d=google.com; s=arc-20160816;
        b=oIjWGC87vOfn5zUdKcNRXpnB8PAN/Sk6tIIJyuZZryKv3QNPQMqzKdTXTYPmClVav+
         Vxtpodq46DVWbH121g+CnHf72wEvADiUh+xdj0AtBwaJMX3AZMa644rw69ds3G/vmPWH
         Zi9a5GY+qACHimfMXfe5J2xrpteySKL2gKsNup7ADMy8iJg+A8E1ms7gfM4kVwD0xfYq
         upinfHJznZKjQFeMEwk+7+b8WUbjbLEim2qrhngHlll7xltpfc9UvbgqGMIuQlVeEmJi
         GwOAVh/OX7q18RlnrnouALuhi3sPKvekQGf2G4ToWyAQB/0IPf9Wi/FlEX3DuojIujDt
         dffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=AxyF+CEFxXzug7rmyJVcknsvJycEf69YPBaFz+qfz8k=;
        b=RAdT6sieBKAbtmrmlAWjzt8R78nqwYR41LeqM5LdqwyOKS5L/Jgcdl6HrdJjOU1hDJ
         u0NwlVdcclBYVQ0V13EyGpFj71mvkahzFEd4rdwV72oqn0z2yW+o8ewoYjRGawFP6R/x
         AhaNdnjP0niH4Qkldqt/x8/OyVUA5H4nZgxj82rNr2Ircj9M8dEaGmpMr38RawbiEFNd
         FtlBTEMz7qGXgVmoHekopaTbSToPv/+sSgdlm5R1FfkmwgP0NdBPY/o6F2BaDHpC1rnW
         rxi/qRZ8AOC6qeHbhoBqOuMJe4704nxRatB/KzSirrxRrPw26VrqT877qK1nS31bykoi
         bZUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Date: Mon, 23 Apr 2018 07:21:14 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <mawilcox@microsoft.com>, LKML
 <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [patch 8/9] LICENSES: Add CC-BY-SA-4.0 license text
Message-ID: <20180423072114.6d1bd99b@vento.lan>
In-Reply-To: <20180423082635.GB20868@kroah.com>
References: <20180422220208.772527041@linutronix.de>
	<20180422220833.423253901@linutronix.de>
	<20180423065449.GE4208@kroah.com>
	<alpine.DEB.2.21.1804230936290.6136@nanos.tec.linutronix.de>
	<20180423082635.GB20868@kroah.com>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486100220980492?=
X-GMAIL-MSGID: =?utf-8?q?1598531972336085422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Mon, 23 Apr 2018 10:26:35 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Apr 23, 2018 at 09:37:14AM +0200, Thomas Gleixner wrote:
> > On Mon, 23 Apr 2018, Greg Kroah-Hartman wrote:  
> > > On Mon, Apr 23, 2018 at 12:02:16AM +0200, Thomas Gleixner wrote:  
> > > > Add the full text of the CC-BY-SA-4.0 license to the kernel tree.  It was
> > > > copied directly from:
> > > >     
> > > >    https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
> > > > 
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>  
> > > 
> > > As we only have 1 user of this, do we really need it?
> > > 
> > > Willy, it's your file, Documentation/core-api/idr.rst that is needing
> > > this addition to the LICENSES directory.  While I'm all for CC licenses
> > > for Documentation, we don't seem to be very consistent with them.
> > > Should this be the "default" license we choose for documentation for now
> > > on?  
> > 
> > I'm all for it. If we can agree than this should move to preferred/ and not
> > to other/  
> 
> Ok, that sounds good, Jon?  I know you have looked into picking a decent
> license for documentation, any thoughts here?

My 2 cents here: I'm a big fan of using C-BY-SA-4.0 for documentation.
IMO, it fits better than GPL for docs. For a pure .rst file that doesn't
use kernel-doc, that is the best choice on my PoV.

Yet, I'm not sure if we can import something from a GPL (using kernel-docs)
on a CC rst file. Perhaps it needs some exemption to explicitly allow that.

Thanks,
Mauro
