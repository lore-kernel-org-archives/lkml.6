Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx48LfX40NrzQ50V5a2PRFodLrQ4o/SDOmjMfDfFh3Oa5jqSFcE4sitHHeTZEr7QF8kie2TBP
ARC-Seal: i=1; a=rsa-sha256; t=1521693953; cv=none;
        d=google.com; s=arc-20160816;
        b=LH5elEt6HpUt3ShxldbUgGqpeIz30ZIhwFbAcfvTyHOfiiwr6r+HDGLL2KHA8HvrV+
         4RPDH+BcqSnHQ1i/q9rm6i4cblnhbscOQOX6wqHLuxV7bQKPn1xm2bHvjFbnsk3dNWww
         jpHGr2j2rRP9pAa8iRaF1c2TQZzeoJ4qx1/apD6HsJz1/F+kmFrw6n375l8WKeMAiyYd
         C7FTqG0nny4SpdWNptCZd7os7kvsRuzEUqG/DqVuYVdtNjJliY4aqWb5ot3GRMid+XDF
         WjJslxMgwgqH4g2Fo9QH3GNB6JslG9BKnmb7zPMH+dHhitvWSKenETDEGuTQiGtlAK2n
         q49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=Xbnrxi2XNlDxJkc8YkYktIWAfF1/ifsnPBGcEl9SXkA=;
        b=UL1XFUBHv26l+Z9hWRx5sjNZQ61ZABfK50U84JgFXkBjiklCuxVejTqLj6uPwBWD52
         h+0tlfoFoqnODwYKeuBZbxtglL1YH1HE1Uy0qAa4+kkJwxRRdXp5CnnLf797/K6FJiVI
         tzyqVWshoig3tny0auejJiAkL/0rxglPuiQbZ2hPJ1lLrhWLAvYrDwcfCzJlYkprRwXT
         6JsWhqZaATX21SKqTJu5SI3xZCDIqLEx2UUeOFdrLz1rxMRINoQwM0Lvj5xp8/93W99d
         WTUQYsR1zxmvYrVKgUy0o5aYDiCnOdanxbdh6TDuCHsKrteoM/rNksR8mWeId04F2fi0
         uf0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.126 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.126 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:969:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2903:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4425:5007:7903:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12438:12555:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: pet86_8a7ab4003c714
X-Filterd-Recvd-Size: 2750
Message-ID: <1521693950.7999.38.camel@perches.com>
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
From: Joe Perches <joe@perches.com>
To: "y.k.oh" <y.k.oh@samsung.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Date: Wed, 21 Mar 2018 21:45:50 -0700
In-Reply-To: <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
	 <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
	 <20180314135804.GA21350@kroah.com>
	 <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594877629570662898?=
X-GMAIL-MSGID: =?utf-8?q?1595611758988069007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-22 at 13:37 +0900, y.k.oh wrote:
> 
> On 03/14/2018 10:58 PM, Greg KH wrote:
> > On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
> > > Cleanup checkpatch error:
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > 
> > > Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
> > > ---
> > >  drivers/tty/serial/samsung.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > > index 3f2f8c1..da9bddb1 100644
> > > --- a/drivers/tty/serial/samsung.c
> > > +++ b/drivers/tty/serial/samsung.c
> > > @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
> > >  }
> > >  console_initcall(s3c24xx_serial_console_init);
> > > 
> > > -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
> > > +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
> > 
> > That's not a complex macro!
> > 
> > Please use checkpatch as a hint, not the "truth".
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Dear Greg.
> 
> Yes! Of course that's not a pretty complex macro. However, I think it is
> important to make a small effort to modify the minimum standard,
> Checkpatch ERROR, to ensure consistency in the Linux code.
> Starting with this Checkpatch error of samsung.c, I would like to start
> my efforts on contribution from a small point.  Please review it again.
> If there are any points that require modification, such as comment,
> then I'll modify it.

It might be better to remove the #defines and use
an #ifdef in the one place S2C24XX_SERIAL_CONSOLE
is referenced instead.
