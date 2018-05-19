Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZqd63HMbsHbMw1gZ765MredpjbCd0aR0t8D+EzZ5zpMoBU1cO7zV1VgkEVDI4Bs8vb5MGpr
ARC-Seal: i=1; a=rsa-sha256; t=1526724487; cv=none;
        d=google.com; s=arc-20160816;
        b=nLyAl1mIfNM3ZQZ6jvbhpyBM66mthb9IqEAASIol9Vc+IaG+2V10ukGYZaop5sKfdY
         244zXFX+EqIKihaeKoWOjcittYF+NQJPMjlwEV8UYcTWVR42vuQvngzyM6A1pRNun5ag
         aVvuZqzLllECAsT8KqSNriW/j4fHeCrfmJ2ovZmapE4LPg2SmGD6Q9esT5z7kTg5uiVl
         VpzkoCh7d8bF/9KEmzmYWDROEX/mB1LzCkzA8/Uo2IC3WF31PgkxlXluZVV5vIZTBouS
         RSY/THBmhN29khMKkOkZ+Sj1mvCqCqRPuTLdzK1DnJnhKriSwLnsfPLQsnIVj2bPO8NB
         6/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=FjSQxVU8utwgBqzeUsrLEWjQpVrAkh17Ew1ObJ8R8wE=;
        b=stIe1HTGBRizaew17bWlcGlOpVOsVkEDfoUaojOek6PsvRbhKTkVnPF2QZevpwSUi7
         ANnTdlqJSwxXIZQdS49KuJBST+GXwSgH1h1WlbXs4KgA5wiC3W3nRZGjzKkgvXbXNfda
         mc+0yv4H8ke3zcFRDG7Xx2SExbi3PhtptxqWBJZt1npwS1+9VRY0FxakoPzdzk1IIkbu
         OEtSmN9899tUnlvhUVD6rNj6ZmMQQvxH1YCtUw9KWEcYPawrGoniZR1SdZIOV6I1W7Ss
         3X1J6ufBtGl2z8hX2RucU6vCNczwLkbm3sF35Uo4pi6BIbfHNEoCZ2gm28yEa9YSQWYd
         mjXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,417,1520924400";
   d="gz'50?scan'50,208,50";a="50528369"
Date: Sat, 19 May 2018 18:07:32 +0800
From: kbuild test robot <lkp@intel.com>
To: Erin Lo <erin.lo@mediatek.com>
Cc: kbuild-all@01.org, Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	srv_heupstream <srv_heupstream@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
	erin.lo@mediatek.com, mars.cheng@mediatek.com,
	Ben Ho <Ben.Ho@mediatek.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Message-ID: <201805191807.I6rPLEQg%fengguang.wu@intel.com>
References: <1526538126-51497-5-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <1526538126-51497-5-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600691269839697529?=
X-GMAIL-MSGID: =?utf-8?q?1600886656004345000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ben,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc5 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Erin-Lo/Add-basic-support-for-Mediatek-MT8183-SoC/20180519-160349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-alldefconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:137.9-10 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
POJ7AAA=

--4Ckj6UjgE2iN1+kY--
