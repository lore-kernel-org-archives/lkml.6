Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3176405-1519789436-2-14623387186335928395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519789435; b=qLIdna1hpVk+ozUIy7xGtGg5dldgJb4QOWrJU3+gZcCj+il
    AdDEVE4DBc0vJVUJOkPUsSiSrSDQMbcXQ3TX6caeyh4HPaNWrFud87ZDo4T3ZwMm
    x2YkKDNCwsejJuR2HQhZi7qXR1P4He+d32sBshB2psMxPPQtvdl5BWZC9I7CNlAO
    4fY/GlxisBJs3mR9WIuHfiPqt4+JIR0xSwvQjb8Yt9exz40IAmk7gtmn29XdHCcH
    /aiL3g2CqZDjEzOv+OLH5zwFPELhFjgjkS9L9gBv7rnWAzGY37D70d0MkgC1F7xj
    houSnSKpFL3oIGVhGvzlyRwVqWGooDEzeKytvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519789435; bh=u
    fYXi4oRrUO2OM6YqTf4Fhb32cvcDPLXb4DX5NZqiC8=; b=Hv89vWEcK3v34VLrq
    sG0X8F1sownkTEwtHazDlM4hvlvB+M84/iojXfcKb+JWBfIuDcf54tXBzx/cdY7s
    I7zU4zLt/LrWBZ4Gegmho/tr/WJUjxr4K/fAGyFHS4UosJo//Uhsc6B0iBWIR44f
    YyZIncaObHcPz5WeDZ+OCdV1wLLTqNLaQih7GavfAZX4iiTDCEkB2imvWt1LYnIo
    i1LvrTX4S+Mlbr4IXCk13Xxpg9/AOSzdMmY8Tuv+yrdTv5T+uudgPkTkr8rEcvm7
    C4pOPHmSZA7zbVCfsWHUgidimrcverJegYwXsyJ4p+gGfJ8fQGkxl/NtXWUA+/7O
    fsCEw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,403,1515484800"; d="scan'208";a="204287486"
Date: Wed, 28 Feb 2018 11:43:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Message-ID: <201802281140.9iVUkdHa%fengguang.wu@intel.com>
References: <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, kbuild-all@01.org, bogdan.purcareata@nxp.com,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ioana,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.16-rc3 next-20180227]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ioana-Radulescu/staging-fsl-mc-dpio-fsl-dpaa2-eth-Enable-multi-arch-compile/20180228-062457
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h:290:16: sparse: cast from restricted __le64
>> drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h:290:16: sparse: cast to restricted __le64
>> drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h:290:16: sparse: cast from restricted __le64
>> drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h:290:16: sparse: cast to restricted __le64
>> drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h:421:30: sparse: cast truncates bits from constant value (ffff7fff becomes 7fff)
--
>> drivers/staging/fsl-dpaa2/ethernet/dpni.c:1624:22: sparse: cast to restricted __le16
   drivers/staging/fsl-dpaa2/ethernet/dpni.c:1625:22: sparse: cast to restricted __le16

vim +290 drivers/staging/fsl-dpaa2/ethernet/../../fsl-mc/include/dpaa2-fd.h

