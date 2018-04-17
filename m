Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2662433-1523995106-2-3707440234604958619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endask.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523995104; b=WqVjRUsfEjEQ8sqMkrar4avbgAYr9w7wAUa8Ez8XVSr1/Fw5mx
    YtvvdQDFEZVCbd+jCWDOhjmVx1d48JK1+Mp4bKnmrlHGJKIGjmDh+tvB1W/SsvDV
    h6KLihSDiJyl+Go47xtMIk+iajC0dHMETYR0SG2jqTCJ3dGY+uzk49GCpmAjlEMr
    P0C+JIiY15Hg3EhSJTIh01GnYwbK1KyMejiR284Zx4oF5iErbG9zH1/lZBt2mcd0
    F6A/dFoFDp12SSDUcaiT9ftTTv7BF2VRDrovtgNDK1LEPpM7vG5NfNZPc8qYMySI
    /epUhxnMI1cvzucYrp+9hrTJneTKW6vsmCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523995104; bh=HonZS
    4gzSvQWH5KnmIvknisMJ0Nk4NdWvlSEC1CdyrA=; b=fdOXakqpSRHQF+gs7yz+4
    JaXjXlV8zsjrsKlsabb+/N2yDZ4PSCch1VpC2Kz2hlUZW+r7tJJN9OhG7f8IkYEf
    twyK22glGj8TShuN5Mgf8yZt0yOnUaP0ddv7TOhaxPY4pT6jQJOAHgB9otLzwX7b
    i7HmFxyYdzTrqtXd5/9VAAAuSu/YKOHoLYTQUdJlZqe+T5UC3Mo6jrRNxkZBAwcZ
    cUS5jTEjrdHzowSDMq/je5CA5Z40m58dixInd0odRsMxKkkuKzxpdbodR/cNDOdh
    xvtWbWhzVfgHVi8Q9LgQ5uZsMD05q5bvVszWD5s1djDFC8CqMTS9t+NvkndeOjzV
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP8bmKvxvKHS1+ZbBGq6H4xdCsfQ96U41WyFmkIfezx621izGTESLS/PT5oDxjrA73Gx+yfT3t2LnU8+RaZtwezEEg6NitYnDjTQedPwaq2ZnALFCT38
    MN+JerpiIjFE5MrjGFlb8AvGKWCXQPRxznVOxDr+otvQbkqb8PWNINXI5krxFLemfvoRTfe1iiG0GLFtoFbE/1JN4H8J6tR6ZMQxQtMcGJEXNWXXv34zYAX0
    ZX7gwvqkrF8AlrSZDH320w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8
    a=mDV3o1hIAAAA:8 a=UEFuTGg-AAAA:8 a=ag1SF4gXAAAA:8 a=i3X5FwGiAAAA:8
    a=DDOyTI_5AAAA:8 a=rTH4mTLeCMmadjnfT6oA:9 a=CjuIK1q_8ugA:10
    a=_FVE-zBwftR9WsbkzFJk:22 a=mz-9cL3ZSiV3bxg4Spyn:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=mmqRlSCDY2ywfjPLJ4af:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000"; d="scan'208";a="47719601"
Date: Wed, 18 Apr 2018 03:56:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <201804180307.q5MrL5v1%fengguang.wu@intel.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180417050028.19372-1-k.marinushkin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, kbuild-all@01.org,
 Ray Jui <rjui@broadcom.com>, Kirill Marinushkin <k.marinushkin@gmail.com>,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kirill,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.17-rc1]
[cannot apply to anholt/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kirill-Marinushkin/staging-bcm2835-audio-Disconnect-and-free-vchi_instance-on-module_exit/20180417-193147
config: arm-allmodconfig
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        make.cross ARCH=arm  allmodconfig
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):


vim +/err +307 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c

325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  274  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  275  static int snd_add_child_device(struct device *device,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  276  				struct bcm2835_audio_driver *audio_driver,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  277  				u32 numchans)
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  278  {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  279  	struct snd_card *card;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  280  	struct device *child;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  281  	struct bcm2835_chip *chip;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  282  	int err, i;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  283  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  284  	child = snd_create_device(device, &audio_driver->driver,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  285  				  audio_driver->driver.name);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  286  	if (IS_ERR(child)) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  287  		dev_err(device,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  288  			"Unable to create child device %p, error %ld",
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  289  			audio_driver->driver.name,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  290  			PTR_ERR(child));
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  291  		return PTR_ERR(child);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  292  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  293  
626118b4 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Kirill Marinushkin 2018-03-23  294  	card = snd_bcm2835_card_new(child);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  295  	if (IS_ERR(card)) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  296  		dev_err(child, "Failed to create card");
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  297  		return PTR_ERR(card);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  298  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  299  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  300  	snd_card_set_dev(card, child);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  301  	strcpy(card->driver, audio_driver->driver.name);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  302  	strcpy(card->shortname, audio_driver->shortname);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  303  	strcpy(card->longname, audio_driver->longname);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  304  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  305  	err = snd_bcm2835_create(card, &chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  306  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14 @307  		dev_err(child, "Failed to create chip, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  308  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  309  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  310  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  311  	chip->dev = child;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  312  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  313  	err = audio_driver->newpcm(chip, audio_driver->shortname,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  314  		audio_driver->route,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  315  		numchans);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  316  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  317  		dev_err(child, "Failed to create pcm, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  318  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  319  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  320  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  321  	err = audio_driver->newctl(chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  322  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  323  		dev_err(child, "Failed to create controls, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  324  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  325  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  326  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  327  	for (i = 0; i < numchans; i++)
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  328  		chip->avail_substreams |= (1 << i);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  329  
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  330  	err = snd_card_register(card);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  331  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  332  		dev_err(child, "Failed to register card, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  333  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  334  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  335  
626118b4 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Kirill Marinushkin 2018-03-23  336  	dev_set_drvdata(child, chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  337  	dev_info(child, "card created with %d channels\n", numchans);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  338  
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  339  	return 0;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  340  }
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  341  

:::::: The code at line 307 was first introduced by commit
:::::: 325b5b6c96a863989078df402d1670d061f52d88 staging: bcm2835-audio: Add support for simultanous HDMI and Headphone audio

:::::: TO: Michael Zoran <mzoran@crowfest.net>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
