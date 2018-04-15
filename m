Return-Path: <msfjarvis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523805430; cv=none;
        d=google.com; s=arc-20160816;
        b=SS/vSGhICvHW+SYdUtLhpxhwev/6U/pTa5u2FZRX3H2hQyQLxZJJNGJg48IlrSxzgh
         SWrZetnzGFq1A4Oagl26d1JCJQ9L2Nsky4wrlb41gK74Pal5m3Il9aZRJAsVMEP0xz6H
         We7JMs7wGZctlibpMHcH+RdOIxqz8CfrXcm+JkR9RIDcRL0iQ1n4CpMMu5Vt1JfOyXNr
         /wV7H8HMSh9uzFqrp/x4sEiD18VGW2rBfgLt0cnY+ZhOvnQZKIccuSjR2LbwMryns5g8
         kyPSW22dq9gI3G7NgoMlxVWe4eD3RI/VtNvgToJ3qSATrLYcwWtqLemZGV3EN1yoIYCx
         9+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date:dkim-signature
         :arc-authentication-results;
        bh=/F3E6/XFIu8/FFJm7G60vVEyyZuE96fxrz8NlBG9a4A=;
        b=h2wYEw+M5Yt9bTFPjHuyx5/yyZto2wd4kCPfk+vVIDo8RatzUznMVAe1BVA3+uxr7o
         piZyidmVtDe81gEpMdFVvTO505goqefCAIDIVCfN+C60vs88CuA/8EaP2aanBWdskoEe
         qYl4YfcXj+qx7NdW/4fo02BA7PCUwb8mn+eTOtI1ko+CrvnzppFm4a9fG3AYElVvwQ3d
         3FiwFCuKFFQOSO7evyAQqXpSWEkdeQp+Kcb7aUqTBFq3EBWrDUmXjUoBJjdKrk1p966X
         +xk8jkALg8uWgfyChCN4VNdQAa9AxddKYY3EiY8OXC27lzOE7dvCDeKx7soSgRNLMRsx
         ko0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lKcNlJN2;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lKcNlJN2;
       spf=pass (google.com: domain of msfjarvis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msfjarvis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx484POS4kqW4DxFdSYS8w9zK43EA+DfcH1eghVR+nVQuPUT6tEHcQCRd9QpWHjzfyOL7P6vehw==
Date: Sun, 15 Apr 2018 20:46:59 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180413202459.GA23097@kroah.com>
References: <20180413202459.GA23097@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 3.18.105
To: Greg KH <gregkh@linuxfoundation.org>,linux-kernel@vger.kernel.org,Andrew Morton <akpm@linux-foundation.org>,torvalds@linux-foundation.org,stable@vger.kernel.org
CC: lwn@lwn.net,Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <4E2B0BED-E15D-45F0-A236-63B5FFFEDC68@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597825802837084223?=
X-GMAIL-MSGID: =?utf-8?q?1597825802837084223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 April 2018 1:54:59 AM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wro=
te:
>I'm announcing the release of the 3=2E18=2E105 kernel=2E
>
>All users of the 3=2E18 kernel series must upgrade=2E
>
>The updated 3=2E18=2Ey git tree can be found at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable=2E=
git
>linux-3=2E18=2Ey
>and can be browsed at the normal kernel=2Eorg git web browser:
>	http://git=2Ekernel=2Eorg/?p=3Dlinux/kernel/git/stable/linux-stable=2Egi=
t;a=3Dsummary
>
>thanks,
>
>greg k-h
Just realised I actually forgot to report back here after yesterday's test=
s, insomnia's a bitch=2E

Everything's hunky dory on the OnePlus3T, clean merge and no regressions n=
oticed over the past day=2E Thanks for your continued work on this!
--=20
Harsh Shandilya, PRJKT Development LLC
