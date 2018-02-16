Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1024438-1518815116-2-8803612874968445129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518815115; b=eE657aI/whyOJcZZjgMu4tkn0LaESGxd9HjKkqEQQczYCDa
    WKATZESg/I0VMztwL5fo3I62lX3MEgzJddt301Dok6TFF969fYrI09AgJkVoe/lH
    ouoictBOg5WW39svSxxenGjFWy9TLD/FpZKcSkUhzvgBJkBB0DrhCJPloVPy9VIO
    fE3kfkGI1G7BacDKy0xD9PvAygc4OCB1+tY5bAPmlqo1rYQZ8DQEHVtTjX+/2wwz
    Zt1Q/oFmFqnujFnAp3TLrB+Z9xVZ8CgnFwxJKHJufrRPuhq9UCVUc4RMZw95Z6/g
    DL39PyJGGCLTK/KbuYqhlM4qFwp5bVpFvE5878A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518815115; bh=h
    XJgH0aJosqwNu/2w0nkb6AA5XmtnspuO0Ot+7ZK9/A=; b=OWnpepYrG/L/HsBp5
    P4alCT4rkjdjkSjwclmYF0+6sCbdMuBCubtS9ZX+VhscDCyh0SbEYEWYqYEd4d+z
    4OLZcERl9wi/Bwcqd2FUBBM05NSir6gXW0pEhAzqVz+qPy3Qx4VXefvJpk6i3Y69
    /13O0/cRdBe6V8EvsFa5cg6WYj3t+LkwI4r1O4vq91g03hmwmKo9k5eaTsgWoKo5
    rcdOLNFsXhv81CIj5UTWd+6t/jIfI+12oeVRJRWPvgQA6owVXYynxLYUz7/uAkIq
    DSE36STbXZzJf4K96N7hs4BrnoB+9Qb18KXfVB8WtlTKIFWBaeOFij7ikHqwPCYM
    Y1AOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:6120:7514:7903:8660:10004:10400:10848:10967:11026:11232:11658:11914:12043:12296:12438:12555:12740:12760:12895:12986:13148:13161:13229:13230:13439:14096:14097:14181:14659:14721:21080:21324:21451:21611:21627:21740:30012:30029:30054:30070:30090:30091,
 0,
 RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:21,
 LUA_SUMMARY:none
X-HE-Tag: twig11_f44ad1c0e81a
X-Filterd-Recvd-Size: 3160
Message-ID: <1518815103.13169.23.camel@perches.com>
Subject: Re: [RFC patch] checkpatch: test identifier lengths
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 16 Feb 2018 13:05:03 -0800
In-Reply-To: <20180216123139.84c4efe02dc40ed333d886e7@linux-foundation.org>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
 <20180216125519.odsteynuaielxpet@mwanda>
 <1518801207.13169.15.camel@perches.com>
 <20180216123139.84c4efe02dc40ed333d886e7@linux-foundation.org>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Yash Omer <yashomer0007@gmail.com>,
 gregkh@linuxfoundation.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-16 at 12:31 -0800, Andrew Morton wrote:
> On Fri, 16 Feb 2018 09:13:27 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > On Fri, 2018-02-16 at 15:55 +0300, Dan Carpenter wrote:
> > > On Fri, Feb 16, 2018 at 05:06:34PM +0530, Yash Omer wrote:
> > > > This patch fix line should not end with open parenthesis found by checkpatch.plscript.
> > > > 
> > > > Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> > > > ---
> > > >  drivers/staging/nvec/nvec.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> > > > index 52054a528723..39fb737543b5 100644
> > > > --- a/drivers/staging/nvec/nvec.c
> > > > +++ b/drivers/staging/nvec/nvec.c
> > > > @@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
> > > >  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
> > > >  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
> > > >  		nvec_gpio_set_value(nvec, 0);
> > > > -		err = wait_for_completion_interruptible_timeout(
> > > > -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> > > > +		err = wait_for_completion_interruptible_timeout
> > > > +			(&nvec->ec_transfer, msecs_to_jiffies(5000));
> > > 
> > > The original code is basically fine...  It's OK to ignore checkpatch in
> > > this situation.
> > 
> > Right.
> 
> Yes, I'd say that checkpatch is simply wrong here.  I'd prefer that a
> function call always have the opening paren hard up against the
> function name.  Because I often search for "foo(" to find the callsites
> of foo() and I expect that some code-parsing tools do the same thing. 
> The "(" is the application of an operator to an identifier.
> 
> So I'd vote for simply nuking that checkpatch warning altogether. 
> Maybe there are other situations in which it is useful, dunno.

Doubtful.

The idea was to have functions have at least 1 argument
on the same line as the function name.

Care to comment on the identifier maximum length check?

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
