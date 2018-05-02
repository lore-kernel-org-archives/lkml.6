Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525247832; cv=none;
        d=google.com; s=arc-20160816;
        b=xuLsND9elAYlRpLqEivd5qYrL76LkUCDigg2nyvLqdnzW0KDfA7FlORCoDeyO7jy6s
         LxByV2C+yoN16/AK2xJ9UNEMo1uRhKdNBaHXP6nCBZyzke94UJijdPV55rFaVmqA7eqw
         CGdBcYYd46KiooH02EnhLd2Jz50QJNidcEdzrteLmFL3PEDHF3z9UHVnQTIHGCAiDJZn
         uvvz3U/HK6tmXyhzQfxjxLpQjpKQMPsPbnDYm2s8LDSlKuM2PGsyG2ATQXZoYtpZc8OF
         Pif3KbXcMetsToE1uczjqYbl8UrGlSNkLKnyixDKCy/dg9/5c9/IfgKyX0PtdVlHm16W
         HATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=3EUqfYI/6GQD7RG00MqHxWO7tki882EYkRE91FONtdw=;
        b=ILbzINmb/cdu58IUTLIIBXQYH9X/UrdkdHTxaSwt0wakoC0xwRd8Mnrj5o8QsL54zE
         8X0lKf5/gnpqhJAzs4id3M3vPWNQ8z4DimbkNLM18ZuknFhttbOJUp0c1cekvtbNZtcf
         0Tabqzy4bsDndSR5Ea+7451YIg7Bg1JQw36+/C7ZnqAvColGPE8u+YELTM1jvSsL6zNE
         wRLl9Uga6fJBHGLPReEzVF5SINixfaUeuJIL8XGU8YR8ffcXbHuNPmF5VnFktl4CN1Yi
         ZJEaQ6R178pEMOPp3HFxdlTMIFrGokZ30nVSopXUL4GIVIRP4TQfrrjg+wryHdT2m5iT
         4j2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XJTHRqgE;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XJTHRqgE;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZooYCvQPyhlmf6tuW+pbrIrk+jMguwFEHhEk+LIn4QCNy60s+M7sRGE92qg02olN1/QcO4dig==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 2 May 2018 09:57:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] gnss: add GNSS receiver subsystem
Message-ID: <20180502075711.GD2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-2-johan@kernel.org>
 <20180425085649.GB13295@kroah.com>
 <20180425105645.GP4615@localhost>
 <20180425122315.GS4615@localhost>
 <20180429133511.GA28913@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429133511.GA28913@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062102212642?=
X-GMAIL-MSGID: =?utf-8?q?1599338271604813831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 03:35:11PM +0200, Greg Kroah-Hartman wrote:

> I'll wait for the next resend of this series to review it again and
> consider merging it.

Thanks, I'll send a v2 sometime next week.

Johan
