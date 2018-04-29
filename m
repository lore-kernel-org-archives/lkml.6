Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqIUSL/1BWnb840ZYbb3Cw7X/qgr6Ziu2Jq+BqSQhCaG67PsIh0ckJc1aLq4fIRhE+UY0QT
ARC-Seal: i=1; a=rsa-sha256; t=1524987063; cv=none;
        d=google.com; s=arc-20160816;
        b=Fq07fgD87VKWaA6QJjMeszkArgtfwRPzV8aCcVaMG/EJe1X7AWp0kZWBNCLJOZW2z+
         VOwCda+8bMqse1ZMIBEj+ROsXs1YchRtPoFPYVtOfJ9LHN/TQ9whxkIuulO7m16ZjgWz
         bcMnEoff85mbdd30w2X7a5JdrbF5uS8+qFb2j6NjDEVpdaq/nUXrR/GhkuCHKCG3BEMl
         Ev2uRGRGRg1JD8XLfZpnQrXFD2fnC1zrTo/c/3fgukTuNsgT3OMu/agmoZv16bobMuB3
         mccSdqC9e1Mbbkw+V1mzzM/fp0rOYoPpjIksSAF0I+5Jf36Z54sZPO+pV3f9hDDWwucD
         WIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/LiNC79hL+tbXyR61uJ6/psTqqLcS52SYl4Nm3BGrH0=;
        b=g6TVNT3WjpgHfIEfefW2Qf/vyLH9EeAGUzHvkFlhCE1xSjRuEpSsszMdYlXUHl1fND
         NJ9wzti5q5rihUKG37tZv0BSMc/u2RrNXGvQJ1Rf5G+FUtG13g3ghxDjjejqAAkOH9kp
         gA5PRd7gU1S6VYn0BWwqYCW+z4CoL1qc1jPOYcr1WOA20Y822P4p1EwG270jqyKKTIS5
         ouk7mwxtQaUfPyUNN0dSsx0Cc8eh1IIM483XZjde9yc6jgCH9NBDHf6h5Gte6okRBTZA
         Fws/b+7oH8+7Q8+xLPWWpmfMpbTCaUSHGgpjUuZOto3yT4+zlxXWBrIWKWo3Goos6h8D
         H5kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sun, 29 Apr 2018 07:31:01 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	DOCUMENTATION <linux-doc@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Kate Stewart <kate@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Christoph Hellwig <hch@lst.de>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Rob Herring <rob.herring@linaro.org>, Jonas Oberg <jonas@fsfe.org>,
	Joe Perches <joe@perches.com>, linux-xfs@vger.kernel.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Florian Fainelli <f.fainelli@gmail.com>, mcgrof@kernel.org
Subject: Re: LICENSES: Missing ISC text & possibly a category ("Not
 recommended" vs. "Preferred licenses")
Message-ID: <20180429073101.GD27875@wotan.suse.de>
References: <CACna6rz_Ms2Uv1P6E0gCGNsRwK4nm=PMAOaJ5Uk9aJxs2VSamQ@mail.gmail.com>
 <20180429052617.GC24294@kroah.com>
 <20180429070315.GC27875@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429070315.GC27875@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599026726440039181?=
X-GMAIL-MSGID: =?utf-8?q?1599064834683403237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 07:03:15AM +0000, Luis R. Rodriguez wrote:
> On Sun, Apr 29, 2018 at 07:26:17AM +0200, Greg Kroah-Hartman wrote:
> > I see it is only used in a very small number of dts files.  Why not just
> > use BSD-2-Clause instead?  What do you find in ISC that is not available
> > to you with just BSD?
> 
> ISC license is a simplified version of the BSD license due to the Berne
> convention. It was also used for wireless drivers to help the BSD community in
> particular OpenBSD who had picked that license for new contributions claimed
> simplification of the BSD-2-Clause. Because of this reason many BSD communities
> feel super comfortable with picking up kernel code in Linux under this license.
> 
> Granted, I'm on no longer a fan of promoting permissive licenses as it didn't
> buy us cross-collaboration at all. We tried.
> 
> But it would be unfair to advice against a license unless a reason is stated in
> favor of another BSD license. Why is the ISC license worse than the
> BSD-2-Clause?

Here's a good 'ol discussed reason as to why to prefer the 2-clause BSD
I suppose, and also to consider dual licensing actually:

http://lkml.kernel.org/r/20120408155709.1c817f1f@pyramind.ukuu.org.uk

So essentially tested over time, runtime considerations, and whatever the FSF
decides today may change tomorrow. So best to be safe. The dual licensing
strategy also helps with "unanticipated incompatibility".

  Luis
