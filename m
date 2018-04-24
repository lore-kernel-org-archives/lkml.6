Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AIpwx4900mfAntXCqymAeOw9zF3V3H7cTVXiTqGXxKhFEqSmyrtfgefKGDqHFmmrY+hlrNor1dqH
ARC-Seal: i=1; a=rsa-sha256; t=1524585726; cv=none;
        d=google.com; s=arc-20160816;
        b=nFXgzt8m2oRef+Sbjo15EVcfRmDUI17fJEL8Fh7/aV35Geu8TQiGTooEE1COPv/4C5
         kIWGmkgGCTBHSvsVWILL9EnQ0Z+cQc9YQDfl5aSwB42DzcYVeL+bWFdhP7bIj/7MhrU7
         zMpNh7mCPT0K41SJp7l8I552nsPCN1E9k0nat/Ns/3H8ZJEo3PrGMBkgF7hg6hrGgmHl
         m5Yr8RqrolrpwFbU8sHXzxuDpqTxiwKKzYIvbzpYKbQRl410hJeq3/BoeLrfpmwUcMyQ
         I9Gkd96ovIlH9scoLyL2Tkbu/UzUUiGVoGvWt4LNu0DZ+6walbQDVvTnErE4aWd6KO1u
         KO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=cR/hzBQgZ3nMFDnICK40KKtiab5e1q+K7ZfvMdf2+74=;
        b=WGHDrCZ6Xc0lmW2M9YAEVp8z8D/e2lhsk/U+rwjV21Qj0vMngSb66oFyvcER5j0+l8
         UQOx6M9C9Lt3CtrN/duaLlzpZ8xt1qUs6spTrx+OK2duNFaxODSI20EvsCsocRIrjlDI
         i0c19rdZ0UNl0xXYaRNS6ymqhoaeYaN7bE7Y6FeFtaG4RKbVlp4U3IOCvEMOaJPj6u/u
         ohaQK0Y5t0xnlACoAbEpe8PGQkPAq1nsXAsryK/MKCauAIt/NzoMClwMQXqZPmk2f6MN
         vbun2f6iKc3ildhYnN5aDYuJhIQ9lmJZPccXUWLtcM6WIbILdZGJtA4uljVy3KohDIp6
         7sjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="50430491"
Message-ID: <1524585717.21176.504.camel@linux.intel.com>
Subject: Re: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Alan Cox
 <alan@linux.intel.com>,  Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn
 <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>, Greg KH
 <gregkh@linuxfoundation.org>,  Guenter Roeck <linux@roeck-us.net>, Haiyue
 Wang <haiyue.wang@linux.intel.com>, James Feist
 <james.feist@linux.intel.com>, Jason M Biils
 <jason.m.bills@linux.intel.com>,  Jean Delvare <jdelvare@suse.com>, Joel
 Stanley <joel@jms.id.au>, Julia Cartwright <juliac@eso.teric.us>,  Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Milton Miller II
 <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Stef van Os
 <stef.van.os@prodrive-technologies.com>, Sumeet R Pawnikar
 <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Date: Tue, 24 Apr 2018 19:01:57 +0300
In-Reply-To: <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
	 <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135111000345?=
X-GMAIL-MSGID: =?utf-8?q?1598644002340803543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-10 at 11:32 -0700, Jae Hyun Yoo wrote:
> This commit adds driver implementation for PECI bus core into linux
> driver framework.
> 

All comments you got for patch 6 are applicable here.

And perhaps in the rest of the series.

The rule of thumb: when you get even single comment in a certain place,
re-check _entire_ series for the same / similar patterns!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
