Return-Path: <daniel.thompson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517484967; cv=none;
        d=google.com; s=arc-20160816;
        b=A0mubakyaL2beYwMiQ4qPzDPLfr5VDv4EAZV4JaP3nuoGHcNtg4TK/G07yWYG1K6SQ
         tu30O4OMGieSIkujKkujscQaWPBNdVbLu3PbRFm9eduGxTaCdXGZNMXqRrE94as2kQuV
         /pKghQVwmPKTi3xXCDO21Rof2zpbfQiLtH5cmNdP43yjWQRe7jSl4aIqQ7AsIzqexn8E
         Eq00W8NIqkOkvmFABhyfzK7EZFl4DjKPwxtxT1SXpBDrrsH3X3S2jpSfIG0TgRK2CBwK
         kChZuPuhBwbc+OpeTE1DZadFcQq4LNB+ThR0KeVZ7cxwsQDAMIf9Z88TfHKNfdfmMT+2
         P9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PMrojZ+EC7QQSJjYcQ4qgqKNtyna5iWciwcCfTCxaUY=;
        b=Qov0T8Qcx9/zR3GormN2O67PdvwEeLWlK96K8beabmjdTSmMNJZunbvZkoeX1mGH6j
         bv1ockNKmhXmeyz1B66Hl/get7Hb3V/aKrgdcjQaaaPTsWI+NUGhR9Olm6G60QnHnBzr
         dYpSCfWJVgyinf+1zA8PQU5ET6ZpAkC62M1RtSFH4wkVX+UKGlTxkeXXvgVREy8A/b8d
         N2UFMF/1/oIqxNEMmlLImo1M+Qu0wodPX1MrBFkdd600K60T2hJkvG9TAX3lmXyMRpv0
         T5V/vUOI9RY+C53nQA4xfhVoXJHMOliKV1SA++PAbvoFyb2Wt1GnLRqpkriihMpIxFgr
         6VUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C74MxRjH;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C74MxRjH;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225rIYcKjfkiNEtGdrAR9jOQSNrFt0Zz07gyR8yeOO0Vg2M51UZgfhDTzzl9Zz+LCAPr8oTd/Q==
Date: Thu, 1 Feb 2018 11:36:04 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Aishwarya Pant <aishpant@gmail.com>, Milo Kim <milo.kim@ti.com>,
	linux-fbdev@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Julia Lawall <julia.lawall@lip6.fr>,
	Greg KH <gregkh@linuxfoundation.org>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-ID: <20180201113604.kcue6auuivud52qz@oak.lan>
References: <cover.1516978005.git.aishpant@gmail.com>
 <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
 <20180131110727.rmmwyqzwozwhda6z@oak.lan>
 <878tceckli.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tceckli.fsf@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590666949916676069?=
X-GMAIL-MSGID: =?utf-8?q?1591198317332550194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 01:51:21PM +0200, Jani Nikula wrote:
> On Wed, 31 Jan 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > On Fri, Jan 26, 2018 at 08:20:08PM +0530, Aishwarya Pant wrote:
> >> Add documentation for sysfs interfaces of lp8788 backlight driver by
> >> looking through the code and the git commit history.
> >> 
> >> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788
> >> 
> >> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> >> new file mode 100644
> >> index 000000000000..c0e565c8d63d
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> >> @@ -0,0 +1,10 @@
> >> +sysfs interface for Texas Instruments lp8788 mfd backlight driver
> >> +-----------------------------------------------------------------
> >> +
> >> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> >> +Date:		Feb, 2013
> >> +KernelVersion:	v3.10
> >> +Contact:	Milo Kim <milo.kim@ti.com>
> >> +Description:
> >> +		(RO) Displays whether the brightness is controlled by the PWM
> >> +		input("PWM based") or the I2C register("Register based").
> >
> > I rather dislike drivers with this type of "bonus" sysfs controls. I'm
> > struggling to come up with any reason why the userspace would want to
> > read this control (and I think bl_ctl_mode gets the fewest hits after
> > searching with google hits of any search I've tried) . It looks to me 
> > like this is debug information that should never have gone into sysfs 
> > at all.
> 
> Agreed. I think the same holds for the other extra sysfs attributes. At
> worst, having these prevents the backlight class from adding the names
> later on, which is just backwards.

The problem is that they do exist...

For controls which appear to be misplaced debug attributes I think I am
happy to nuke the values entirely. It is extremely improbable that any
userspace will notice.

Unfortunately some of the controls look like they could be poked by an
custom userspace so I'm quite so confident about nuking these ones...and if we
don't nuke we should document (so thanks Aishwarya!). 


Daniel.
