Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523979858; cv=none;
        d=google.com; s=arc-20160816;
        b=D48SH7uxAhkdONyV6QwcjkBubch7AtCvA8fUDhtRqzyZ/0jPhGrS5ZshoA6axdoK4Z
         L7X2+MQSlkkh/dxKnKXlmx9wcbph10OIGhCWSZasvTq2BDBqzE2U9WFu14VgC3NdbqQz
         DIR13ONNM+tPchK5lLR2Kptm5BPEwcXs0Qqg02lcQUBUOsR3WiBx8/GuA2BpTHAnOKDR
         sLCEvyxjE+4y15zVrYy/0NaumCqGgLrmYrevYuBsmeDEIi6Tbv2uSW76Nk+XFJ8/Jqs1
         myNMw4oR7qdkTPUJhFutrC4r6KGyZYB8rsa0ib+A6wCMsQTyQyMgPb7eOdu5gtmFYOTh
         CPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=Dwxsz9/5NtXC9Oq0VoWKv2HR3Zqra0fvlTmgtldNqcU=;
        b=0AsSqw916+TcTreBNO/PbAdyCn5vNrMUI8RSDHeGJ7Q0sykR5+iy8LRg1xPZt3w2gw
         HnkSvViXnhrNirQ5FS+M7jDxCzT8K/zrdHlsLV6y2qpMXRoZd33jMWa0egfu6jfMbl0G
         4lJx+AtLLBaHrbXxOyVKZ9DHZY9BD3vgldDQSQaqiIBcJL9Z+Eqh3b39H3/N+oZ8/881
         w0V5RhPT5bXYk6gHHlwO3Z0xjM3qdot7pz4+WfFrcj/1mPlqoBWBIEb+/Du1waiVN41Q
         CBWkT9lnuB9iLsmR7F59KR2ZVWzsOZ6f4PCd1VrbzHmBrc7wWL6I28IMSJkZ7N8spip4
         JBYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kTirosvR;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kTirosvR;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/BTvhBtTQiPbXHBarvGajyfUHrQeQHycEmjuAMKaSy4RdHtaJCHkRFgVtkAO/P2uTSbGCSNF9OlBPj1xDXt/A=
MIME-Version: 1.0
In-Reply-To: <20180417095642.qrtf3gpotxxsikle@um.fi.intel.com>
References: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org> <20180417095642.qrtf3gpotxxsikle@um.fi.intel.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 17 Apr 2018 09:44:17 -0600
Message-ID: <CANLsYkyfk4egLOV5kQMJEOm3tYpjj10Ab=Z1CyGVP0Z6=j1UoA@mail.gmail.com>
Subject: Re: [PATCH] coresight: Moving framework and drivers to SPDX identifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>,
	Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937409545454672?=
X-GMAIL-MSGID: =?utf-8?q?1598008703545476819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17 April 2018 at 03:56, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> On Mon, Apr 16, 2018 at 02:51:02PM -0600, Mathieu Poirier wrote:
>> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> This reminds me: there's drivers/hwtracing/stm/ftrace.c that I didn't
> convert during the previous round, do you want to do it or should I?

Thanks for pointing it out - I'll add it to this set.

>
> Thanks,
> --
> Alex
>
