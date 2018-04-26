Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AIpwx4/HTSP70ribZS1NhlvlY72VkvAAeAyLiGJrRJgrBEQHNTy4yxihdub9kBGihzJII7W1RdWt
ARC-Seal: i=1; a=rsa-sha256; t=1524734516; cv=none;
        d=google.com; s=arc-20160816;
        b=C5DX522XSb/CblrFnZweGmsHcVMrUXH6Vdxuym5thDhr1nKQtrsAGNJYf9uxH8r1jG
         IDJcmwLUKqq6qwvw257oizauGkM4mOdxWOwOshR6zjHclwvDi/Y1Gka+ABHMnfUCx3h+
         bOd2mxaZoDMZVaat34tWzu8XRg6gCkeaDEaa9HkP+mM+PtU5mnaGAW36ulBKcmJgHGfn
         clBSupfNv3ZtBRhaNrvb/dqDqACfCcor/VYhBkRIQ3gY8rzgcZv6Yc1cMxR6/mQr1kBa
         P//YcxzRQ4yuC3+Ynq7cZL1IwyEe0INoaJfnvHsS9EYyxeSbi+udYA3q23ToAviTgn+d
         sn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kvGoivuRAH51+e435uSApdynkxdqqraxx7Tht/MOlns=;
        b=V8uzEAjE0nXhkykdOxXhR2e9tpIROct29Jwk8/cFfzbpbr2rtg8GlQf6rlWAqCbuF6
         ae20UWWRRJnpkfTaq2vkm3Sy7/sKCaIA1LqQEvlLXSOEVQYCQzj2Sb+vxvf6KJCThwMM
         sLY4CQSlSBZn0BuP+EdlgfddXCn6nmF1pQnRYq/W72ZhEuzPh2zIfWRTYKqa2MwDOEgH
         L879vHB7TR79DKlG/xeGgp1haXwxkWMw8EyXEVFmq78NE1NoMFQGbaT7Yuwq729vrh5U
         hBnXtn0UapXNVV5cHIlZnGBwtpvZt++kXHcRHe97hJFOTuwBH40yl32CsabWfHkY8C0c
         t6hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="37181013"
Date: Thu, 26 Apr 2018 14:56:32 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] soundwire: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180426092632.GU6014@localhost>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798230564470166?=
X-GMAIL-MSGID: =?utf-8?q?1598800020072065468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:53:09AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
