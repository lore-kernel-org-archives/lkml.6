Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AIpwx4/Hzs99QJ7kzdfaDKOSMryV2WEP9YEH2Db3lOUzRiszCEhZHvMry29eezCMZjewSAgBsipe
ARC-Seal: i=1; a=rsa-sha256; t=1524486575; cv=none;
        d=google.com; s=arc-20160816;
        b=T8b7IVi5BeAqLqcZCRC8p4oXsiYa8NgaOJa/I7tb1nDZrQScq5BbczOTeFTk9b+WaV
         fREwnJMzjLagQFSjuQU+sNSbz8+cOBA7em1sPG5VI34D3M0J4raWIIXy0Y7zEQ+hi/qe
         qtABNDVhSS2oYQFfbacn+9tWAuf2ya1Thdh1d9naXpoXisoyiXsCNnXU11ziyvKffmWv
         02hvXxeo8FcECrwep01BTyQt3k5Wt1Iev447lzWvil4tj5OyzQxMdUCVKppgr+ApRQSH
         ELuLm5yrC8QY3JXM4U4obtjqxrz9WAUS6JWSjUc/o/XkaVnYjkDE1oaa1mqwjrSm2+EC
         JRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=IZoOnKywELRb1PSCeVORJolTjsCD2RReo/ftyd+/b1M=;
        b=lWjTrXUsKhAEItp7FdfB/WBL0xjYuphhvBfBkxcX33+fkYoqiFKjX7BY4r2UR6TNSN
         tQRti0Qf0wUZuATX9hDJHwoViV4SBl3HXAvUEKuJ7Nc9KMg7Hou4udJhduixzXMLa6pW
         DPPSWNDlLN0tRhyLJfKJ+nJbtkU3J5CCbVpvgJ+8Q5Km08NNx4d2A7ZU/YU1TjVenHN1
         Vw2jrs/lBmrf4X+G0YX1jjSCLI58X4T529l/lFNfT4g5bJZenlAKY8jLKq5+zv+G1aWn
         0zPvN5Qvujcg3XkCztbrt2WNliT7ET9PPSazNSZ31Kmtvxg47BAO1i4bXB79AW4/POnJ
         Yg8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Mon, 23 Apr 2018 06:29:32 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox
 <mawilcox@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, Philippe
 Ombredanne <pombredanne@nexb.com>, Kate Stewart
 <kstewart@linuxfoundation.org>
Subject: Re: [patch 8/9] LICENSES: Add CC-BY-SA-4.0 license text
Message-ID: <20180423062932.0cd167cb@lwn.net>
In-Reply-To: <20180423082635.GB20868@kroah.com>
References: <20180422220208.772527041@linutronix.de>
	<20180422220833.423253901@linutronix.de>
	<20180423065449.GE4208@kroah.com>
	<alpine.DEB.2.21.1804230936290.6136@nanos.tec.linutronix.de>
	<20180423082635.GB20868@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486100220980492?=
X-GMAIL-MSGID: =?utf-8?q?1598540035191689785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 10:26:35 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

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

CC-BY-SA is a good license for docs, but it's not GPL-compatible, so I
don't think that anything with that license can incorporate kerneldoc
comments or, conceivably, be integrated into the whole sphinx document
tree (which does use those comments).  That leads to my own believe that
the docs really need to be GPL-licensed, even though it's not the ideal
solution.

I suppose it might be worth putting this question to the LF lawyers to
see what they think.  It's not as if I really know what I'm talking
about, after all...

jon
