Return-Path: <dsterba@suse.cz>
X-Google-Smtp-Source: AB8JxZpWuO+t90j8fH0p06Dnsd7JKcHxEDus7Gfx1BZ1IYx9bsr/r3+QUs4mltps8WyZsfa1oNec
ARC-Seal: i=1; a=rsa-sha256; t=1526028582; cv=none;
        d=google.com; s=arc-20160816;
        b=XL5zdnX2dLiBgCklv5U9hYxmhceOyC/mZmSLq4V5mO3zvoqCu02PZb3F4vUNpffgK+
         UIWR+FQj2mmpAv1OuP9v3u7O/H1swZcuh4+Q94+LhSrTPpKHZJsUWPkQP3iTG+iaZ7ny
         pIT71MsOrm+BhBXBsSZu2ACurld7yHtxEtWM5viz/psdT4fzpx+QU+6BNQkvyn4VKjJ6
         pmPUo+NXehuCJC1UWh66rpOFN+K2ipG5byN/e2FXe8iPHi4dwqIENXIwy3usi1+8Ftef
         byLZdAw3WUaDqjIz8paTOqj2yloJoRquz23W0MaLSFm0XRp0uu7l3gR1q0BBLXLwTSlk
         H9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Mfl0V1bPc94ZVeNyRxuqRa79gX4Z0YcKF8bmULhCPBU=;
        b=Oy2hopT1OMRikb2LTwxvZRb8QpQ8olNXyi+cZVJXzCnfZylPIYcwEhBsB1ooIvUTcd
         +yBILo2sMgBnJG/7I5kE6RzYob8rt3Jz2tzjEb371kn3v47afw/1GmRXbB+dW7knJU92
         aopri7Y6Y3CKSC9Xy1UsBy03G/jMGwOqaDR/jQ5NaqmQ08jYoLYOwlcvybt+EAbd5Gzo
         oM299MmGbZqcpXEHqeL9kS0DGJSyfYpbIAvLsP1yBx1kU32BXuEZNxWXExXXVid38+2N
         jq2Mg3lotcgmkqmuGUc5q2nsh4Wo2oEwynfxYzTSLlY1b7ZNT/QhwS3Wn9GZpWOli24L
         4JhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Date: Fri, 11 May 2018 10:47:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180511084701.tosopl7oso5j7wfq@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
References: <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600156946423194429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 08:47:27PM +1000, Stephen Rothwell wrote:
> > True.  It's currently only those -fixes branches that people have asked
> > him to merge separately which isn't as big a proportion of trees as have
> > them (perhaps fortunately given people's enthusiasm for fixes branches
> > that don't merge cleanly with their development branches) so we'd also
> > need to encourage people to add them separately.
> 
> I currently have 44 such fixes branches.  More welcome!

Please add

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git next-fixes

Thanks.
