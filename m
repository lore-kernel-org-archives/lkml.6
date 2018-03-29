Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AIpwx49uL03RKycwixnBlj36xj6G2gOEcXcq9mVuF2M1c3MTH/zqo8nQCU0z11Xo6oxVhuEBKCmT
ARC-Seal: i=1; a=rsa-sha256; t=1522360476; cv=none;
        d=google.com; s=arc-20160816;
        b=IGWU/Rdm8G6PVhywjaqUXKB3LEC6B1nUinWFvoAaFZHwDccGiI/YVOYQ8ZpSg4V6SH
         e51Pi46lj7Pn3DJT/pXjuzURto0OngFsiuRfzuc8gymdP3L6O0HHtoS8LVxUbrVGgOvA
         eWHc4n2nSFF92PTf5wUgWL2GkYwXEZkWQeRKgvnGHdhanBmaz1PMmEa+Gx83Xoc4HrVM
         O3ebAhKKKQG6ewizfzOhWcd0gjmCVdWnNeEIoTwYu1ASCJC1/J/qDRJs2sx5BqSz5ov/
         5409XFXS9M5b/tdD32X344bx++/A85j4eDR/uaVD76wNtpxPGHhrgwRRCDjfnVXAOZg9
         qxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=qbmuuB1ab72NBNBRMPjW9d+t19tOIMzsxw8lVaRunA0=;
        b=AAuAZo/DT3jS+h3YgauguGBcXPHItiSnhPMT4XWfzSaVDmgn9S/6Ye478mGoizlJEs
         3J27xlXeQr8LTgWrg1YuTVJhtZCYZHaQh+HpkqOgsawRu/VfByhpf2qLu+XVfFQUAzDl
         jGjY+5upMfapeR82vsow3N8lF+nxycqam4qjm+K/mKCFOAW+Mid6VHKSVjeGfPXG1vrI
         Fc6cRr4OWqnndaaxcgWt6WSHlWojEm0zD5tp09MtcQnF3wK9uidFzXaKw0ICLECOgS/D
         5u4rZ1eCfmz+tuDgBYCYicuKXGie+sWxB6kVAcEEgD1VwJeLP+LWzNW33MqWw11bkDRY
         P2Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Thu, 29 Mar 2018 23:54:55 +0200
Message-ID: <16373191.Y168Qu1tFx@aspire.rjw.lan>
In-Reply-To: <CADAEsF8j4yfuzDSfyO4VtqSP6rGY2r6L_AEn6MEhhhAUdo+7dA@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <CADAEsF8j4yfuzDSfyO4VtqSP6rGY2r6L_AEn6MEhhhAUdo+7dA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596310659299395677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, March 29, 2018 9:49:43 AM CEST Ganesh Mahendran wrote:
> ping.
> 
> 2018-03-05 16:47 GMT+08:00 Ganesh Mahendran <opensource.ganesh@gmail.com>:
> > single_open() interface requires that the whole output must
> > fit into a single buffer. This will lead to timeout when
> > system memory is not in a good situation.
> >
> > This patch use seq_open() to show wakeup stats. This method
> > need only one page, so timeout will not be observed.
> 
> We have resolved the watchdog timeout issue by this patch.
> Please help to review.

Sorry for the delay.

I'll have a look tomorrow if possible.

Thanks!