d3269bdc Roy Pledge 2017-03-13  281  
d3269bdc Roy Pledge 2017-03-13  282  /**
d3269bdc Roy Pledge 2017-03-13  283   * dpaa2_sg_get_addr() - Get the address from SG entry
d3269bdc Roy Pledge 2017-03-13  284   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  285   *
d3269bdc Roy Pledge 2017-03-13  286   * Return the address.
d3269bdc Roy Pledge 2017-03-13  287   */
d3269bdc Roy Pledge 2017-03-13  288  static inline dma_addr_t dpaa2_sg_get_addr(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  289  {
d3269bdc Roy Pledge 2017-03-13 @290  	return le64_to_cpu((dma_addr_t)sg->addr);
d3269bdc Roy Pledge 2017-03-13  291  }
d3269bdc Roy Pledge 2017-03-13  292  
d3269bdc Roy Pledge 2017-03-13  293  /**
d3269bdc Roy Pledge 2017-03-13  294   * dpaa2_sg_set_addr() - Set the address in SG entry
d3269bdc Roy Pledge 2017-03-13  295   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  296   * @addr: the address to be set
d3269bdc Roy Pledge 2017-03-13  297   */
d3269bdc Roy Pledge 2017-03-13  298  static inline void dpaa2_sg_set_addr(struct dpaa2_sg_entry *sg, dma_addr_t addr)
d3269bdc Roy Pledge 2017-03-13  299  {
d3269bdc Roy Pledge 2017-03-13  300  	sg->addr = cpu_to_le64(addr);
d3269bdc Roy Pledge 2017-03-13  301  }
d3269bdc Roy Pledge 2017-03-13  302  
d3269bdc Roy Pledge 2017-03-13  303  static inline bool dpaa2_sg_short_len(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  304  {
d3269bdc Roy Pledge 2017-03-13  305  	return !!((le16_to_cpu(sg->format_offset) >> SG_SHORT_LEN_FLAG_SHIFT)
d3269bdc Roy Pledge 2017-03-13  306  		& SG_SHORT_LEN_FLAG_MASK);
d3269bdc Roy Pledge 2017-03-13  307  }
d3269bdc Roy Pledge 2017-03-13  308  
d3269bdc Roy Pledge 2017-03-13  309  /**
d3269bdc Roy Pledge 2017-03-13  310   * dpaa2_sg_get_len() - Get the length in SG entry
d3269bdc Roy Pledge 2017-03-13  311   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  312   *
d3269bdc Roy Pledge 2017-03-13  313   * Return the length.
d3269bdc Roy Pledge 2017-03-13  314   */
d3269bdc Roy Pledge 2017-03-13  315  static inline u32 dpaa2_sg_get_len(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  316  {
d3269bdc Roy Pledge 2017-03-13  317  	if (dpaa2_sg_short_len(sg))
d3269bdc Roy Pledge 2017-03-13  318  		return le32_to_cpu(sg->len) & SG_SHORT_LEN_MASK;
d3269bdc Roy Pledge 2017-03-13  319  
d3269bdc Roy Pledge 2017-03-13  320  	return le32_to_cpu(sg->len);
d3269bdc Roy Pledge 2017-03-13  321  }
d3269bdc Roy Pledge 2017-03-13  322  
d3269bdc Roy Pledge 2017-03-13  323  /**
d3269bdc Roy Pledge 2017-03-13  324   * dpaa2_sg_set_len() - Set the length in SG entry
d3269bdc Roy Pledge 2017-03-13  325   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  326   * @len: the length to be set
d3269bdc Roy Pledge 2017-03-13  327   */
d3269bdc Roy Pledge 2017-03-13  328  static inline void dpaa2_sg_set_len(struct dpaa2_sg_entry *sg, u32 len)
d3269bdc Roy Pledge 2017-03-13  329  {
d3269bdc Roy Pledge 2017-03-13  330  	sg->len = cpu_to_le32(len);
d3269bdc Roy Pledge 2017-03-13  331  }
d3269bdc Roy Pledge 2017-03-13  332  
d3269bdc Roy Pledge 2017-03-13  333  /**
d3269bdc Roy Pledge 2017-03-13  334   * dpaa2_sg_get_offset() - Get the offset in SG entry
d3269bdc Roy Pledge 2017-03-13  335   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  336   *
d3269bdc Roy Pledge 2017-03-13  337   * Return the offset.
d3269bdc Roy Pledge 2017-03-13  338   */
d3269bdc Roy Pledge 2017-03-13  339  static inline u16 dpaa2_sg_get_offset(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  340  {
d3269bdc Roy Pledge 2017-03-13  341  	return le16_to_cpu(sg->format_offset) & SG_OFFSET_MASK;
d3269bdc Roy Pledge 2017-03-13  342  }
d3269bdc Roy Pledge 2017-03-13  343  
d3269bdc Roy Pledge 2017-03-13  344  /**
d3269bdc Roy Pledge 2017-03-13  345   * dpaa2_sg_set_offset() - Set the offset in SG entry
d3269bdc Roy Pledge 2017-03-13  346   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  347   * @offset: the offset to be set
d3269bdc Roy Pledge 2017-03-13  348   */
d3269bdc Roy Pledge 2017-03-13  349  static inline void dpaa2_sg_set_offset(struct dpaa2_sg_entry *sg,
d3269bdc Roy Pledge 2017-03-13  350  				       u16 offset)
d3269bdc Roy Pledge 2017-03-13  351  {
d3269bdc Roy Pledge 2017-03-13  352  	sg->format_offset &= cpu_to_le16(~SG_OFFSET_MASK);
d3269bdc Roy Pledge 2017-03-13  353  	sg->format_offset |= cpu_to_le16(offset);
d3269bdc Roy Pledge 2017-03-13  354  }
d3269bdc Roy Pledge 2017-03-13  355  
d3269bdc Roy Pledge 2017-03-13  356  /**
d3269bdc Roy Pledge 2017-03-13  357   * dpaa2_sg_get_format() - Get the SG format in SG entry
d3269bdc Roy Pledge 2017-03-13  358   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  359   *
d3269bdc Roy Pledge 2017-03-13  360   * Return the format.
d3269bdc Roy Pledge 2017-03-13  361   */
d3269bdc Roy Pledge 2017-03-13  362  static inline enum dpaa2_sg_format
d3269bdc Roy Pledge 2017-03-13  363  	dpaa2_sg_get_format(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  364  {
d3269bdc Roy Pledge 2017-03-13  365  	return (enum dpaa2_sg_format)((le16_to_cpu(sg->format_offset)
d3269bdc Roy Pledge 2017-03-13  366  				       >> SG_FORMAT_SHIFT) & SG_FORMAT_MASK);
d3269bdc Roy Pledge 2017-03-13  367  }
d3269bdc Roy Pledge 2017-03-13  368  
d3269bdc Roy Pledge 2017-03-13  369  /**
d3269bdc Roy Pledge 2017-03-13  370   * dpaa2_sg_set_format() - Set the SG format in SG entry
d3269bdc Roy Pledge 2017-03-13  371   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  372   * @format: the format to be set
d3269bdc Roy Pledge 2017-03-13  373   */
d3269bdc Roy Pledge 2017-03-13  374  static inline void dpaa2_sg_set_format(struct dpaa2_sg_entry *sg,
d3269bdc Roy Pledge 2017-03-13  375  				       enum dpaa2_sg_format format)
d3269bdc Roy Pledge 2017-03-13  376  {
d3269bdc Roy Pledge 2017-03-13  377  	sg->format_offset &= cpu_to_le16(~(SG_FORMAT_MASK << SG_FORMAT_SHIFT));
d3269bdc Roy Pledge 2017-03-13  378  	sg->format_offset |= cpu_to_le16(format << SG_FORMAT_SHIFT);
d3269bdc Roy Pledge 2017-03-13  379  }
d3269bdc Roy Pledge 2017-03-13  380  
d3269bdc Roy Pledge 2017-03-13  381  /**
d3269bdc Roy Pledge 2017-03-13  382   * dpaa2_sg_get_bpid() - Get the buffer pool id in SG entry
d3269bdc Roy Pledge 2017-03-13  383   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  384   *
d3269bdc Roy Pledge 2017-03-13  385   * Return the bpid.
d3269bdc Roy Pledge 2017-03-13  386   */
d3269bdc Roy Pledge 2017-03-13  387  static inline u16 dpaa2_sg_get_bpid(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  388  {
d3269bdc Roy Pledge 2017-03-13  389  	return le16_to_cpu(sg->bpid) & SG_BPID_MASK;
d3269bdc Roy Pledge 2017-03-13  390  }
d3269bdc Roy Pledge 2017-03-13  391  
d3269bdc Roy Pledge 2017-03-13  392  /**
d3269bdc Roy Pledge 2017-03-13  393   * dpaa2_sg_set_bpid() - Set the buffer pool id in SG entry
d3269bdc Roy Pledge 2017-03-13  394   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  395   * @bpid: the bpid to be set
d3269bdc Roy Pledge 2017-03-13  396   */
d3269bdc Roy Pledge 2017-03-13  397  static inline void dpaa2_sg_set_bpid(struct dpaa2_sg_entry *sg, u16 bpid)
d3269bdc Roy Pledge 2017-03-13  398  {
d3269bdc Roy Pledge 2017-03-13  399  	sg->bpid &= cpu_to_le16(~(SG_BPID_MASK));
d3269bdc Roy Pledge 2017-03-13  400  	sg->bpid |= cpu_to_le16(bpid);
d3269bdc Roy Pledge 2017-03-13  401  }
d3269bdc Roy Pledge 2017-03-13  402  
d3269bdc Roy Pledge 2017-03-13  403  /**
d3269bdc Roy Pledge 2017-03-13  404   * dpaa2_sg_is_final() - Check final bit in SG entry
d3269bdc Roy Pledge 2017-03-13  405   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  406   *
d3269bdc Roy Pledge 2017-03-13  407   * Return bool.
d3269bdc Roy Pledge 2017-03-13  408   */
d3269bdc Roy Pledge 2017-03-13  409  static inline bool dpaa2_sg_is_final(const struct dpaa2_sg_entry *sg)
d3269bdc Roy Pledge 2017-03-13  410  {
d3269bdc Roy Pledge 2017-03-13  411  	return !!(le16_to_cpu(sg->format_offset) >> SG_FINAL_FLAG_SHIFT);
d3269bdc Roy Pledge 2017-03-13  412  }
d3269bdc Roy Pledge 2017-03-13  413  
d3269bdc Roy Pledge 2017-03-13  414  /**
d3269bdc Roy Pledge 2017-03-13  415   * dpaa2_sg_set_final() - Set the final bit in SG entry
d3269bdc Roy Pledge 2017-03-13  416   * @sg: the given scatter-gathering object
d3269bdc Roy Pledge 2017-03-13  417   * @final: the final boolean to be set
d3269bdc Roy Pledge 2017-03-13  418   */
d3269bdc Roy Pledge 2017-03-13  419  static inline void dpaa2_sg_set_final(struct dpaa2_sg_entry *sg, bool final)
d3269bdc Roy Pledge 2017-03-13  420  {
d3269bdc Roy Pledge 2017-03-13 @421  	sg->format_offset &= cpu_to_le16(~(SG_FINAL_FLAG_MASK
d3269bdc Roy Pledge 2017-03-13  422  					 << SG_FINAL_FLAG_SHIFT));
d3269bdc Roy Pledge 2017-03-13  423  	sg->format_offset |= cpu_to_le16(final << SG_FINAL_FLAG_SHIFT);
d3269bdc Roy Pledge 2017-03-13  424  }
d3269bdc Roy Pledge 2017-03-13  425  

:::::: The code at line 290 was first introduced by commit
:::::: d3269bdc7ebcf8bce7969a68d7108ec5890d8173 bus: fsl-mc: dpio: add frame descriptor and scatter/gather APIs

:::::: TO: Roy Pledge <Roy.Pledge@nxp.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
