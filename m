Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518173871; cv=none;
        d=google.com; s=arc-20160816;
        b=FhCF/iVKf8q9GlgN5sOEBOLJqvkd607cQzF09AicF4fI6rZT5+33ZbisS4Dr3AY9RO
         hCDz8TVP4rRgLDiBg7pyECKS8Mrtzh4fu1zqfA2QN4FzQSqdU6h/Gwt5QykLPk2kJSHr
         BIIyvCxhtsN7k93IyVUfy5LOnGB7cedtZSFcnl47Cs7jh/KgEgLdAtH2PI+2xn2KJq8l
         OzjWa2+BCG9GWi1geftgCuGf5w4Bld6JOH0FWqrSSpVr1DhLhZ4SatXSZ04ad1n9XeQr
         Qb91aH0RwYHT29MdoX8ztRtiKLPZtTTrqFeZYQqQUZcXIqwX6LptPZ4EHOp+d7sbHKY3
         LrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2ad/80y4vvjDFVxwz9mGKPnO21lTzVe9LsItYYUMadY=;
        b=AzIcBve8mWDBZ/3y+HOGtcfm7f1yGMC0nPQnulUQlke+YdQHjoVPk/uLuR4IX+zN0q
         AONIJmT5lz1WG1itdvMQlzs2vaM4GH18RD41UVboEqUTj2EKchH4zqY3ScmmDzRnDq7z
         OBDclpA5K6WQ+fAU9HdBdCLOluizI62iHl/cictNWRjYXTvsQCzul7EMFbz2zHLEvM87
         73F9R0v7lxLzGZjyzgbRXvmBAllgZbJslX9LvqPC6lkhSVvI+C2KaDMuxgObwowGx73r
         Rvq5k8uqC/BYrsGtimrkwQx+wo8tl+3jqELOEPZx9OSX9de8EbR2Cdn9tYFHtytBVLfO
         CLIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f6Bdp2VI;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f6Bdp2VI;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x226iw/FF9hpMRgAXPIMnvd9NGKohRdAcX7r2hb1IxTxFuLTiZrIa+o+af8ZaH+/reurrzDiHJNuzCUKgxZKIfMU=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180209105425.GA24487@mordor.localdomain>
References: <cover.1518009225.git.aishpant@gmail.com> <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
 <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com> <20180209105425.GA24487@mordor.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 11:57:50 +0100
X-Google-Sender-Auth: bu6_0kE_RsQHb7iIzqNJ-5qNnyw
Message-ID: <CAJZ5v0gwiuo_b_N_8PjJ7Q532s1V-e37080Dk0YCNs+nMDVOVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748317597152283?=
X-GMAIL-MSGID: =?utf-8?q?1591920685463641649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:54 AM, Aishwarya Pant <aishpant@gmail.com> wrote:
> On Fri, Feb 09, 2018 at 11:31:35AM +0100, Rafael J. Wysocki wrote:
>> On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
>> > The descriptions have been collected from git commit logs and reading
>> > through code.
>> >
>> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
>> >  1 file changed, 30 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
>> > new file mode 100644
>> > index 000000000000..e8168e5198d7
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
>> > @@ -0,0 +1,30 @@
>> > +sysfs interface for ACPI DPTF platform power driver
>> > +---------------------------------------------------
>>
>> The header isn't necessary.
>>
>> > +
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
>> > +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
>>
>> There should be one entry per attribute AFAICS.
>
> I grouped attributes by the date in which they were added for brevity, because
> otherwise fields like Date added, KernelVersion and Contact information are the
> same.
>
> I can split them up if it makes more sense...

That's what the format is from looking at the existing files.
