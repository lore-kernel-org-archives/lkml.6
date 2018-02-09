Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518173674; cv=none;
        d=google.com; s=arc-20160816;
        b=Ob1JwRaCRIXXyN7pXXIWs1gXcQwrLWizktTO8yXnVBLoStORscfncAbCWTESuRb7B1
         Z2TZ3/q6OYxzXW72QzkgkCQicr3lW0zHMbcNN6+f1bICoGKVAjMvQj+2RewzDYrZCObT
         BVw/h/Y7x0sk/ElUY2irquaDCOmS9GLOknO7kxEsbyuXxKZVKzl9EKvBnRaSmh/75IPv
         PYeFIgOS0hGz7Dcw21PYjtTPvD+66M/tzoOvbYBGtVN+B2cZWhQ5GXtHxc+AWMwfb/SP
         jjMsYIL/WwQcN0E1EpcfWFzRfzg2iEag4zS/MK+Odg+l033MJBt83jjyUuBh94EpjVxa
         xrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Xa8JNSYl/ghqeujkgtblGG+BxwUTFdDvOXAkj3ygqbY=;
        b=XKbpIcpJmTtCrhsfz256mLnKajzQyditWwsFG+a9JdsNqdkJHQU0KTtPRZB7W1yJst
         6JQbvpVK81HRrGxWcofyOZ1CucqT9CZDjdqnrI41YqjstnjJFg3DdIfAlWL+n4ZEY5ze
         clfDgMmYH4k0Py4JoZ2XC5YFOLHiAfRSsMz/TqIwRNDu0L1TVjG+BiVwp0G1yFUiYfLa
         g4zKQdWFkS/FqDnTCxS50SthJ+XZ7tDEFMu46qbTzqUlyT4OKJxW8vzpOlbQlrA39reL
         pM29vlQdsqTmITZZSWHPLgZquWyUDe8UDEayuY+62LxI6QR+1/jE+ApbXVJ43QmflZHh
         t2qA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hhAOCN1E;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hhAOCN1E;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224tRm27mo2y650IHhMJkMrg/Mq6FqTNhOe+fOViBZG7rRomauEDl5DF/JlKeFaR2klaws73/A==
Date: Fri, 9 Feb 2018 16:24:25 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Message-ID: <20180209105425.GA24487@mordor.localdomain>
References: <cover.1518009225.git.aishpant@gmail.com>
 <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
 <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748317597152283?=
X-GMAIL-MSGID: =?utf-8?q?1591920479218499027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 11:31:35AM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> > The descriptions have been collected from git commit logs and reading
> > through code.
> >
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> > new file mode 100644
> > index 000000000000..e8168e5198d7
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> > @@ -0,0 +1,30 @@
> > +sysfs interface for ACPI DPTF platform power driver
> > +---------------------------------------------------
> 
> The header isn't necessary.
> 
> > +
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
> 
> There should be one entry per attribute AFAICS.

I grouped attributes by the date in which they were added for brevity, because
otherwise fields like Date added, KernelVersion and Contact information are the
same.

I can split them up if it makes more sense...

Aishwarya

> 
> Also I need Srinivas to tell me whether or not the descriptions are
> accurate enough.
> 
> > +Date:          Jul, 2016
> > +KernelVersion: v4.10
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               charger_type:           (RO) The charger type- Traditional,
> > +                                       Hybrid or NVDC.
> > +
> > +               adapter_rating_mw:      (RO) Adapter rating in milliwatts (the
> > +                                       maximum Adapter power). Must be 0 if no
> > +                                       AC Adaptor is plugged in.
> > +
> > +               max_platform_power_mw:  (RO) Maximum platform power that can be
> > +                                       supported by the battery in milliwatts.
> > +
> > +               platform_power_source:  (RO) Display the platform power source
> > +                                       0x00 = DC
> > +                                       0x01 = AC
> > +                                       0x02 = USB
> > +                                       0x03 = Wireless Charger
> > +
> > +               battery_steady_power_mw:(RO) The maximum sustained power for
> > +                                       battery in milliwatts.
> > --
