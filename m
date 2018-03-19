Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521467660; cv=none;
        d=google.com; s=arc-20160816;
        b=REUCUL19b7RXAIdtVVOFxgZ0j9KRLW4pyMUpIMkI5VkiYLlAIBxLQkT9nWm2YHOgdn
         jXAGKjHTX8R51W40l+fpw0yytSxjZzyLZSkz0AxSjFDKuX3kKFMQJjmuvzLYCEy+ucuP
         c8KOh70l5WjrwQ5TDdmlEsTMsyXj9BxO6AM5IZuCfbg1MzoW82/ghj2YdeXvsRjai7ca
         +IKTZ6hUBnXkq32KWwsisRd2qhZXwb3mNtH1o2SQP5oeYy1YA9eY9MuF4BEO/Cr57liK
         87/+pBCCjdzzXszODT3sPhirrmS4ABNmXXGis6/ecybPZ6F9i4UAJla93AjL8jqGFbxZ
         quyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=a7IOpzZw6/7yEyXRAOTavwL8UN9+uNF0HfI5H3QZQgs=;
        b=zO78eM2/5mXdW6T2GWfsoxpuXs9atcx3GIHhG6ZAZSnUU8Aff0+l0qXwwbA0ToP8Pv
         NYEs9iHwNHXzw+r5/mmlu80xbth+e10bvgxpCTwbAKssVHflBRp8Cwb/aJNLoR0maXHv
         bKpMUxQseDsosRiUktc+gqJ9UGgaMC5RBkz4SIJBxqrJEYXmti1oHWI/YA0JV4QEQgqM
         HMzs8HmmwDRoyYUTTIiHVyErBJDIcS8ShwlkWdYqIE14HssBeUWJ6JbMB/+NebwvUICy
         Gbc8A9WbxDNws/Gyg/7R2SyWukXsuBM0XeUT8uQHG2Z9vI5caooU7S1l8dHYR7O2qzaH
         ndHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xxv4svnO;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Xxv4svnO;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AG47ELtptmgm4AHY6BpOjDUojTh2ytsImEwPfnlGxHlxxq31/fq/3hxSzyCDKGiE17qu7CMY+lTVQA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 19 Mar 2018 14:54:18 +0100
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@baylibre.com>,
	Thierry Reding <treding@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Message-ID: <20180319135418.GL18359@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
 <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1595374473677219424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 08:32:50AM +0100, H. Nikolaus Schaller wrote:
> Hi Johan,
> 
> > Am 27.02.2018 um 08:04 schrieb Johan Hovold <johan@kernel.org>:
> > 
> > On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
> >> Hi!
> >> 
> >>>> Let's restart this discussion and focus on the main roadblock (others
> >>>> are minor details which can be sorted out later).
> >>>> 
> >>>> If it feels like a hack, the key issue seems to me to be the choice of
> >>>> the API to present the GPS data to user space. Right?
> >>> 
> >>> Or even more fundamentally, does this belong in the kernel at all?
> >> 
> >> Yes, it does.
> 
> Thanks, Pavel for supporting our view.
> 
> > 
> > But not necessarily in its current form.
> 
> Is this a "yes after some code fixes"?

No, we need some kind of at least rudimentary gps framework even if we
allow for a raw (NMEA) interface for the time being (possibly
indefinitely).

> Pavel mentioned an example where such an evolutionary approach was taken.
> > 
> >>> Now, if we'd ever have a proper GPS framework that handled everything in
> >>> kernel space (i.e. no more gpsd) then we would be able to write kernel
> >>> drivers that also take care of PM. But perhaps that's unlikely to ever
> >>> be realised given the state of things (proprietary protocols, numerous
> >>> quirky implementations, etc).
> >> 
> >> That is what needs to happen.
> >> 
> >>> The kernel is probably not the place to be working around issues like
> >>> that, even if serdev at least allows for such hacks to be fairly
> >>> isolated in drivers (unlike some of the earlier proposals touching core
> >>> code).
> >> 
> >> Oh, kernel is indeed right place to provide hardware abstraction --
> >> and that includes bug workarounds.
> > 
> > Right, at least when such hacks can be confined to a driver and not be
> > spread all over the place.
> 
> It seems that you forgot that the driver we propose is not spread all over
> the place. It *is* confined to a single driver thanks to the serdev api.

I believe that's what I wrote above.

Johan
