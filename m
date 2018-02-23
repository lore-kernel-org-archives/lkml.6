Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224sSVojAfLJFpvFIp+XbolXlS1+uaWxTQ6C7JYyxEDAZssuBUlYVfeU4FyezVKMn39Cb6zX
ARC-Seal: i=1; a=rsa-sha256; t=1519399424; cv=none;
        d=google.com; s=arc-20160816;
        b=L9klW2R3fx/9awaS5roIAs5JewiLMY5dScL2E/TJae0u9/1npYQ529R/QePa0zhaqz
         iviQkQPFX/pMmzkr+sazRfQFmIvB4ICIJYiI9e1n1ljHoPU0SIjM7EcnqITSXtwNUHW4
         SxZLi0B98Toh1zSdotAFwCzpk5IRkxMdwqwaX1N1xA1VFMwwYp0iQ9IU3b80WkTt0Yj/
         Rkc3i+gvmKamA8OTM0BWz5TnwEDejaEcT77v4h75AlEfpaidqKxjWzT9bc7e1W2Pjk/5
         YCUu11KTDzmirMToWeDoTL14vJ1ZMqBYs/Cx45geT4XIy12Qk7Y8Gx3Gu0Hn7C+6kSlR
         arBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Vvb6wWFdaiUBz2HErYZB7ZiEQ/ThWi0v/695nzWzu9c=;
        b=Dy1B8jV+Mclu0yYtSilkSLuTOmF1Kl1R6YB2fhBuB2I4+WG0BinQb15HBB0jPy+uee
         oLD+0ocoM2m61krIbMwj1AvPA+hx6jBjeeNNIEBJVEQY3iRskRMPFuYv46+RrIKv/OCq
         uB++44zgihQWi3sJyyM8OtlhdbYOiKm3lISG7FGJe2vsNZ8YsjawYEUUHONvhUbytjYs
         yWk+WSBIKqrTLwQas1/RFuv2PZ/bH9n9xqroquQVSCtVESSYa3g52Po0BOxbYtYa+fMG
         fc5wuXf8mPcSgihz8IaJtvTxwSFgqX48MvjpPJI0RIBdIA3CQDTz/sZvOs/jA9NWXIiJ
         Y6Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:23:41 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej
 Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 0/3] backlight: document sysfs interfaces
Message-ID: <20180223082341.5f19f8d2@lwn.net>
In-Reply-To: <cover.1517902411.git.aishpant@gmail.com>
References: <cover.1517902411.git.aishpant@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591636371851497694?=
X-GMAIL-MSGID: =?utf-8?q?1593205770680070188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Feb 2018 13:08:41 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Patchset contains documentation of the sysfs interfaces for the
> following five backlight drivers-
> 1) lm3639
> 2) adp5520
> 3) adp8860
> 
> It was compiled from data sheets, reading code and git history logs. In v2 of
> the patches, documentation for lp8788 and lp855x devices was dropped as the
> attributes contained debug information.

I've applied the set to the docs tree, thanks.

jon
