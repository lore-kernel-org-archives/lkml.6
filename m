Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx4/SylJtFcx4odlOoYMAQY0qjGTVXLCR3+koTI6zS7pUSIB1LSLL+taFQrRh7UI00S3AV67o
ARC-Seal: i=1; a=rsa-sha256; t=1524183639; cv=none;
        d=google.com; s=arc-20160816;
        b=1FhirvMe2FsLA/q6rLayoyvWOAPl+oQTpls4tF/KhYh7JLfFnxRVsXq9NGRDKG98tL
         j0D0FH6MpJ94HuKse/JqlPKOZM18uJbcpwuMDaLO8cAFYDujUkVdz8fbOpN50KSNoSBj
         LC4/ka8P41wY+THggAfvYiI++A9zvNNOsRQebbvnw1M62REjzGtliOfskxzJTnWsCxy+
         2B0btXMv+e2DBPwZmd5r/jWIX6YZHS9KE1agflCVzxg8gyyBeepSSz4PQ5HJv1LwKxRS
         68cUbPh/Ue1Xj5DlyPrr1LQ0/3sZaDVvkUWycWV+bDfsKvQNb7Y1EbX8VQvgPjanuuBF
         bEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8ouWxiRI4onRmA+/6/tgUbVb6fivBMRWp8zV7iBobeQ=;
        b=rtDkasvkH6/h9t9UpXrxUV5iwpu+xHP5zA4l6urjcSDnScX6HPSahmuU9i5nlS0HKX
         bWxMeJdPu9y9nKdFx43a1SFDhKJxP/zzCnMkryPh8X+IwOq7Xnqx48ESC9DWcF1WTNjn
         FNicaW7UYB70epQtXmnFtLSoI3NyiDRIgny8xE62YXRAmpxJzPuI+B62F8xIyYBY0T0Z
         Gm1wwEm96EPmAUU8IzxvKM02Lf90wQPt/CSIwf3Fi/AZEKlqiNo6+XpibZRspm5Fyc4s
         qcGTezsuSF9Y5YYOr7KeZJ4yTRReamedt8F9v8518Iv0T8RYajvrAaqkkgazJ4pU83ov
         w/iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qNMCeJxH;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qNMCeJxH;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 19 Apr 2018 17:20:30 -0700
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, mfuzzey@parkeon.com,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Torsten Duwe <duwe@suse.de>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] platform/x86: Rename silead_dmi to touchscreen_dmi
Message-ID: <20180420002030.GD11546@fury>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-4-hdegoede@redhat.com>
 <CAHp75Vdx0fJ0mmE1tSZjKEoHbRMubJpA8M1QYg1joKxMdLcVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdx0fJ0mmE1tSZjKEoHbRMubJpA8M1QYg1joKxMdLcVig@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199785704223061?=
X-GMAIL-MSGID: =?utf-8?q?1598222383892075565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 11:07:03AM +0300, Andy Shevchenko wrote:
> On Sun, Apr 8, 2018 at 8:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Not only silead touchscreens need some extra info not available in the
> > ACPI tables to work properly. X86 devices with a Chipone ICN8505 chip also
> > need some DMI based extra configuration.
> >
> > There is no reason to have separate dmi config code per touchscreen
> > controller vendor. This commit renames silead_dmi to a more generic
> > touchscreen_dmi name (and Kconfig option) in preparation of adding
> > info for tablets with an ICN8505 based touchscreen.
> >
> > Note there are no functional changes all code changes are limited to
> > removing references to silead where these are no longer applicable.
> >
> 
> I have no objections from my side, though consider the following:
> - I would like to be in sync with Darren on this
> - make oldconfig will be broken after your change for existing users
> - the usual pattern in kernel that we don't rename drivers; I guess
> here we are on the safe side b/c this driver is used standalone
> 
> Taking above into attention, and assuming it will go via some other tree,
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

This driver is all kinds of a special case, so no objection here either. :-)

-- 
Darren Hart
VMware Open Source Technology Center
