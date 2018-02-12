Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2407764-1518473045-2-6014974535516942891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518473044; b=tvClF9J4kiPQ4IyIcXO279uyKi3HmUiBPeblGtrHzzEXt4K
    /8hbOYucNuDjVis8Ab8xymQwxSqps6dmz8TjKrnZ48pcaoFa1lmfv5AM9fdqfWx/
    v1t5puiQO6ZaTeyve5JYicJxBid8AhvGUqtGMt5qbyp02wpVtRGp1BGjQ+UeAEnN
    XGgxKACE9TREd9hIHPZvtYNc93yc2fPy599qRUj9Dcr2icrzVAFOYBHbX1UVGlrJ
    pE8FpybSOhS/6rJj1a+eW8F23QNkiHSU2zqnDW1y+b5wIMSJvGYO0SqbIxF4HSqS
    XhtG4UCp219C1P7LzsilfpdD4xkMlcGgXQbA0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518473044; bh=T
    gIQrQrOAku9WnwaNomiYq+u7p/uX7jqy4EWBrSsYA0=; b=qmOKxbPmauF+b0+GB
    kTGobBqm+Vkt4Fe5ezx6QH2pDAXmtQMPCD/gamhRJ0VnX/O5xCMKDppnqiOvYsNC
    oRGNS0rodKOHDBCwjp832EiJ3Hi2T3tLZZ2xoycwsjMleGifRIN90wpbKdV7JD7N
    S8H8rpKMWblCMXprju0sKFQ+Hw+rVfDv7bbomfabGkOB2SNWU994dhXQD01iI1OV
    qJtH1sv2vV69XiPqfgBgM3E4yS2th3e7mEZvxnXleuRZmMSBwaUi8YNohknqdZht
    9hNtnByq2POZbiiKjoEg+h5MOUmdk4tsugFKfFWoNhNDnoK0jAmFhoABGEsgT2wL
    m623w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::::::::::::::::::::::::::::::,
 RULES_HIT:41:355:379:541:988:989:1260:1277:1311:1313:1314:1345:1373:1437:1515:1516:1518:1534:1541:1568:1593:1594:1711:1714:1730:1747:1777:1792:1801:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3867:4605:5007:6642:6737:10004:10400:10848:11026:11473:11658:11914:12043:12048:12555:12760:12986:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:30054,
 0, RBL:none, CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none,
 DomainCache:0, MSF:not bulk, SPF:, MSBL:0, DNSBL:none, Custom_rules:0:0:0,
 LFtime:1, LUA_SUMMARY:none
X-HE-Tag: cork44_45718fe63c62
X-Filterd-Recvd-Size: 2918
Message-ID: <1518473028.22190.20.camel@perches.com>
Subject: usleep_range without a range
From: Joe Perches <joe@perches.com>
To: UlfHansson <ulf.hansson@linaro.org>, MichaelTurquette
 <mturquette@baylibre.com>, StephenBoyd <sboyd@kernel.org>,
 "RafaelJ.Wysocki" <rjw@rjwysocki.net>, VireshKumar
 <viresh.kumar@linaro.org>,  BenjaminHerrenschmidt
 <benh@kernel.crashing.org>, PaulMackerras <paulus@samba.org>,
 MichaelEllerman <mpe@ellerman.id.au>,  SakariAilus <sakari.ailus@iki.fi>,
 MauroCarvalhoChehab <mchehab@kernel.org>, SebastianReichel
 <sre@kernel.org>, GregKroah-Hartman <gregkh@linuxfoundation.org>,
 LiamGirdwood <lgirdwood@gmail.com>, MarkBrown <broonie@kernel.org>,
 JaroslavKysela <perex@perex.cz>, TakashiIwai <tiwai@suse.com>
Date: Mon, 12 Feb 2018 14:03:48 -0800
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

scheduling can generally be better when these values are
not identical.  Perhaps these ranges should be expanded.

$ git grep -P -n "usleep_range\s*\(\s*([\w\.\>\-]+)\s*,\s*\1\s*\)"
drivers/clk/ux500/clk-sysctrl.c:45:             usleep_range(clk->enable_delay_us, clk->enable_delay_us);
drivers/cpufreq/pmac64-cpufreq.c:140:           usleep_range(1000, 1000);
drivers/cpufreq/pmac64-cpufreq.c:239:   usleep_range(10000, 10000); /* should be faster , to fix */
drivers/cpufreq/pmac64-cpufreq.c:284:           usleep_range(500, 500);
drivers/media/i2c/smiapp/smiapp-core.c:1228:    usleep_range(1000, 1000);
drivers/media/i2c/smiapp/smiapp-core.c:1235:    usleep_range(1000, 1000);
drivers/media/i2c/smiapp/smiapp-core.c:1240:    usleep_range(sleep, sleep);
drivers/media/i2c/smiapp/smiapp-core.c:1387:    usleep_range(5000, 5000);
drivers/media/i2c/smiapp/smiapp-quirk.c:205:    usleep_range(2000, 2000);
drivers/media/i2c/smiapp/smiapp-regs.c:279:             usleep_range(2000, 2000);
drivers/power/supply/ab8500_fg.c:643:   usleep_range(100, 100);
drivers/staging/rtl8192u/r819xU_phy.c:180:      usleep_range(1000, 1000);
drivers/staging/rtl8192u/r819xU_phy.c:736:                      usleep_range(1000, 1000);
drivers/staging/rtl8192u/r819xU_phy.c:740:                      usleep_range(1000, 1000);
sound/soc/codecs/ab8500-codec.c:1065:                   usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
sound/soc/codecs/ab8500-codec.c:1068:                   usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
