Return-Path: <timur@codeaurora.org>
X-Google-Smtp-Source: AH8x227HupwcGlAFwLPzVxRJ8kkC8pdlmGn9oxMPi0jA+bAMbz/yKl5B+ttaitf2rsMYnMCpfN2B
ARC-Seal: i=1; a=rsa-sha256; t=1518199309; cv=none;
        d=google.com; s=arc-20160816;
        b=xS/Ec9mk+ytxs6h1wky58E7uyqlf214YTzjZTzfVc6kCXikOIHqMRQuynst48xeIqn
         rs0rqooO8GPMkpejgw+9W1CL5wU23QTYcOhbYQpXoJGD4uFOOhe6L6DvmMU6BOgnTxq9
         FzigoYRrN+uVobZbhgqqeu5oBifjTBx4jcHIQLDHE+MF74rq8FUf1usXj2CnndFdoFXh
         oW3f6fC2Rw1/yHvyL/+JmArLmnCKDokESou3INQ8e5kbDbladuOXMZxavarLxOWEaY7E
         HOW7ibZ1bu7sR7TpTrpQ97nIJUuO9ZH+/LPvWjvaaNf1h4FdyyJZVzDVlErBJ04zFiuW
         utFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=QxkoSQrKMAt7v2a3UXeh8E1XopiduAqi/PlwPh2zYXE=;
        b=jJJhRA8QE6XIKzbMvhWZKZyk8uKv7oP26S5qZ4r+9a/vm+3tqsBGVotvWhskXOtSqv
         7hx/PULQlPHWU4DuI8I1G4vyNJybQ7e/7Ey0Yoimk2vv+6bNYI93amoxp7linMMiCmWy
         KXk7NPVYv1/FmG+P9kaUVFcTboOxMUnsIJecAFVJG+Ix7sO0tm8ewbXx28Bu1d/XcTSC
         jOkFmWBS6xuspesxeqQZH115Ozxift6D47HPgf9ZJiiKfZckOk4kpqms3gR8vDKUeEMx
         RBhnpHKZNzF17fzP1TiQqHMZVALbpYbX1xE/K5+1atdOd6O2UhqyV+PTywVQ/QrPCvXG
         Bb9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lP7hzXHv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YnPS2j7k;
       spf=pass (google.com: domain of timur@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=timur@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lP7hzXHv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YnPS2j7k;
       spf=pass (google.com: domain of timur@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=timur@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 551A860A54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
From: Timur Tabi <timur@codeaurora.org>
Date: Fri, 9 Feb 2018 12:01:45 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUqWbNT9uQfcVtau=FTzp61m6xiLpwwDF-8e=5bF2vonw@mail.gmail.com>
Message-ID: <CAOZdJXUqWbNT9uQfcVtau=FTzp61m6xiLpwwDF-8e=5bF2vonw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
	Guenter Roeck <linux@roeck-us.net>, shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931271366574701?=
X-GMAIL-MSGID: =?utf-8?q?1591947359351829355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 7:39 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.19 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Is it too late to add these two patches?

https://www.spinics.net/lists/arm-kernel/msg632667.html


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
