Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZr56o2c51Otndq9wzsH9lMOO4wur4Zn0oVGjlOtIs//B3EyOMETHG2qJN3sfWRIKqttVIsd
ARC-Seal: i=1; a=rsa-sha256; t=1525899347; cv=none;
        d=google.com; s=arc-20160816;
        b=p+6CiPzrCQhTk1dZyrUxLR80rythMBtpoW8oAHau0RIMvqlutL/I3MdRe5a+HikwUb
         4swW0szB5RZSwkM/CShmrY3K8epOU9+vdk62jTynbZ3UYQEczVCrSvdPAivKBIa8+JJn
         7hNXWBCrrFfdFLcBzArmsRY/yT90lGMbDcQVEOluDei0XLnEO54hORfSxY8vdBfshC3U
         xuCeSYLeurWG4JkSy1+HGYIhBYlRrJCEh+sL9Ec6Heb6ZjqqjZ5yHHGBa7aaqGeNDJcx
         tJ+Wkn6YxS9oWvFRL3jnnC9kUuk/WSf+tFW3s5pZE1SXcxlWgGXhM6WxPuLyi6aKfrfZ
         eXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nA7I74AvjB8DHn02QOzsCrVsCoQzW/lhjMhcFChBY6s=;
        b=xF7uoGu/KzH6DVTDcJVFYM4PpztN30oSh9lIYx9eSNvllWFGNFG01+7DvgTl29vWNY
         QPxK3H1jgg48fL+rEWRmpoNN4aPJsoDBHaxFybgEfJf8zccLJ6mOLkMHmA1E9EGtGUyV
         hpJXgPSHopU32lvYKuUVjqP8SznJ0E0P0uHTZssWuycHlPFql3G3LkbavzH3bX37lYPc
         S2sMyI8nT/x5qAX1Hl1peg1XbAyXdpKCblRCExLzhMStev5mW5/VpYgg4+6ZWFsXv3ag
         pH4VRTHXq28sXIPFEVj37cFoZdyuGL9wSaepUOo5m5JgXdjPFQbuUyaRsxLRIJRBVlll
         tG4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 20:55:44 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>, maco@android.com,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>, bjorn.andersson@linaro.org,
	teg@jklm.no, wagi@monom.org, Hans de Goede <hdegoede@redhat.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Jakub Kicinski <kubakici@wp.pl>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>,
	Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, jewalt@lgsinnovations.com, oneukum@suse.com,
	Bitterblue of Monsea <cantabile.desu@gmail.com>,
	Alexei Starovoitov <ast@fb.com>, hare <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, khc@pm.waw.pl,
	"David S. Miller" <davem@davemloft.net>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	tkjos@android.com, Jonathan Corbet <corbet@lwn.net>,
	mchehab+samsung@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] firmware_loader: enhance Kconfig documentation
 over FW_LOADER
Message-ID: <20180509205544.GW27853@wotan.suse.de>
References: <20180508181247.19431-1-mcgrof@kernel.org>
 <20180508181247.19431-6-mcgrof@kernel.org>
 <CAGXu5jJXMxx2Xna_M_g1wsS59XnYKqHAGdxhzDtk3PhnLL-gQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJXMxx2Xna_M_g1wsS59XnYKqHAGdxhzDtk3PhnLL-gQQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920594318435232?=
X-GMAIL-MSGID: =?utf-8?q?1600021434113413500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 03:42:33PM -0700, Kees Cook wrote:
> On Tue, May 8, 2018 at 11:12 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > +         This used to be the default firmware loading facility, and udev used
> > +         to listen for uvents to load firmware for the kernel. The firmware
> > +         loading facility functionality in udev has been removed, as such it
> > +         can no longer be relied upon as a fallback mechanism. Linux no longer
> > +         relies on or uses a fallback mechanism in userspace. If you need to
> > +         rely on one refer to the permissively licensed firmwared:
> 
> Typo: firmware

Thanks fixed all typos except this one, this one is meant to be firmwared as
that is the name of the project, the url is below.

> 
> > +
> > +         https://github.com/teg/firmwared

  Luis
