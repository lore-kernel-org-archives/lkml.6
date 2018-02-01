Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517500026; cv=none;
        d=google.com; s=arc-20160816;
        b=nqCRYWFha2ZoZClZP7GPLNzlUe/OuPp6Iry7moQB3iLCrLhgoWZwcZzw9kdLhKdP33
         4lEbRkCqZyLpsHhoA5dzkbd7Zmo1gnLEPYJC6o9TUA4Xq39eC39wLojMHW2RwR3htXTy
         uOlY+EYRkR3ogUOBtrsY/l1I4Y12KwuatZGAk8YDe2c7+2JlXEAFR9q674cOzIK0jYUe
         3h29uSkEaA/Ftixbi/WhXeiX+7tTcMtM+ST1cOKggMeQLNFCKiltYqi0CFvwZzYIB3Kv
         X6Ikivo1yAH40u9iDSGZu4J+1+mdDATpMCaTtHnF4OeTLLwOB62vnwgsTDU0hBExqjv2
         xvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=HQ05xZaI9RX2C1WjcmQEY6wiUGOeZt+dADSJ+Z5ntbc=;
        b=Krwdd6sXhONlyh+a2d/oHFU0lecyJpVolEX0kbkrh0CyvmKDonoY2Sbb+Mkd0mBDGY
         1e5nfT/en/HOj0/wQonJ45DxjKbUhy6px7aMs7U7stjDD6l8t9olDXP4yorHJZIfTilS
         9ytDJb6Yr3oSKF/ew5PeTDjZoyFBmeG6u+JNX2uzeHji2KR83gfw1i+z0l+DGH7k4owh
         f1wbhdENrQwhkxWLYFX9KZ0nCda8btPbLVqEdDQQ0beuLm6wTu6zuTiV8TysuVhOaV9F
         F5AatjO1ODIkiu/ye9Kh9DXieu9rPG5MBkyXa6690STcLmc6uiLB1sdYhO/CIQJTWqpG
         eYPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qVKjww2d;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qVKjww2d;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227+bpkaO1o9He7hxdLKZqm7YZhuM6wOeqO0K/ex5TAnmjgFJpIzqhGBjEkDWgyUuN1wo/sjqw==
Date: Thu, 1 Feb 2018 21:16:56 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Milo Kim <milo.kim@ti.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/5] backlight: lp855x: document sysfs attributes
Message-ID: <20180201154656.GB22817@mordor.localdomain>
References: <cover.1516978005.git.aishpant@gmail.com>
 <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
 <20180201110642.qyjwyrdwglevlk5f@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201110642.qyjwyrdwglevlk5f@oak.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590667129799888264?=
X-GMAIL-MSGID: =?utf-8?q?1591214107527267104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 11:06:42AM +0000, Daniel Thompson wrote:
> On Fri, Jan 26, 2018 at 08:23:00PM +0530, Aishwarya Pant wrote:
> > Add documentation for sysfs interface of Texas Instruments lp855x
> > backlight driver by reading code and looking through git commit logs.
> > 
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-class-backlight-lp855x          | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp855x
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp855x b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> > new file mode 100644
> > index 000000000000..5b9d38958875
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> > @@ -0,0 +1,19 @@
> > +sysfs interface for Texas Instruments lp855x backlight driver
> > +------------------------------------------------------------
> > +
> > +What:		/sys/class/backlight/<backlight>/chip_id
> > +Date:		Mar, 2012
> > +KernelVersion:	v3.10
> > +Contact:	Milo Kim <milo.kim@ti.com>
> > +Description:
> > +		(RO) Displays the lp8755x chip id. Possible values are:
> > +		lp8550, lp8551, lp8552, lp8553, lp8555, lp8556 or lp8557.
> > +
> > +
> > +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> > +Date:		Mar, 2012
> > +KernelVersion:	v3.10
> > +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> > +Description:
> > +		(RO) Displays whether the brightness is controlled by the pwm
> > +		input("pwm based) or the i2c register("register based").
> 
> Since like the first patch in the series, these look like they are for
> debugging. That thread is still active but whatever the outcome of that
> thread please assume it also applies to this patch.

All right, I'll wait for conclusion on that thread before I re-send the patchset
with the updates.

Aishwarya

> 
> 
> Daniel.
