Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520110823; cv=none;
        d=google.com; s=arc-20160816;
        b=BDRFlVoQwhWoZRE1fyyXUz4kqPNiM3tMiVv4kFabFY9bhe28dRu8oCXtKdDOLklOHl
         tfocPirUPqX8861pIbBn/KPLmalzAXt2SOsHdPb8iHOSb3pY/K9RZUJWzW91hXF+4y6C
         tWkND4muO68Mak3qmYQCftu+ZmbAY85X2bFht/VG9nNrculkaeZRXYpgkVfmyZG3e3ek
         RpjDJ+4/6RQcZ4Fc24I8CxuBfWN3sOGoroLdtaLX/WcPCSbFGyIX3RCKwlc4rkwnZ0xl
         ifA0Q9wUg9H+AYaFq7WSwXlQfRZiUCzG/HIVuXFyR68wUb+JbnEyKLqTzx8dFtZ8RsZl
         VdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=zwZr99adjlLjoacrREeKBpcmhCNxYIYZ0QM15JoC0kY=;
        b=qd/v8WE/rH7kGNfy2oxicSJX1T9lwTwJBMX3gq0i2UvKyz0k/EjvymsMliOTXWsVBQ
         2pS3BaP48MIIK4/cjKKx8qBQLgYLOMqGeLqAE8Uu0eKVlTi7zBKpI79DW4xHOWPrCJhN
         tpyfh8qIEOqPec7NbyeDFFNG3sCPVX7628YWYbtDw52RZz6tVW5YA3KXa8nDK7+a84Yh
         QdJq8obZuCyNwh2fGHAKK7qYuU0nHkABHRhKvsX2HSXQqxn/9ln8s33lMNY2Y1yYxM9o
         qO5uuPPDUo3X1vmv3VPU52i+anMl5N8lyDm76Gayk4mSZ8+FNtTnxDzgHRE9COlwwevf
         RN3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=le9bg1bd;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=le9bg1bd;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvfYZn4ugruZFl/QmPbTELiulByGHHfKyrCroItNAHuE6bi414UD9/FVd2zXTapyATC3ItqHg==
Date: Sat, 3 Mar 2018 21:00:19 +0000
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] parport: ax88796: Delete an error message for a
 failed memory allocation in parport_ax88796_probe()
Message-ID: <20180303210019.GA16495@sudip-laptop>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com>
 <20180301120609.GA31656@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301120609.GA31656@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772848657448336?=
X-GMAIL-MSGID: =?utf-8?q?1593951726771812219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Thu, Mar 01, 2018 at 01:06:09PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 01, 2018 at 12:46:07PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 7, 2018 at 9:47 PM, Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > >
> > > Omit an extra message for a memory allocation failure in this function.
> > >
> > > This issue was detected by using the Coccinelle software.
> > >
> > 
> > Greg, just to be sure this series is under your scope.
> > IIRC it had been sent during merge window, though it looks like your
> > tty tree doesn't include it yet, while even older patches, which were
> > sent as well during merge window, made it
> 
> It's in my large "to-review" queue...
> 
> Personally, stuff like this, from this specific developer, ends up at
> the bottom of that list as well...

do you want me to reorganize the series and resend?
I can send patches 1 - 3 later.

--
Regards
Sudip
