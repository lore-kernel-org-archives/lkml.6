Return-Path: <changbin.du@intel.com>
X-Google-Smtp-Source: AIpwx4+BMkCz4KziydCWCpZ5UnkfUlIQwdvG5mqWAXIry+W4u2eAWpqcjFRzYcKU8/mQFh6H8jeL
ARC-Seal: i=1; a=rsa-sha256; t=1523172113; cv=none;
        d=google.com; s=arc-20160816;
        b=cIzic0qdgTcEPj3/XzQ4e1k/+4s/WlUgeHoj1VBq1DWZPKOPPCNU3e0B1GUDL5xNFA
         K7y+QxuBy8iyQ3qbhI9sb67Xv6IPpW1gIMa0b/iGbbCJeHyTCYavQDvEp1Di7HZcMUI7
         YrtUCzBH/y4yzgkMbhH2TGiV3ADEeWbdO4O672cP9LObNHzpl3B6FBqsIEcmwISlJt/r
         ffxZAJA6ak6opniemgdS/2vBEkcS8TBHsv/dFO5vgOa4IW3hvVc+zaJ2TFXVi+nx9ZKn
         FIL+Re7ce/lUSWeXVGMzTP+RGFMPtfYAfeHspj4jewcCEhGt9EfVJ5UEGteTypaKEpQU
         2J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=W8koSEyf42GqGPPj1kJ1mBm0KPJLt/3kmK8CoAKF6fQ=;
        b=CF8ff8KLkDfdhoa+gT45ypK+fgDwCMPr6wRVOR7Qdkg4YtpljVkcaudxljny7+M34F
         Z3KdIslVRpOTBDb7n/3Cu0deZfT9Eb2sfN5a2C/ne/4uWBFN0BM2zPEFov6GcE04R5rV
         rvrJW38+6SrV03fYgaTqqea+i47mWzdr3lGRM+EOe1QaknQ48+964xTQcNtIOeXu1RX5
         XF1xW/aGqfQ9ToYWPrbxPWj7DBY1toUnONa0SetEMkfADOKDk7XDqhhTetBjxY9oJ2/S
         ctzQJp1wTUoZMRndfglwxIVdDsu0aE6kn6tqnsmZsydW6Ca5SJgB+jP8Qos8HNUq81pW
         YrdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of changbin.du@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=changbin.du@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of changbin.du@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=changbin.du@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,422,1517904000";
   d="scan'208";a="44377799"
Date: Sun, 8 Apr 2018 15:12:19 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: changbin.du@intel.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix reST markup error in
 driver-api/usb/typec.rst
Message-ID: <20180408071218.c2hlv3lgmokclj6a@intel.com>
References: <1523155632-10301-1-git-send-email-changbin.du@intel.com>
 <20180408071958.GA7723@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408071958.GA7723@kroah.com>
User-Agent: NeoMutt/20180323-6-5ca392
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597145050022316515?=
X-GMAIL-MSGID: =?utf-8?q?1597161722400241509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 09:19:58AM +0200, Greg KH wrote:
> On Sun, Apr 08, 2018 at 10:47:12AM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > There is an format error in driver-api/usb/typec.rst that breaks sphinx
> > docs building.
> > 
> > reST markup error:
> > /home/changbin/work/linux/Documentation/driver-api/usb/typec.rst:215: (SEVERE/4) Unexpected section title or transition.
> > 
> > ------------------------
> > Documentation/Makefile:68: recipe for target 'htmldocs' failed
> > make[1]: *** [htmldocs] Error 1
> > Makefile:1527: recipe for target 'htmldocs' failed
> > make: *** [htmldocs] Error 2
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  Documentation/driver-api/usb/typec.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks, someone else already sent this, sorry.  I'll be sending it
> onward after 4.17-rc1 is out.
>
No problem. Thanks for your quick checking!

> greg k-h

-- 
Thanks,
Changbin Du
