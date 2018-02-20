Return-Path: <ivid.suvarna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519134565; cv=none;
        d=google.com; s=arc-20160816;
        b=ZQHu7OgdZ0gjnoVTEGmo+10d03TVDzkcurO5iF7JsDbYx7s6UmDyYmK/EdEOHU9OuG
         A2cou03xCkYPguf6nmyUQTMEJb/XmwRbD/Pp9Hg3cwnsmlwLcQ2x+R9VjxgjW2gS64g4
         AK1df9OsFhjuhTD7gayIClt6t0+hK8fY/iIy013uPD1mpvxjbB+2QuSXfPP8Nzmf0cnM
         N2Vl3UO91nc/sZuDpLJQtgEbc2grFWNxAdDQYw+1viIdiJKsAS6DNVSiUDkebfA9uCW1
         PQ9nOv+7OAncrq6ymCSI54AClely/xK5+Ity095g2kMPPg9YTDe0KeuBEo85eaJeKIpE
         SDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JDo/Ag99wzjwbldRng8QSKZPogS0ranC5mwi/71zUss=;
        b=KlogHZ7g7SLwiaV9EOSCnoWZ7uds0QN5afTdJzQGG+NEw04n0Xa7YJMx/SAn+1TeeR
         p87x2KnLll/HZZ65mesoIMbHAZL9KZA50TCxNU5adDX5K0/44vEYA+goB1OLrE6kfUfM
         wpBOXwG6PXU8k4kMOXM6DMYWHaEjjRHwb7AeAz4oxHwbkZWBPrfuRDfav++29zIayxd/
         CMM84M3i9NL1oM8OkjQmZu4Z3JsuGAOAdNPEVjcGpJjCRxMBtyHBpqu70T2tb5xLcn0+
         lBbxq1QyDbfKUtACQN5yq711UJ+6SZcFbbRRMTtHmb2fO/2ppXpiIFr+DxnzzCSj3SeS
         xoNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DamHlBhr;
       spf=pass (google.com: domain of ivid.suvarna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ivid.suvarna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DamHlBhr;
       spf=pass (google.com: domain of ivid.suvarna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ivid.suvarna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227+6agfDdsk+gIvr/IY+M7f8BXhN1aMtZO5DRlfLcpU3ukHNrd5jDuinJMPIMNo1x7hVM4/JTPEiTe/+7ckS9Y=
MIME-Version: 1.0
In-Reply-To: <20180220075425.GA13048@kroah.com>
References: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
 <20180220075425.GA13048@kroah.com>
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Tue, 20 Feb 2018 19:19:24 +0530
Message-ID: <CABXF_AD74A8SmXGA5T9ODbC4JnDuxQN9n8N_9RZrm8a7CtjXQQ@mail.gmail.com>
Subject: Re: Timekeeping warning during resume from suspend to disk
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org,
	Linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592928046517690959?=
X-GMAIL-MSGID: =?utf-8?q?1592928046517690959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

> 4.1.15 is a kernel that is very old and obsolete (released almost 3
> years ago, and tens of thousands of changes old.)  Please try something
> newer and more modern like 4.15.  If the issue is still there, the
> community will be glad to help you out.
>
> If you are stuck at that old kernel version for some odd reason, please
> get support from the company that is forcing you to use it.

Thank u for your kind suggestions.
I just tested with 4.14 kernel on same board and am still facing the same issue.
Is there anything I can look into for debugging this issue?

Thanks,
IVID
