Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525683962; cv=none;
        d=google.com; s=arc-20160816;
        b=L57c2f/tovUrCM9zf/5CRRuSWlu5Iw9AG2xi4OpjKZjK2ynPPvqo5fFcgd66yOV39W
         kAERUWqR4JO263YiZe8zYgkFFPDkqQ5LLHs2j1gdopz1wgTrHQJyGP8cBWNis2s0awcj
         uzzMmOm5cxwC+D8KNvxgGXiATnPLjqLuIN5joJT2hMUXOqXq7dFAuIN00041l4tT1Zy1
         7JjqiuJfsxl8OdxpBO4EPeR4jRNlD2mrUT1XkT9ql6oXl8J20fgdeQw8ahO3q8unfYP0
         wCJ5Vclm87qopHYQtfMhnO/5dEmso9SgtfpP9D65lFsHrefBoacYXuFV53bljjt1xtCv
         QRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=IPce/gs12OpBxT8yk+7c3ZU1c7Xi0hLOJJNt6SEOlOk=;
        b=g2sa+dYZgS5uCSek84Ix7tAkPR0J9lcKaoJZyIgyslYG2wOOmYXiMyQykve8Q8v+HX
         uQfs62Bpa6/X6tY145T9vIQp91uQDr3lxGjg/H2sdSe0LBzKzNsGzdMITBSz9A6hBofM
         jlVI/QiEDBYJMWbn544uOFv12lQmqZ4A0vJ6ZJT54L74v6h4KzZ7gowlnJck50RfJnbx
         aMF7+p4Fog1LwfOitXOuZJyGWpPzvTudd07UhcrJsqYrVqjJ/hOeAHGbfb8Gq7LkVTsT
         9RjH26QaTWc43lNH60hnu3VOaFfBV94K0KtE/ay0G7oCp4PSGEo7N88+acOF4iy8ZQQl
         tcRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JinwYXWW;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JinwYXWW;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrqrv1w/UQfynpoGU29gsRMQnHEqvQ/xQvgUzXsU1OwLejBHIo1cjc4T/REOiOUceQ7DSAX3w==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 11:06:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507090600.GP2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <CAL_JsqLMtqS3X_2WiPQVoNovQAVTuXGH+XbN30DA5_moca3Kpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLMtqS3X_2WiPQVoNovQAVTuXGH+XbN30DA5_moca3Kpw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599795586858915817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 08:16:11AM -0500, Rob Herring wrote:
> On Wed, May 2, 2018 at 3:16 AM, Johan Hovold <johan@kernel.org> wrote:
> > On Tue, May 01, 2018 at 09:05:42AM -0500, Rob Herring wrote:
> >> On Thu, Apr 26, 2018 at 4:10 AM, Johan Hovold <johan@kernel.org> wrote:
> >> > On Wed, Apr 25, 2018 at 01:16:58PM -0500, Rob Herring wrote:
> >> >> On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> >> >> > Add binding for u-blox GNSS receivers.

> >> >> > +Required Properties:
> >> >> > +
> >> >> > +- compatible   : Must be one of
> >> >> > +
> >> >> > +                       "u-blox,neo-8"
> >> >> > +                       "u-blox,neo-m8"
> >> >> > +
> >> >> > +- vcc-supply   : Main voltage regulator (VCC)
> >> >>
> >> >> What about V_BCKP?

> > ...my point was that in case there's no backup battery, you don't want
> > to enable vcc (via v_bckp) at probe (and instead have the device cold
> > boot whenever it's used).
> 
> Wouldn't that result in very long acquisition times? I guess I was
> thinking Vcc would be always on when running and V_bckp was just for
> suspend.

Yes, the acquisition times would certainly be longer, but for a GNSS
receiver which is rarely used that might still be preferred. And since
I'm using runtime pm to manage the supply, this policy decision can be
deferred to user space and controlled through the power/control
attribute.

> > Hence, the driver would need to check if the v_bckp-supply is identical
> > to vcc and not enable the former at probe in that case (i.e. similar to
> > if no v_bckp had been specified and we considered it optional).
> 
> I guess if that's the intended operation, then making it optional is fine.

Ok.

> >> > Take a look at the sirf binding; vendors use different names for their
> >> > timepulse pins and in that case I added the actual pin names (1PPS, TM)
> >> > in parenthesis after the description.
> >> >
> >> > Note that I mentioned "timepulse-gpios" in the generic binding with the
> >> > intent of trying to enforce a generic name for pins with such a
> >> > function (similarly for "enable-gpios", which I guess is already
> >> > established).
> >>
> >> Yes, I think that's good.
> >>
> >> Though with the enable-gpios I was debating the name for sirfstar a
> >> bit because it isn't the normal drive it active to enable, but rather
> >> a pulse to enable or disable.
> >
> > I had some concerns along those lines as well, and if you agree I'll
> > change the property name to on_off-gpios (or onoff-gpios) which matches
> > the vendor data sheets for this pin, and which I think would be better.
> 
> Okay, just add a vendor prefix. And note that using '_' is discouraged.

Ok, I'll name it "sirf,onoff-gpios".

Thanks,
Johan
