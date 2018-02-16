Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x226gkUvEUNK61NntHyyNXYAjOudN8QXCHqg0AwM4FpsVs3NcM92Ok0nCFfP9Mpolnup/Tgrc
ARC-Seal: i=1; a=rsa-sha256; t=1518799580; cv=none;
        d=google.com; s=arc-20160816;
        b=yJ68KpjNPm+SplLUadm0zFQp1mHh+4Y1rLPgCkFCb1io3xLNUETlf6KSEewZHXANV8
         oOUbX4HXzbVlekwD8rbV4h1RC5JKKdKa2GqEDyic7A7k9yB1p5AdskP8z9Z69pcuy0rp
         1+hZUeiYAJ2povcg17WeCl6Hs1ojywSnGc2KT+foX9MOV9+WIePq7ZIuPIkj8MIh8Lja
         u+dp/4NG6uy3WqDZx5178Vbb+Ssby6hWqm+MRKMQv1PljrwTRzNbeYJxDQVaV2QD6dhx
         ORgVRElPBTjEQ9ih/GerpFyeNLY1oa1uTH0SvgMU6Pd+B9dgdkkvIjq2Vux2YDKHSe97
         GNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=A3IvSx5ZhFJNFVDdvtNRIOpaQdUSx7tE4qxOv1E/WfA=;
        b=bM7JGnpiMHPy/3UnqN5u1VHwNkJUsFVxUx/C1kohTrUGPzn/Dfu1URRRvgqwT9ZxYI
         iuFKXqYf1XEZJwekfx9mlPsTMIoqmfqlOb/XTGWKFIsQDWj1l3bpTcb/RQJI5NSxQpiv
         dB3i9lfdpLXoTl9XGzpss1MhDm0Y8DXylaSAf1rkudj747zYZc93HukmfABmiXIeHb3C
         YjGojplu3D+7155hvSSI//TQCMGo5udpzblvH2Do9Ba6i1wGTdGWpWETcd/VjYZL8xsk
         0IhfxlQt7DpHVONaHeFiyJU2wxn9YAPazTsTEBntvKvZY4G+/6Pyvef9pVqI+6Ws2czn
         E7OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.104 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.104 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:4250:4321:5007:6119:7903:10004:10400:10848:11232:11473:11658:11914:12043:12438:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:21080:21212:21611:21627:30012:30054:30062:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: soap60_5418a958cda3b
X-Filterd-Recvd-Size: 1712
Message-ID: <1518799576.13169.10.camel@perches.com>
Subject: Re: [PATCH] Staging: wlan-ng: Fix Alignment should match open
 paranthesis in prism2mgmt.c
From: Joe Perches <joe@perches.com>
To: Greg KH <gregkh@linuxfoundation.org>, Yash Omer <yashomer0007@gmail.com>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Date: Fri, 16 Feb 2018 08:46:16 -0800
In-Reply-To: <20180216143606.GA28713@kroah.com>
References: <20180215184836.14897-1-yashomer0007@gmail.com>
	 <20180216143606.GA28713@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592493897702519482?=
X-GMAIL-MSGID: =?utf-8?q?1592576788823634311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-16 at 15:36 +0100, Greg KH wrote:
> On Fri, Feb 16, 2018 at 12:18:36AM +0530, Yash Omer wrote:
> > This is patch fixes up a matching paranthesis alignment issue found by checkpatch.pl script.
[]
> > diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
[]
> > @@ -264,8 +264,8 @@ int prism2mgmt_scan(struct wlandevice *wlandev, void *msgp)
> >  			goto exit;
> >  		}
> >  		/* ibss options */
> > -		result = hfa384x_drvr_setconfig16(hw,
> > -					HFA384x_RID_CREATEIBSS,
> > +		result = hfa384x_drvr_setconfig16
> > +					(hw, HFA384x_RID_CREATEIBSS,
> 
> The original code is just fine, why is checkpatch complaining about
> this?

lack of argument alignment to parentheses.

Maybe wlan-ng should be marked obsolete in MAINTAINERS.
