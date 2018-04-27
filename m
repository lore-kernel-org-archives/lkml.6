Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZreuNGqja2/ZA3gB9rqqdEaLvMZfJJvDQx91E+G712dCKo76cbCSJeFAsQlLsRIUGKl525n
ARC-Seal: i=1; a=rsa-sha256; t=1524842891; cv=none;
        d=google.com; s=arc-20160816;
        b=ui1Qj1f8ocw2OcGa3JuYgLAKMeY55oaTCUERu2t+s4kRaeynSallg41CtlD4dgAfO4
         bn8MTWPFmx6sxzRoEvXin97IDgfbeVbYYaXTTjkVcm9QTEJwITPatKjwPdoAx8Rue+rn
         QEkTb26NvX3vsnB6RbiWT5ouYOuSW5SRaviRvObXkZF0LaQvfCmPudnoYeXANJtrcjKR
         A2XYQicTWr/apJv+rw+H9jH9YTLMHJ772DUYhoV0w6MvjPx9bKdKEaR5feEdwWG7pzTx
         nBSVL5V1mszmreZImnaOSmzL3/tn4Ao3SXjNaFE/urY6vRRjB8/4Zjgc0DAu5QEGQb7B
         Pg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=mXdYFwNMVngfuiPpu3NRyPUQn6h+smWYGqJ/VjZvK1w=;
        b=INVV3r/0rRdMwjcu3uNF6FbT4phQ+cnwKMaMi1ZsWRS4yQEYX2g9tsF8Xt3j5tukBs
         aLup7JROp7C5QbIgkPUDH7oMXPpjsTnPMoTnfkRFc2bJPfaH3DZfdHTiEHIeNV4Upf+I
         o1Nx5uxavpLCr3z9njjHdAXlv3UhJniDjKZO9ecASki2PnNDLmo8G+dyBNMtFDi1snXr
         21uTmCj4esXmMhXWwha0MdEb472pi25qCciP+jIB59wLFCVeK9tu1Z9a0nduyaK8Oef2
         CGTe6h+I62sPjETb0jXoY4XU95PnOAFFw52a5ONdq38cv2e5SIfkgIEhNVTPdK8mUCQ+
         12sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=BAZmO4HS;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=BAZmO4HS;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933232AbeD0P15 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 11:27:57 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45590 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbeD0P1y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 11:27:54 -0400
MIME-Version: 1.0
In-Reply-To: <CALAqxLWphJvPe=v2T2ksjHnQP1Vu7+gZernEgFVXcx5kB+efsQ@mail.gmail.com>
References: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
 <CALAqxLWphJvPe=v2T2ksjHnQP1Vu7+gZernEgFVXcx5kB+efsQ@mail.gmail.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 27 Apr 2018 20:57:53 +0530
Message-ID: <CAG=yYwmaVT5cEoi9s=YDs-OHNd6z6UScY+Ebos=cJ24ONG3U0Q@mail.gmail.com>
Subject: Re: possible BUG: selftest about raw_skew failed
To: John Stultz <john.stultz@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598913660394364751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I kind of ignored. i was not sure what that meant actually.

On Fri, Apr 27, 2018 at 3:03 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Sat, Apr 21, 2018 at 7:47 AM, Jeffrin Thalakkottoor
> <jeffrin@rajagiritech.edu.in> wrote:
>> hello,
>>
>> failure of a test in selftest:timers
>>
>> selftests: raw_skew
>> ========================================
>> WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
>> Estimating clock drift: 17.910(est) 16.820(act) [FAILED]
>
> So you're ignoring the warning above. If an ADJ_OFFSET operation is
> going on, ntpd (or something similar) is changing the clock, which
> will kill the estimated drift calculation.
>
> -john



-- 
software engineer
rajagiri school of engineering and technology
