Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224b1+nx+SziF0EOF2sKRCo1NVxPnBzIuz4mGKB6gzfsNAHDqhm1TDHEq3I6UhyXT81v1omH
ARC-Seal: i=1; a=rsa-sha256; t=1519221959; cv=none;
        d=google.com; s=arc-20160816;
        b=unMeHM1W3UWOAYsK4t5tVGxf+5jLFCQcs/Aa2jF3DtJPY51ygKcepwbwqySfAiExhm
         P/rEp38ZUgaGbemt1oIFzWOrNa0kP+Bw7yLWFqs22eU1QHuXXTm2EfN/ozjUFVwQ9Bj3
         F+elloA+dMQZToFmK+6+8bE7eN9uC2Bqo+92ynbvJ/37IxgnuHC8+2uZZ5z+HDYCMFlq
         hlfr3IwmWb1VqXXPUEPn71eHE465GGd0/fmi6BekNwcFhgToHfbmmucCW2yOqV2njZcp
         4D5KhLkTgt/ex0yiiFOWBCSLJFFT54wYvPnsaYeEkgR5Q0G2jnMk1TW4X2sEfqwJ3Big
         /OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=OPnlJIYEv0GYSOUFJsjQH480KZXi8UvdM1pe77IkiSg=;
        b=dx7IR9aXv6xgIE2WyTR7YzBtVc9W1QVNkgJKnTU+XH9PMspTOhvY5TodFhr6mgIddj
         VwneuxjLrJATDgbUjYcWQEXKONteen4P4UaqaPpVmn2QZnYrNEBPZwbI4LLuFIRuswHN
         p6gEKgF5GGydZAb9BUXC6CB/O+U4BT6c4oNardwaa47I0zEXfYBTuELGjVXSYGbNjHpd
         cIHNl4fn3tJGJiyGbyevnEpN76RSiRhaA6t022asfULYXNoIlu2xO/QPtkm5GQ/8CByx
         faH5L/ogy6SWT/2Ke+GW7IGV6k+DGO+uc+oKR5nkyaW4kS2HwoL+3qLPgAOHHHkoELBt
         ISwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="36356858"
Message-ID: <1519221953.10722.38.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Mark Salyzyn
 <salyzyn@android.com>,  Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>,  Jonathan Corbet <corbet@lwn.net>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
 <thierry.reding@gmail.com>
Date: Wed, 21 Feb 2018 16:05:53 +0200
In-Reply-To: <1519221748.10722.34.camel@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
	 <CAMuHMdVwjP6cWM=Ku6KRVz9F8_n4OsgeK42UZa6BenKij4iu4Q@mail.gmail.com>
	 <1519221748.10722.34.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593019685088143268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> TBH, I don't see much consensus among developers on this topic.
> I wouldn't like to send a new version until it would be a consensus.

I would love to see the comments followed by an agreement from majority
of people who are in Cc list here.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
