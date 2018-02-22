Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AH8x224JVn/YNHpvSKzOw/HWdi44lJ2N7tefMkwzKwuQMHc4MhFO0mdzJu73iQnMDP0gKd4jVQCc
ARC-Seal: i=1; a=rsa-sha256; t=1519282929; cv=none;
        d=google.com; s=arc-20160816;
        b=oktwCXwm9mFFDuomIjJVMGLQAzCZVphDvvCCJTHSEVk4DPc/V/cThmcO5RMuCE948O
         4XPB3EBJKaHMjzyGYm58f7euEXZnPlLAB8JR8qHdG1n6Tt8nUJqCuMHSW7ATP/f6kLj5
         dyJMmLPa1L5BY+YzfrzEHMx/vBUfd84a0VyrbZ72s0qMXksJf7i2+UGYGBc2wtjQ7uy0
         oCejXM0HfnhK6v5YQPwpmH5DwBr58IF9gpWMv1ckZgcxZP+hkDjp61E/J/pXBJEfMX+F
         RZC9p5oetSwAFsPKt4aY5/3/sE/Hc/HsL2FwBLXDoezpPQrfaXIvUvMmQXHa2G0tzosP
         lFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6592NizEpbc+vwoLJmXh0U/wVqjGN6qQhw0cM9UZ3uo=;
        b=WNlSWJFrdyaJc+tDq9QT3hub+9xosvfYR8ZqbXvsMt8m7gY/jnIMm9UBUgaZ4A1N/f
         sxKcI2Lj3fPYeVm8N9e51+UHeUnHtfhdodgr6PTtim+oS03oNEf47sM2tCp/u08iGowO
         TnM3EhvAkso484DK4v0rKkRucQ0h+WXHd0DChbtDGyJqPqWn5zwtAk5gf+KNyRR+e1wJ
         UwjlQibwtOOYPRhaH99VaIsDMvsPyow8Cj/Psl/AY+EhIyfnVMsOw3DWeV3/mEH4nmFx
         0fpwxgFmlbqZn9VI3HleZYJ6FHv5zracN2OtJ4OVpg05bsJD+XBhdHYHgwr+n8B0I5nb
         9NGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="206045988"
Date: Thu, 22 Feb 2018 15:01:10 +0800
From: kbuild test robot <lkp@intel.com>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: kbuild-all@01.org, joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI
 bus driver core
Message-ID: <201802221429.9znwFmb7%fengguang.wu@intel.com>
References: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593083617193985409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc2 next-20180221]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/PECI-device-driver-introduction/20180222-054545
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/peci/peci-core.c:773:29: sparse: symbol 'peci_match_id' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
