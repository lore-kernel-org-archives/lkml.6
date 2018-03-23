Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-212613-1521782221-2-1772279703170303760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521782219; b=cx4/DeuQpHF4A3Y1+yTSOAk9vZi0/cAQiwxUytQYs5WiBkq
    u4JNJ6rX2jp9wC3KWsuHXI9oQWotDV+bHD1kzEcnC2HhZQGPpvtXW73V+FPCavaF
    zqu1ZO4UzMRAbPVb4ex90FepkhbVFSKv0oJkJYS8TyGhvU4Ik4ZGA3r5/Yw1fwNv
    2dxa/resl9ydfwBwZp9N1+qrlS6yZZ8Ps7HMVFQA8NJQC2FciiFyDvwriqGoQpU4
    CJcRbDuIgbZaYezEHzwXjWf41x8b4adv/PFHEO1VeKbe95J58wpXDEBn4oZ9xIWM
    oa7q6HUJTYXJBICfo4/8S5PuOaV0xg4Si+g/kBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521782219; bh=C
    og1Mp8dYXrEb7vRE+YdauCwRUcGfPscgyjwuiALD3k=; b=rEYPkpE5BjJsEHMKV
    KVpLDidcueD2swxYzz+IJDKczu7EDvh5oCtjMTvyXUqDSIMb+bM5wMAqccDBIDJ2
    wCF3xbeiI2W5vHmgoGjkyuMoDQSC2hb4lhZ3aR0PSlhPcAuXMfKH17FgbppLxcLQ
    Mg6HIFh4fkabAzx1dhz2rQK2PPk/H+O2E5Iu+ue+NOMC6A6K8N5FtFIo0ItJfROh
    Uww4VxqltvWMvQgxROa3fxtLt0stq7+YOBlH8wf9oq0qU7dS4HWxPAx8r8L5pywe
    JWHyqGkidOzusI9sAfrvPNfqqkj48WOEmrxsl0+OZvY/nMd3GjCCE077Wpx/i//v
    Sg6rQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000"; d="scan'208";a="37426775"
Date: Fri, 23 Mar 2018 13:15:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [v2] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
Message-ID: <201803231354.kr3QnbaJ%fengguang.wu@intel.com>
References: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 Roy Pledge <roy.pledge@nxp.com>, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, kbuild-all@01.org, stuyoder@gmail.com,
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Roy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on next-20180322]
[cannot apply to linus/master v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roy-Pledge/staging-fsl-mc-Move-DPIO-from-staging-to-drivers-soc-fsl/20180323-102325
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/fsl/dpio/qbman-portal.c:163:22: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:2>*addr_cena @@    got ef] <asn:2>*addr_cena @@
   drivers/soc/fsl/dpio/qbman-portal.c:163:22:    expected void [noderef] <asn:2>*addr_cena
   drivers/soc/fsl/dpio/qbman-portal.c:163:22:    got void *const cena_bar
>> drivers/soc/fsl/dpio/qbman-portal.c:164:22: sparse: incorrect type in assignment (different address spaces) @@    expected void [noderef] <asn:2>*addr_cinh @@    got ef] <asn:2>*addr_cinh @@
   drivers/soc/fsl/dpio/qbman-portal.c:164:22:    expected void [noderef] <asn:2>*addr_cinh
   drivers/soc/fsl/dpio/qbman-portal.c:164:22:    got void *const cinh_bar
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/qbman-portal.c:92:29: sparse: incorrect type in return expression (different address spaces) @@    expected void * @@    got void [noderef] <avoid * @@
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    expected void *
   drivers/soc/fsl/dpio/qbman-portal.c:92:29:    got void [noderef] <asn:2>*
