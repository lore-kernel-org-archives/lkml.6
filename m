Return-Path: <srinivas.pandruvada@linux.intel.com>
X-Google-Smtp-Source: AH8x226z/LV8OE2FHGv4KdXcbLC3xiR6D0Ogrd5wlni4ejNXNv0WfDSSu6pvXnhYRUuYtSuYknhG
ARC-Seal: i=1; a=rsa-sha256; t=1518202677; cv=none;
        d=google.com; s=arc-20160816;
        b=vZAIg4uSK0LXrl+K0OOdlEpZ5G2hkdGFvZkaVq/isaSp8nbOGuix10XT4KU46xwI+y
         MJGF68nR1vABxS3A7oHiaK0jBzVbPnQRB8Ek1z3vMuEuxKUponumlj2Nhgz7NJo+jlyW
         yYuefPoYD+lXezwaeQeCOok0g4qfQ3vHOEvV+96auw5RrmaaEJ+rco8NqjSLSrHC4IHA
         5ND9a3VOMubDcMiHcxJS5msFhmyweW1gT0iAU4m2cWtv5sEV2xAtmix+m8pmrrvgLJs5
         +suGFtiBSTWZQAU+6gScrPl/kCP0dShINhuo3iFci9yd/5TfXb/TDChFkQL86+Y2dRkz
         qFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=gcai02ufa5AbIQlV0PUdeQF0bjnV5GhWNuOOyLNviGM=;
        b=WXVl+XC9ezwc5jEbtytK2KLWeG+tdP6+w9kmNBA96jDqfvq/9LGUX92iIL9X9eMeMY
         cALAEIZ7H9+6psoujRM0JzbDgAx6NiX02/2qYNc4C1qaqUsMBTAbIYnvJrjVVNpP33az
         KklHyHK0XwPscx5Lec0X7DunS5u7IXgx/V+chMnc9+zhx62SDVkrUEmN55lt5Z+WlQpj
         cmshvsb5x1GdV4ELrjYI9pTM3L3sE4CMxJ598xqlUzFxjT/8xdp+PcwOoYlcS0G0U4hN
         jWTTX/YyJb/Cju/MOz6DpIPPvf+kifFfLfBu83fhPRwSx+YUJMiY4Dp3l68DI2Y5wImK
         b2HA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srinivas.pandruvada@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=srinivas.pandruvada@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srinivas.pandruvada@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=srinivas.pandruvada@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="200000943"
Message-ID: <1518202676.1692.3.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Aishwarya Pant
 <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg
 KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 09 Feb 2018 10:57:56 -0800
In-Reply-To: <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com>
	 <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
	 <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748317597152283?=
X-GMAIL-MSGID: =?utf-8?q?1591950890654915952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-09 at 11:31 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com>
> wrote:
> > The descriptions have been collected from git commit logs and
> > reading
> > through code.
> > 
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dptf | 30
> > +++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf
> > b/Documentation/ABI/testing/sysfs-platform-dptf
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
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/cha
> > rger_type
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/ada
> > pter_rating_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max
> > _platform_power_mw
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/pla
> > tform_power_source
> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/bat
> > tery_steady_power
> 
> There should be one entry per attribute AFAICS.
> 
> Also I need Srinivas to tell me whether or not the descriptions are
> accurate enough.
Descriptions are correct.

Thanks,
Srinivas

> 
> > +Date:          Jul, 2016
> > +KernelVersion: v4.10
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               charger_type:           (RO) The charger type-
> > Traditional,
> > +                                       Hybrid or NVDC.
> > +
> > +               adapter_rating_mw:      (RO) Adapter rating in
> > milliwatts (the
> > +                                       maximum Adapter power).
> > Must be 0 if no
> > +                                       AC Adaptor is plugged in.
> > +
> > +               max_platform_power_mw:  (RO) Maximum platform power
> > that can be
> > +                                       supported by the battery in
> > milliwatts.
> > +
> > +               platform_power_source:  (RO) Display the platform
> > power source
> > +                                       0x00 = DC
> > +                                       0x01 = AC
> > +                                       0x02 = USB
> > +                                       0x03 = Wireless Charger
> > +
> > +               battery_steady_power_mw:(RO) The maximum sustained
> > power for
> > +                                       battery in milliwatts.
> > --
