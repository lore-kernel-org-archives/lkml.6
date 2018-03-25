Return-Path: <Valentin.Vidic@carnet.hr>
X-Google-Smtp-Source: AG47ELuex7NljPrzmLOYOTpcmu2lw7vCL0v2oya1dOTM9aHGimFWye2RlhaAgqRLhoUx6NbqAT1E
ARC-Seal: i=1; a=rsa-sha256; t=1521983389; cv=none;
        d=google.com; s=arc-20160816;
        b=EOwC2qhwz2dhMYR5tq3myWCy1/tOJUU1VxPtmJECJ/FRaGrxf+1Be34YTX399WnSy0
         NmH/2B5nItPfZ5EegcjO9oOZ4c+Y+HgvoPN4pPfYqAQG1m1eU76QRez2AYnkoJ6TH2dP
         04b6E0VsqVNO754gP0xI70EWcbPWcrfL11LoJ1nqOfBzUUhOE2/9eWJ4VmGMlD2z1nhl
         R8KOemy8b8KA+ThYy0xeyoXSX96Z9JlFbxWDPuBubpUIZjbRniTMe7xZQxNxr/321EZE
         ctQ1iAZAezNlrqoIvK+eBtDrmnN0f3H9A7Kou2R+UB3bY1NsOIcuPiJSkGSRhwwGp7SK
         OZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:cc:to:from:date:arc-authentication-results;
        bh=lsoxBq2aHif+Y3xkKmsD2j22kREHC7zTTOV2yPBNTEI=;
        b=w08+x6edmAw2d1NP00ZiMDtQSgxI7De7S3WVNQU/21ISJd/bErdDvVJ+cJAfB+rwqJ
         zsyIGJFJk5Giom9a4OatlAGdywrLILjHR6qMbnhPKOqNigcCCHpg/Sr0+gaNUxrFE4Xv
         XtzvEubTzrYKSAhFtY9kj6rDOuJfKxUfuxD9YKIUvxX32OGhQr/mx02aIOEyDFXbL8ND
         g1C2cQiD8t/cliAPPDLm33Xyz8Hh7qclz4m7at+JVIjThx5njm0faqG/hGhaSYldfsmF
         bsbaKbOtWqgoZ+E0kjapbxxGTJ8eW/64YYmFVL4PbrvMS5dB9NLni/XxnaVk0Frr25er
         TDtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valentin.vidic@carnet.hr designates 2001:b68:ff:2::6 as permitted sender) smtp.mailfrom=Valentin.Vidic@carnet.hr
Date: Sun, 25 Mar 2018 15:09:44 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
	Marcus Wolf <linux@Wolf-Entwicklungen.de>,
	Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>,
	Marcin Ciupak <marcin.s.ciupak@gmail.com>,
	Michael Panzlaff <michael.panzlaff@fau.de>,
	Derek Robson <robsonde@gmail.com>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Message-ID: <20180325130944.GU31333@gavran.carpriv.carnet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1595915254608123036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 25, 2018 at 03:00:09PM +0200, Marcus Wolf wrote:
> Unfortunaly I can't find the time to have a closer look on the code this
> weekend - still busy with tax stuff :-(
> 
> Idea sounds great. I'll try to look at the code and think about it
> during Easter hollidays.

No problem, there is no hurry. But please do test the patch I sent yesterday:

  [PATCH] staging: pi433: cleanup tx_fifo locking

As I don't have the hardware this is just compile tested now :)

-- 
Valentin
