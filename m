Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZo+9+qcZH3mun857aB0ZgdTmVt9Td8oPDhiYIiM96VP8+Ja9x9LVvzjDi4cFak4JhCCkt98
ARC-Seal: i=1; a=rsa-sha256; t=1526345686; cv=none;
        d=google.com; s=arc-20160816;
        b=NIzz1PCJkuBYEhLeDeBuunoPlUG0BDf8j/ma0s4tUZJj0MIChjGVRMYc3KXkeHTdZH
         DogCIlARiWCgQs74u6zfFnw80Fe3jve4UbJ94lWIMWaiWP//7Hcb8jDsHkiPx9cKVyTz
         wzRw3HDO6vLGAST8V9batcXDExRqxcK+Yi67S5pWIsP9yDEr5K3Ysd3WWxGx7djH3XB+
         AkE+ZP3CpFDeyH9SMbM8eRvvM3HvwBM5GSQoGW4zPh7uZ7XX9cv5C3KQKhFxmboVBi0G
         +VHuAGg5cKO59YhDNgLF1UTldIP5cfhTm3YwEfAoCGiAO99FFXp0Dz1yXawcq4IMrQKV
         DZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HtnpOHGJhCvwk3Uzw9yC5TvhlNzo6tFD7zK6M5T6dS0=;
        b=Xy5IzMgeQpNajQJTNXG/POvxmgSy5czX6n7BQ1tctrQp1XyTYCVT4M19JA5oKPTRtF
         uqp4OpmHQom2cR1Uq2F2Ii3XbWJNaiyoIe2kGotG1a1y8w/zWC9TqH5cZFN62aIITigl
         fKnjdnnNgmmgbMMDTL3LiJAaYr/Z9ZBcvH4uDFaKR+MIzM7VnCSj/hHOH+vaOWiCHlxR
         EJ/+NbbsSRRBl0OH+vjX/CWCU4DPULUJ92r4YX/utXpGpq3BrSW4AxmZBfrYvVAxeXpR
         OEr0XhD99xuzP0ZN8MTitPJGNws0cxB5PRBKpG6wC5hjUM8SsYx6rZbbYeL6T73/6YJN
         F7IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 14 May 2018 17:54:42 -0700
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kevin Hilman <khilman@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180515005442.GN98604@atomide.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
 <20180514151907.GK98604@atomide.com>
 <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798225940952926?=
X-GMAIL-MSGID: =?utf-8?q?1600489455110209392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Ulf Hansson <ulf.hansson@linaro.org> [180514 18:59]:
> On 14 May 2018 at 17:19, Tony Lindgren <tony@atomide.com> wrote:
> > Reverting for 8c123c14bbba ("driver core: Respect all error codes from
> > dev_pm_domain_attach()") fixes the issue for me.
> >
> > Sounds like something is missing, any ideas?
> 
> This should solve the problem:
> 
> https://patchwork.kernel.org/patch/10398597/

Thanks yeah that fixes it for me too.

Regards,

Tony