--
>> drivers/soc/fsl/dpio/dpio-driver.c:149:24: sparse: incorrect type in assignment (different address spaces) @@    expected void *[assigned] regs_cena @@    got void [void *[assigned] regs_cena @@
   drivers/soc/fsl/dpio/dpio-driver.c:149:24:    expected void *[assigned] regs_cena
   drivers/soc/fsl/dpio/dpio-driver.c:149:24:    got void [noderef] <asn:2>*
>> drivers/soc/fsl/dpio/dpio-driver.c:151:24: sparse: incorrect type in assignment (different address spaces) @@    expected void *[assigned] regs_cinh @@    got void [void *[assigned] regs_cinh @@
   drivers/soc/fsl/dpio/dpio-driver.c:151:24:    expected void *[assigned] regs_cinh
   drivers/soc/fsl/dpio/dpio-driver.c:151:24:    got void [noderef] <asn:2>*

vim +163 drivers/soc/fsl/dpio/qbman-portal.c

321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   89  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   90  static inline void *qbman_get_cmd(struct qbman_swp *p, u32 offset)
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   91  {
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  @92  	return p->addr_cena + offset;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   93  }
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   94  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   95  #define QBMAN_CINH_SWP_CFG   0xd00
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   96  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   97  #define SWP_CFG_DQRR_MF_SHIFT 20
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   98  #define SWP_CFG_EST_SHIFT     16
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13   99  #define SWP_CFG_WN_SHIFT      14
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  100  #define SWP_CFG_RPM_SHIFT     12
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  101  #define SWP_CFG_DCM_SHIFT     10
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  102  #define SWP_CFG_EPM_SHIFT     8
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  103  #define SWP_CFG_SD_SHIFT      5
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  104  #define SWP_CFG_SP_SHIFT      4
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  105  #define SWP_CFG_SE_SHIFT      3
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  106  #define SWP_CFG_DP_SHIFT      2
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  107  #define SWP_CFG_DE_SHIFT      1
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  108  #define SWP_CFG_EP_SHIFT      0
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  109  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  110  static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,	u8 est, u8 rpm, u8 dcm,
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  111  				    u8 epm, int sd, int sp, int se,
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  112  				    int dp, int de, int ep)
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  113  {
2584f385 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Bogdan Purcareata 2017-07-20  114  	return (max_fill << SWP_CFG_DQRR_MF_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  115  		est << SWP_CFG_EST_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  116  		wn << SWP_CFG_WN_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  117  		rpm << SWP_CFG_RPM_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  118  		dcm << SWP_CFG_DCM_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  119  		epm << SWP_CFG_EPM_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  120  		sd << SWP_CFG_SD_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  121  		sp << SWP_CFG_SP_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  122  		se << SWP_CFG_SE_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  123  		dp << SWP_CFG_DP_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  124  		de << SWP_CFG_DE_SHIFT |
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  125  		ep << SWP_CFG_EP_SHIFT);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  126  }
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  127  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  128  /**
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  129   * qbman_swp_init() - Create a functional object representing the given
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  130   *                    QBMan portal descriptor.
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  131   * @d: the given qbman swp descriptor
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  132   *
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  133   * Return qbman_swp portal for success, NULL if the object cannot
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  134   * be created.
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  135   */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  136  struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  137  {
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  138  	struct qbman_swp *p = kmalloc(sizeof(*p), GFP_KERNEL);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  139  	u32 reg;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  140  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  141  	if (!p)
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  142  		return NULL;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  143  	p->desc = d;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  144  	p->mc.valid_bit = QB_VALID_BIT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  145  	p->sdq = 0;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  146  	p->sdq |= qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  147  	p->sdq |= qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  148  	p->sdq |= QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  149  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  150  	atomic_set(&p->vdq.available, 1);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  151  	p->vdq.valid_bit = QB_VALID_BIT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  152  	p->dqrr.next_idx = 0;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  153  	p->dqrr.valid_bit = QB_VALID_BIT;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  154  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  155  	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_4100) {
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  156  		p->dqrr.dqrr_size = 4;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  157  		p->dqrr.reset_bug = 1;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  158  	} else {
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  159  		p->dqrr.dqrr_size = 8;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  160  		p->dqrr.reset_bug = 0;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  161  	}
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  162  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13 @163  	p->addr_cena = d->cena_bar;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13 @164  	p->addr_cinh = d->cinh_bar;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  165  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  166  	reg = qbman_set_swp_cfg(p->dqrr.dqrr_size,
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  167  				1, /* Writes Non-cacheable */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  168  				0, /* EQCR_CI stashing threshold */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  169  				3, /* RPM: Valid bit mode, RCR in array mode */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  170  				2, /* DCM: Discrete consumption ack mode */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  171  				3, /* EPM: Valid bit mode, EQCR in array mode */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  172  				0, /* mem stashing drop enable == FALSE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  173  				1, /* mem stashing priority == TRUE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  174  				0, /* mem stashing enable == FALSE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  175  				1, /* dequeue stashing priority == TRUE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  176  				0, /* dequeue stashing enable == FALSE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  177  				0); /* EQCR_CI stashing priority == FALSE */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  178  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  179  	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  180  	reg = qbman_read_register(p, QBMAN_CINH_SWP_CFG);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  181  	if (!reg) {
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  182  		pr_err("qbman: the portal is not enabled!\n");
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  183  		return NULL;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  184  	}
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  185  
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  186  	/*
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  187  	 * SDQCR needs to be initialized to 0 when no channels are
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  188  	 * being dequeued from or else the QMan HW will indicate an
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  189  	 * error.  The values that were calculated above will be
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  190  	 * applied when dequeues from a specific channel are enabled.
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  191  	 */
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  192  	qbman_write_register(p, QBMAN_CINH_SWP_SDQCR, 0);
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  193  	return p;
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  194  }
321eecb0 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c Roy Pledge        2017-03-13  195  

:::::: The code at line 163 was first introduced by commit
:::::: 321eecb06bfba0522f33582335f0b09e5003b1e3 bus: fsl-mc: dpio: add QBMan portal APIs for DPAA2

:::::: TO: Roy Pledge <Roy.Pledge@nxp.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
