Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqlijnPkBPsJbYWRHg2TZCnBcYwHoyKPPTM+ZaUgS3ylqWN8u/GyaAARIP867KYDEmZNqT2
ARC-Seal: i=1; a=rsa-sha256; t=1525801011; cv=none;
        d=google.com; s=arc-20160816;
        b=XSj8pSkybax0qa532qCIstjRy5BtnESb3M5p3PRBBE1x4aENilWd744vuS8JDZ/020
         eW1HybIBfw4T/tiFjY2aabXNB+4c5L/m4V8olDu0biyLbcoK63tg5T7RNMkZ6rcAg3Yc
         dB1NATSkvzj2clh2YiRnRjLyXfx4K0WP7tsuRMsw+O0HA2VLCvjr0vA3oquxxlXkutVD
         xpZnQEJ+G8spqWytbzxnZffZJ662NbKir5e3B1PWWcfd03jnMHEhAE8vi40Tt1msW6tn
         nJskfKxl0rBNFymtGk1ZIm0ZnHeIbD8LcG7vslVqm2cK4ZdDCYv51CCrd095gycfiv7W
         9Amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=J26bB0wEop0Mor7By8PUQ0ed0cg2lDCcc/GDQtkDvsU=;
        b=UIFJJveXSZ+F/xf+jfkmHwihcPMlfjZNWK1RKYa4maZTM5JJaC58x77bTz2yoQo7vH
         H6GJ2cpbcUPKosEGGxDVQ6c8IX0DwluArXZVB/81n6WPRKPeRZ/w9J11oeiWUkVduebl
         CQSH3/vn+ZbRK6N/p/3mIY0CRHbgR14tsF/cQ3+tfwA54i7HmeQtnPcxqe6DXgwSQdSp
         im4XCxLl4189sGyCmTW4J+XAwdBlWNQuHAn2CoKd/iwDJ9DeRa0LcJaPwS3RUu9SDVNq
         5lO3sElNxukNDxAbA2mUTv82o2ax5f2sycydrOev+w4PmtsHUFa0Lm9czMHzVueGIZ2f
         jfKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 17:36:49 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
	linux-can@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/18] Fix some build warnings/errors with Sphinx
Message-ID: <20180508173649.GH27853@wotan.suse.de>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <20180508101342.2bde20ea@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508101342.2bde20ea@lwn.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797475301602798?=
X-GMAIL-MSGID: =?utf-8?q?1599918321962988442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 10:13:42AM -0600, Jonathan Corbet wrote:
> On Mon,  7 May 2018 06:35:36 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > I decided to give a try with Sphinx last stable version
> > (1.17.4), and noticed several issues. The worse one was
> > with the networking book: a non-standard footnote there
> > with [*] instead of a number causes it to break PDF building.
> > 
> > So, I took some spare time to address some warnings all over
> > the tree, and moved a few text documents to a book. 
> 
> OK, I've applied the ones that seem to make sense for me to take now.
> There's comments on the firmware one, 

I'll fold in the fixes for the firmware API which do apply to my queue.

  Luis
