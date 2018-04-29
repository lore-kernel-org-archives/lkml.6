Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZr9T7tmx5Qyarg/HbazOZKgdTOdBkKf8mhVjZHmSDiJTDhjz1V58NghrbDqujWT7alrfrGb
ARC-Seal: i=1; a=rsa-sha256; t=1524985397; cv=none;
        d=google.com; s=arc-20160816;
        b=Q84FVaV4BaVNmopQ5ci9SIuvIfamfeAyxOG0mSHG8G1zZNHlzchKdvTEwjUW1MO7Tr
         dx9uZUzx6vnpttaPv1D2XQlmIDhGL0Q4+L3BmnnBfh1CDhRJDqJkMqbY4KcdxhVq2tOY
         zh36YNKGZ9dx1J8UbEBEZsnN9csWRKodBe8drtMAb/VBwGixpDr1CmL5ww1aX+9IZHTK
         0p0GcgAKxZWItqSFIIQXt5xxuj4R0IbtYnoFg+J/zR9f3CUwKLgBVeJ/hll3TUyi5gBS
         U0Aj3cWF065KnyRcDxvkvM7EJa35yKgHCL3vME28Y1b+njkWf+kLJ2kqU1N9GaJtW9Ua
         9E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=m680imUln8F/Z18u0E5EBoIdxo82fvdZKIIq5QMawbk=;
        b=PwD9fbpWBOppVDjyxRD4Q5oi+cxCpVyG8Fm7tHw436PspUwt/MNtW/tDWS7ad53riy
         LC0rewHeDwzu8/pxHysxvQE9WJLxGIhqGLKvIlSRJmSDYxrgecWDJT2Hn3s0la6Hoehb
         PmNRKntBZdNc/31xhT2MxMwuePFxkKizfJ3mlvtbrx/oHitQx1fZrre+flt4j4qGGzrX
         lUEdmeZHV6o8lev5qmfWvY5NSo9pEcXKZG6+tC8bbMkD3HwkWi6jC8j+dxj3gU/pd2yk
         mnjFACzy7ReTHcBQv92/ORY2b1LlGclT3OqAmSF/IE2PyzYC8MU72ifYdhZwP0zOMtCC
         4Tpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sun, 29 Apr 2018 07:03:15 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	DOCUMENTATION <linux-doc@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Kate Stewart <kate@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Christoph Hellwig <hch@lst.de>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Rob Herring <rob.herring@linaro.org>, Jonas Oberg <jonas@fsfe.org>,
	Joe Perches <joe@perches.com>, linux-xfs@vger.kernel.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: LICENSES: Missing ISC text & possibly a category ("Not
 recommended" vs. "Preferred licenses")
Message-ID: <20180429070315.GC27875@wotan.suse.de>
References: <CACna6rz_Ms2Uv1P6E0gCGNsRwK4nm=PMAOaJ5Uk9aJxs2VSamQ@mail.gmail.com>
 <20180429052617.GC24294@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429052617.GC24294@kroah.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599026726440039181?=
X-GMAIL-MSGID: =?utf-8?q?1599063088452530930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 07:26:17AM +0200, Greg Kroah-Hartman wrote:
> I see it is only used in a very small number of dts files.  Why not just
> use BSD-2-Clause instead?  What do you find in ISC that is not available
> to you with just BSD?

ISC license is a simplified version of the BSD license due to the Berne
convention. It was also used for wireless drivers to help the BSD community in
particular OpenBSD who had picked that license for new contributions claimed
simplification of the BSD-2-Clause. Because of this reason many BSD communities
feel super comfortable with picking up kernel code in Linux under this license.

Granted, I'm on no longer a fan of promoting permissive licenses as it didn't
buy us cross-collaboration at all. We tried.

But it would be unfair to advice against a license unless a reason is stated in
favor of another BSD license. Why is the ISC license worse than the
BSD-2-Clause?

  Luis
