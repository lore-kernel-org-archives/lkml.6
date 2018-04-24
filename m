Return-Path: <BATV+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/Z0IKInPUBvVnXNpFPU6vu1X4pKFdguGT9U4pthpjtZ03IUMNcES6VX7Ymt+eLgNmYfO5f
ARC-Seal: i=1; a=rsa-sha256; t=1524576483; cv=none;
        d=google.com; s=arc-20160816;
        b=GR+1qo/1pjLFs4rqN/jtrtsmYOe7nOJMS9O0uCM1M/v/aEx5uLGpzZcdhhD2Sat5Q6
         eXT3Y/ofaBqs7OyHXBeTqzzsSImlq+tqUEHoie04vDlGk5wBvd8qYcZMFav4R6YI9Vfy
         ukFneHC2YP5dLidEYIzVMpWO0VINnUw14bcCJnLhJA2jIosgIkpktpnaLSC/LO41H0AH
         S69bWrf67QJGG8IJbLZumOqd5mVRKClR/9aWDmrlAL6H/qVTiVuep+5P5lgfnUwqFumE
         T8CVBMOLB/it0DeBIphPVLRE3Qa/DS/LFpdERRP3xdncfJzi98w9LxAtgwPLjk2vJJHm
         qWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=hpd6SRHvYJ8pHDMb3vsFCBsPlUAJt4vnYkzCqJG5PZ4=;
        b=uMhRFHI90Ur/xoWh+X1uv6aqYv1pjhyACArXJ6C8eViVJ7ZJy4VfbDIspFmaro08BY
         5qwCwIN7/XFz0cXXr7TxFca05QRTp8q7ZwiI9nWa0qjE0KQ7BJYXL3yTQMgjqNwMunD0
         zRVdO9oaH1LqyWKpxjx2RLLT/YzZDzdx4lo4qaYstT8YOSEg+edpvThkWty8IopdQ+e6
         RRENoaDfXG7QUhMCrxMdDk21hE/tF3DDOBkxZRhc43alDnuCdHKSbOJokSYVG6jMHnLa
         fmEXkPcaYOZkDygYNOa//MDrSZmLuv4fkLLpuASVGW5hHadXGko90KpHove2ixbkMc+G
         aapQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=MclbGqkY;
       spf=pass (google.com: best guess record for domain of batv+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=MclbGqkY;
       spf=pass (google.com: best guess record for domain of batv+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+433ba6cfe36175bf6d33+5357+infradead.org+hch@bombadil.srs.infradead.org
Date: Tue, 24 Apr 2018 06:27:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnaud Patard <arnaud.patard@rtp-net.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [patch 3/9] ARM: S3C24XX: Fix invalid SPDX identifier
Message-ID: <20180424132759.GA31133@infradead.org>
References: <20180422220208.772527041@linutronix.de>
 <20180422220832.982315239@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422220832.982315239@linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486099682318202?=
X-GMAIL-MSGID: =?utf-8?q?1598634310150527031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02:11AM +0200, Thomas Gleixner wrote:
> GPL-1.0 is not part of the valid identifier list and as its meaning is GPL
> version 1.0 only this would be incompatible with the kernel license.
> 
> As this code was included into the kernel, assume its GPL-1.0+
> 
> Fixes: 84b2170109e4 ("ARM: S3C24XX: Add SPDX license identifiers")

Before that commit the file just said GNU General Public License and
referred to the COPYING file.  Which to me suggests it is at best
GPL-2.0+ if not GPL-2.0.

Hopefully the original author can still be reached to clear this up.
