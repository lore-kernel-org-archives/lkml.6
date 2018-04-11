Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523447571; cv=none;
        d=google.com; s=arc-20160816;
        b=RxJ8zo+NxSGfCPWSpVgQTMFwEdv+7OlpwXJ03MGLKm5Vq+Bb7X/x8Mei95W8AClYa1
         jeU37UmSPJm38RxWt8yEvNmz+8U+kCL/t59IcBYXiZr4IwJZ1tdyXwrJIHaNfhchQtMg
         mk/NedzBu0nsYTbAy9cu1uXb61KgVr3eMza0DjxNUVsYqzXDFYBdrQky7LwFOSa1M3xy
         9uF7I8xcw3kFjJpJzCrCJDHP1JdUZKtQEZ3qP/VUB4xRLDCkYXX5YZH53zW/18zBkhuP
         dRrXX1HGzwQ4kDtLNbIpqwwXcKsXHxAZVI/xEcSV/5GDLAcTSXwqVMAsb2h53b6jj4lx
         sOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=S0BSRykHaPpL7ZImptP9LRwCTl6+uoOzn7Kd14K2rq4=;
        b=zLs/XpjySl0sKfC1pv4ZxyoumbQXap86Cr5RroKF3RQw81JtgwJWF9VeYbrkk6d264
         SqqgpevcSDwsXdD2MdeZPJoMF0d+eUaTIGA6qaQmlC7rEb+kpVFQ72F8UMi2FwHVcAsX
         PJatZ12U+0AU9Cx8ZQaaGK0x98mFh249FJGXptLfxo7FSwFJuRfmjBTS4b15EHh4F99n
         lJgAoOp10USCv129dbBbTmxfLb6qmw4zm7MrEtoDULpIBzpAqDD68WAyMknuFCzmrsXd
         OkLJmvbfiS3Wkf5Kkx4wT2p4oRB57vWsYbr10EqLfKleUkBMeOo1jjnvl+rBeI2ob3+q
         dg6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UijEdOll;
       dkim=pass header.i=@jms.id.au header.s=google header.b=Y6a/mC6G;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UijEdOll;
       dkim=pass header.i=@jms.id.au header.s=google header.b=Y6a/mC6G;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AIpwx4+CEbXT5ARkZBDIWS1I9TrjyR5qyCB2d2eNgUsfOJ56oHM/RNIs0DHoLoR5nMFhcdIpdKaZiPCldcc6Dsr0rpg=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180410183212.16787-6-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com> <20180410183212.16787-6-jae.hyun.yoo@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 21:22:30 +0930
X-Google-Sender-Auth: 9w3a5uKeB_4X891o5gliPk2JfvU
Message-ID: <CACPK8Xf7ta43K=POx8J6bAdjvX=wCzy-+HWqHsm+RstQxeetCQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: peci: Add PECI node
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>, Jean Delvare <jdelvare@suse.com>,
	Julia Cartwright <juliac@eso.teric.us>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, linux-hwmon@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135685935687?=
X-GMAIL-MSGID: =?utf-8?q?1597450560253577797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds PECI bus/adapter node of AST24xx/AST25xx into
> aspeed-g4 and aspeed-g5.
>

The patches to the device trees get merged by the ASPEED maintainer
(me). Once you have the bindings reviewed you can send the patches to
me and the linux-aspeed list (I've got a pending patch to maintainers
that will ensure get_maintainers.pl does the right thing as far as
email addresses go).

I'd suggest dropping it from your series and re-sending once the
bindings and driver are reviewed.

Cheers,

Joel
