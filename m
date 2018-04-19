Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524136377; cv=none;
        d=google.com; s=arc-20160816;
        b=XLpWmR4oVJF7gHa/TI8LsQeNm5ZSnQ2DJ2DcYE4+yXWSG4GNp7RUasNRDFIgkUKQKq
         TAzGEZs6Ig67x8yrZNwM2EfbMvm/+WpHRM274xAyFBARc69P924p2+dfg36uSZcsk93t
         gLkUcdCr1AXOJyi2LBRs9G05/NlliNxYtj+yqzl7Wdnf4O/f9bDZa9Rz9VvJh9IFji1Y
         Tfhh/PAtNWUTNDEUOfKuIMT7pOREAv3dJTsaEpUc2JI3RlW4U152v9WdwpaY5cfkM7Sq
         mt9CaN54/ZBiDJg8zM4S7YZ7XqolOsLw0QsnEje0Mh4Xd7EYZlHVvOCsnouJKH4KSnn2
         JfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LTzZcKyWflN2pkwUsqmkL54ABeVjDxOTdQ9a99ciwT0=;
        b=WIWKTImE/1xKM4T5EZiyS7jYafzY7Jjj3I7egjw9yP3EJWZAouAvHzL+s6vBo7ZLV2
         DewZjyWWdQGodB3uWewAs17Dd+obCSuNRkAZejbjMLHOMoER/1c8v3Qw2D7LPvgDCycJ
         W2M+8Iss7ONZEP3KZqtVAZj7006SHM4FJV8RGf0J++bcT2LmGZcEIuBjM/J9m7DMl9Fh
         Wum+5INDZH+V646QFi+Lmd37++OYMIn1JG3KFWDa94Lj00A14EvEwvy/j1nd8JT3Aqil
         Mx9jwJyGzstlhk8SbpdSha03CfHZFDo1c92PdzqqAgY9Vx46WpRal/Y6ebu2qp3WHzAl
         4u8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iHJbBY8H;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iHJbBY8H;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrB5aiExaiyRuoi/Ve0DjQXogc3tcncRLOel3xE1Es2OaCdZGL/HvH3Odt5+a6M84425omx5V6c7qW38vqFUrc=
MIME-Version: 1.0
In-Reply-To: <20180419075608.GA4230@kroah.com>
References: <20180417155645.868055442@linuxfoundation.org> <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 19 Apr 2018 16:42:56 +0530
Message-ID: <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598010284891206038?=
X-GMAIL-MSGID: =?utf-8?q?1598172826379617010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>
> Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> gets figured out.

After reverting this patch, network started works on arm32 x15 device.
d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")

- Naresh

>
> thanks,
>
> greg k-h
