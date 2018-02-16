Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1017188-1518813920-2-17707093888756544761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518813920; b=VU1VXzFGmXDrt7OfGhA9ZvLccOZvLKkW05Xz/hhAnwXZZMV
    fZjtC+SlVHeDW4PCkKedeuSUrN5UzSYrzhydmgaeZpPQda9UYAz+ab4tm2u3sSTS
    Tc3M/UbyZcOmuUyY0v/Fwj1G4vbz/y+HIqww3aWK9AutWygt+VofmTbTNcukgciE
    TPvl/vOcIE3uP4AaGVRbRb28BnjDY/n27RH+KG3yxg7UUSCS2YYGsOGjZowTuJ0w
    VjHQ9S5jaFcn8eg7PC3Q/zq7m7Pf50hareRnji1e4ofD6oCpbMurVvGCGc7g6MXg
    6J0SZKKAybKBjMgVD1xUR5qFVG452A3yfw7Z2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518813920; bh=H
    S812fq5URDvenXdSZHkiz1DFwTct+rhNCckHhjLKfQ=; b=KRcjqkGJ8X988UfYa
    skwilPHNqhrv1wMCuxWVlhKipCqz05/rf6Wds7VAAh9SKeOnhGNSfm43RaOxritz
    prmw+WFbc0/uKvKGlTs7TUXwDY+HzPXD1foxuKBHy8ST5cnx566aCmehqW0LCTCC
    bSg45XUSLX863eJd2ZDLkYs/T/xUbdTE+ATjRxl++JcsxGX83DKhsvLDHVeYMIIk
    D6/8uOw9NyHvSljJHq5hmqCm1lFXxO+eh3ij5sc4aO0ZBlEj24Yz7E2XOX5Hfo0p
    teaaLuGLokuBRendiM5OKBGcNemlyJ7PdnQDLcMXaIRGN9O5Ya2f94k4fOtexJdM
    8pndQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Feb 2018 21:44:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC patch] checkpatch: test identifier lengths
Message-ID: <20180216204459.GB1800@kroah.com>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
 <20180216125519.odsteynuaielxpet@mwanda>
 <1518801207.13169.15.camel@perches.com>
 <20180216123139.84c4efe02dc40ed333d886e7@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180216123139.84c4efe02dc40ed333d886e7@linux-foundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:31:39PM -0800, Andrew Morton wrote:
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

That's my vote as well, I do that same type of search.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
