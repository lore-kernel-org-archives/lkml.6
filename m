Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx4/hgsDgGDeWVzS6VqkFwnwT/l23mKj4XLf2UNyYXHnONUciBZcK/v4h05vTRJLgWswiMgGF
ARC-Seal: i=1; a=rsa-sha256; t=1522681024; cv=none;
        d=google.com; s=arc-20160816;
        b=UpakFUX0RQM29GRn+k1AUhRzYbmsQJ0MaBZddTHF5Jlj4znwL5qMrRsiTgi3VAzfgz
         fKzhrLca+TmN1lL51p/HN3pOSM0fhgXSa934cC6zpn0kLGrKvY+Sdn9UUrE68rbWcP0r
         dgKfafvUwTWYx6PRySg0xBYBoemGVwOvXlF2oAoLoyiwstSgFcGI9VVl+G1WZhptgBDn
         2krRto89tHrT+0MvBheGBDYa0FW7v9WyyXYMwyMUbR9OjDlD5m5W8mYOl5LXPbN0ke6p
         TlX/itc07zmGA4aRClDoqCWgWZOXIJ99TzOjZ3rkS3NACB1YysxDLb9NsJqQmXaxKIXG
         CiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=LB2mcZjhpQpmOGKyOdRdw1NT6wS+u1sCM+rufm46gBM=;
        b=zavsD72ILz9x84z63c2YGIA9aZO174QmZ0nfugQpEJhKN+0eU7T0QqpuyiZC5mVaXy
         VfdaN33RphncPxYLdfMGL5vwd35GWsF9QoGqaX0R8Ml41gftfzqF4QLD1FxIbrIfZuBn
         ZmVLCKE5MYc3ACePzzaSArZ0Wku5rTdUHPHoTye1JuBOWmqevc6McsC5MX3Bhp3Zgb8X
         9jRZ5QQlouxU1C4fDjxCXU42uVV8uGxxu0sWgxvDzWuXhxUT+yWsb5cjVL5Iikwlm2kT
         YfCXlXqkLQ1u0rK+He2oqTDVZQL7ETHr4PELUDjvz980diCaTe2+mqTiPF90ePYLiayu
         ab5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.25 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.25 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2005:2194:2195:2199:2200:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4470:5007:6119:7903:8603:9108:10004:10028:10400:10848:11232:11658:11914:12740:12760:12895:13069:13141:13230:13255:13311:13357:13439:14096:14097:14659:21080:21434:21611:21627:21740:30054:30083:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: toes22_3505645aca3b
X-Filterd-Recvd-Size: 2112
Message-ID: <1522681020.11653.25.camel@perches.com>
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de,
 gregkh@linuxfoundation.org,  driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org,  Quytelda Kahja <quytelda@tamalin.org>
Date: Mon, 02 Apr 2018 07:57:00 -0700
In-Reply-To: <20180402114538.slvlts3djle4mqev@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
	 <20180331060855.9452-1-quytelda@tamalin.org>
	 <1522478173.2210.53.camel@perches.com>
	 <20180331084150.e6uottdsdagtywbp@mwanda>
	 <1522505573.11653.1.camel@perches.com>
	 <20180402114538.slvlts3djle4mqev@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432385681826765?=
X-GMAIL-MSGID: =?utf-8?q?1596646778118702637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-04-02 at 14:45 +0300, Dan Carpenter wrote:
> On Sat, Mar 31, 2018 at 07:12:53AM -0700, Joe Perches wrote:
> > On Sat, 2018-03-31 at 11:41 +0300, Dan Carpenter wrote:
> > > On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:
> > > > On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> > > > > This macro, provided in 'linux/kernel.h', will calculate the size
> > > > > more succinctly than a division operation.
> > > > 
> > > > It's nice that you send patches, but please try to send a
> > > > cover letter with your patch series.
> > > > 
> > > 
> > > There are obviously times when a cover letter is required but what's the
> > > point of that for this particular series?
> > 
> > practice
> > 
> It really pisses me off to see patch submitters get assign busy work
> for no reason.  This is not school and these are not your students.

Please take a chill pill Dan.
I think cover letters are best practice.
