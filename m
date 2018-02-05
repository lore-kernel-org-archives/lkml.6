Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517815557; cv=none;
        d=google.com; s=arc-20160816;
        b=AS0Jj0M7SU+otHeuPIawZGqCewAxZ3nGW91qz5pjWyufGmdSzIGbM+HVq4IHTBeLUs
         DMAgpfk+KPETP9561zy5Di888OtOmLGeANYk3MO8Rh8n2zKVVJFBoWTklpzi6NuAd74+
         4WA0yVd7L3AtONNz9XrjZGR9eCJ7ghUYI7xod06V3PBC8ZKPuxcx1VRUPLdR+7RGZxqh
         1J/57Z5Cu21SJ8h4vEp5fqiQ4kKP3ygTaLoyBrxo7SD2icuMeaJudpJ0AECAtJG1KGV8
         /TxGWyeHYvEhVkdaPSFfN7ikxeItfDzHV8BNY91ZQvflsPqfrmacx42btYq5ku0F+w/Q
         RTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=z9jrVL0TPR14YaeZJwdyamryRmx+cp2X6g9rxoa/F88=;
        b=jAsVcZJWGHvKdzw3qN+srwTfV52eBf3a0o91g39MFVaaGMWq0TG3qjrEAkz6hCkre3
         ewIdPOUqvwycmr5EXP1Rk5eKZY+WJGOS988gY5B5uOfy/XRS/GLRl9Dcka5mIacGCQ9a
         OEUZwjtlnKmGTMDGuVe+rZf2tha7Vx7kuD3FFBSvdNO3zeDgJ+B9RIbqg383gMiYVkLe
         s+50ypkF1RRGfGpoSsTK6tEmGmPBQzPuHkzDYTAC3U3ZmaRonN4cJrRvU107rTOUM7aY
         welAvatWvstCpqazigsfRdrqlSnYlZKmt4mnfODhnDVd6IBBvYlqI+kqngciy0jDu4qx
         Ybkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WFyIQ9kc;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WFyIQ9kc;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224oGhm6B6rILbDKFJDl3Xcot5FKgmlTfVQ6JEcEqDMz4JZ6VtkHEaOgVE3AHsehVcbMu4BoPQ==
Date: Mon, 5 Feb 2018 12:55:50 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Milo Kim <milo.kim@ti.com>,
	linux-fbdev@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Julia Lawall <julia.lawall@lip6.fr>,
	Greg KH <gregkh@linuxfoundation.org>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-ID: <20180205072550.GA9376@mordor.localdomain>
References: <cover.1516978005.git.aishpant@gmail.com>
 <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
 <20180131110727.rmmwyqzwozwhda6z@oak.lan>
 <878tceckli.fsf@intel.com>
 <20180201113604.kcue6auuivud52qz@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201113604.kcue6auuivud52qz@oak.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590666949916676069?=
X-GMAIL-MSGID: =?utf-8?q?1591544966340498933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 11:36:04AM +0000, Daniel Thompson wrote:
> On Wed, Jan 31, 2018 at 01:51:21PM +0200, Jani Nikula wrote:
> > On Wed, 31 Jan 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > On Fri, Jan 26, 2018 at 08:20:08PM +0530, Aishwarya Pant wrote:
> > >> Add documentation for sysfs interfaces of lp8788 backlight driver by
> > >> looking through the code and the git commit history.
> > >> 
> > >> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > >> ---
> > >>  Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > >> 
> > >> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > >> new file mode 100644
> > >> index 000000000000..c0e565c8d63d
> > >> --- /dev/null
> > >> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > >> @@ -0,0 +1,10 @@
> > >> +sysfs interface for Texas Instruments lp8788 mfd backlight driver
> > >> +-----------------------------------------------------------------
> > >> +
> > >> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> > >> +Date:		Feb, 2013
> > >> +KernelVersion:	v3.10
> > >> +Contact:	Milo Kim <milo.kim@ti.com>
> > >> +Description:
> > >> +		(RO) Displays whether the brightness is controlled by the PWM
> > >> +		input("PWM based") or the I2C register("Register based").
> > >
> > > I rather dislike drivers with this type of "bonus" sysfs controls. I'm
> > > struggling to come up with any reason why the userspace would want to
> > > read this control (and I think bl_ctl_mode gets the fewest hits after
> > > searching with google hits of any search I've tried) . It looks to me 
> > > like this is debug information that should never have gone into sysfs 
> > > at all.
> > 
> > Agreed. I think the same holds for the other extra sysfs attributes. At
> > worst, having these prevents the backlight class from adding the names
> > later on, which is just backwards.
> 
> The problem is that they do exist...
> 
> For controls which appear to be misplaced debug attributes I think I am
> happy to nuke the values entirely. It is extremely improbable that any
> userspace will notice.
> 
> Unfortunately some of the controls look like they could be poked by an
> custom userspace so I'm quite so confident about nuking these ones...and if we
> don't nuke we should document (so thanks Aishwarya!). 
> 

Hi

Thanks for reviewing. Should I take it to assume that we would like to keep the
debug-like attributes in documentation for now?

Aishwarya

> 
> Daniel.
