Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520494107; cv=none;
        d=google.com; s=arc-20160816;
        b=AAnLfoXt2f8ym41FYDMa+AfOU1R7gZG3rW4ahyxWtbmRNzBKBIuGXW/deSHJY2GuaW
         dSsbLUzEvyrO1FdBx69hqfvOjenWgk2/b+0NscwGVd3VwtZ3nLo0/2R1mPzoTCbyRO/Q
         53GT/SRQ88+XlzyzZJLYeDqrSPPBs37kMrCnbsq+jtIoFFyb/fzSzuAOx7NlTm3WPlpI
         1Uf+M29NUyuaXUBDqGlGNyLoVmes0QUD6HMfxQ10FHzs+DABbjom43MMOJicnV3BrTf+
         uXp4Z2WZ9MmF+Dgreyc9seNdHWWTlTlRNBc/zjXOhpgEtiE2C8Mi457O6HnnnYHqCK93
         1iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5jDiiH9GorAp0HU+DnCV6gxaIkl3BTcSna9mxl8C25Q=;
        b=JtZNT9K1/7zBBwnpkmTH9m0JNujGWXMhrl09aCnv4Nf8e62zLUHZ6uwMU6iThbjLZZ
         iUgHpAXVICUdsJTPFcOgp0/6bUCdHdiJTErgaAbh7oH1sOOjKsICUQIte4mBZI0AlNzG
         30XC5DI8iKb0EDQ2k1s6o72XKQUM7GX5o8PVlvrjhhvVWYNBooLk5NqJ3zGd7tnXl/hl
         M14rzfZpE877VGElB347A9tOAa0tZ3Ce3tNJOwaSkYjKxwfKPM5PN1fYOuqD2V7FI9Z6
         Crswn1a0h0VPOj6V7sqCzPjlmy8PFYb4jkMeDuqeYzF5vCLpYgTxZ1t7PV9JPNSZe3Vd
         Laxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a8aVYhNu;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a8aVYhNu;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsRr9VrFuN2yqWhGV89CEt1DJKduSZ5NVfUZVpaQ13zjkCpIjpAec5T0vlguVI7JHNFi7TxaA==
Date: Thu, 8 Mar 2018 12:58:19 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180308072819.GA24090@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
 <20180307205030.11fff428@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307205030.11fff428@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083230628240095?=
X-GMAIL-MSGID: =?utf-8?q?1594353629395146275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 08:50:30PM +0000, Jonathan Cameron wrote:
> On Mon,  5 Mar 2018 13:19:29 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Clarify the conversion and formation of resultant data in the
> > adis16201_read_raw() with sufficient comments.
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> This is fine but it needs to be in the original comment changing patch
> rather than removing the comments first then a few patches later putting
> back a different version.
> 
> So good change but in the wrong place in the series.  Learning to reorder
> a series and merge down multiple patches into one is very useful when
> working with git.

I will send v2 with all the updates!

What about sign_extend32 & reverse christmas ordering patch ? Will you
pick that up or shall I send them again ?

-- 
Thanks
Himanshu Jha
