Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E07C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30173217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbeLSTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:00:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:49877 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbeLSTAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:00:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 11:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="gz'50?scan'50,208,50";a="102987792"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2018 11:00:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gZh4a-0009HL-C8; Thu, 20 Dec 2018 03:00:00 +0800
Date:   Thu, 20 Dec 2018 02:59:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dou Liyang <douliyangs@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 4/4] htmldocs: include/linux/interrupt.h:268: warning:
 Function parameter or member 'is_managed' not described in
 'irq_affinity_desc'
Message-ID: <201812200229.mvgJ1NIX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   c410abbbacb9b378365ba17a30df08b4b9eec64f
commit: c410abbbacb9b378365ba17a30df08b4b9eec64f [4/4] genirq/affinity: Add is_managed to struct irq_affinity_desc
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>> include/linux/interrupt.h:268: warning: Function parameter or member 'is_managed' not described in 'irq_affinity_desc'
   include/linux/rcutree.h:1: warning: no structured comments found
   kernel/rcu/tree.c:684: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/srcu.h:175: warning: Function parameter or member 'p' not described in 'srcu_dereference_notrace'
   include/linux/srcu.h:175: warning: Function parameter or member 'sp' not described in 'srcu_dereference_notrace'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4439: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '
   include/net/cfg80211.h:2838: warning: cannot understand function prototype: 'struct cfg80211_ftm_responder_stats '

vim +268 include/linux/interrupt.h

bec04037 Dou Liyang 2018-12-04 @268  

:::::: The code at line 268 was first introduced by commit
:::::: bec04037e4e484f41ee4d9409e40616874169d20 genirq/core: Introduce struct irq_affinity_desc

:::::: TO: Dou Liyang <douliyangs@gmail.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHyNGlwAAy5jb25maWcAjFxZc+O2ln7Pr2AlVVPddas73tpxZsoPEAiKiEiCTYBa/MJS
ZLqjurbkkeSk+9/POSApbge+k0rSbRwAxHKW7yzwLz/94rG30/5lfdpu1s/PP7xv5a48rE/l
o/e0fS7/x/OVlyjjCV+az9A52u7evv+6vb679W4+X118vvh02HzxZuVhVz57fL972n57g+Hb
/e6nX36Cf3+BxpdXmOnw3963zebTb94Hv/xzu955v32+htGXH6u/QFeukkBOC84LqYsp5/c/
mib4oZiLTEuV3P92cX1xce4bsWR6Jp2bZfa1WKhs1s4wyWXkGxmLQiwNm0Si0CozLd2EmWB+
IZNAwf8KwzQOtuuf2gN59o7l6e21XeYkUzORFCopdJy2E8lEmkIk84Jl0yKSsTT311d4CvWC
VZxK+LoR2njbo7fbn3DiZnSkOIua7fz8czuuSyhYbhQx2O6x0CwyOLRuDNlcFDORJSIqpg+y
s9IuZQKUK5oUPcSMpiwfXCOUi3DTEvprOm+0u6DuHocdcFnv0ZcP749W75NviPP1RcDyyBSh
0iZhsbj/+cNuvys/dq5Jr/Rcppycm2dK6yIWscpWBTOG8ZDsl2sRyQnxfXuULOMhMABII3wL
eCJq2BR43ju+/Xn8cTyVLy2bTkUiMsmtSKSZmoiOVHVIOlQLmpIJLbI5M8h4sfI745EaqIwL
vxYfmUxbqk5ZpgV2ats4sPFMqxzGFAtmeOirzgi7tW4Xnxn2DhlFjZ57ziIJg0URMW0KvuIR
sW2rDebtKQ7Idj4xF4nR7xKLGPQF8//ItSH6xUoXeYprae7JbF/Kw5G6qvChSGGU8iXvSkSi
kCL9SJDsYskkJZTTEK/P7jTTBEelmRBxamCORHQ/2bTPVZQnhmUrcv66V5dWKfw0/9Wsj//2
TrBVb7179I6n9enorTeb/dvutN19a/dsJJ8VMKBgnCv4VsVC508gi9l7asn0UrQcLSPjuafH
pwxzrAqgdT8DP4JdgMOndLKuOneH68F4Oav+4hLaPNG10eEhSIvlngFjL1hiignKBHTIk5il
hYkmRRDlOux+ik8zlaea1jCh4LNUSZgJrt2ojOaYahFoROxcZJ9MRIy+9Uk0A004t9KX+cSO
wVarFC5NPghUD8jT8EfMEt7jsWE3DX8hZmPAm/AtUDx6YFRy6V/edvQNCLKJ4Bq5SK2yMhnj
YjAm5TqdwZIiZnBNLbW6/e76YlD1EnRxRp/hVJgYQEJR6w+600oH+t0eQcgSl2CnSsslIbsd
+YObntGXlDvkpL9/eiwDtR3krhXnRixJikiV6xzkNGFR4JNEu0EHzWpYB02HYEpJCpO0cWf+
XMLW6vugzxTmnLAsk45rn+HAVUyPnaTBu5eNzGQRRECJjdUCIdOdJcBsCdgQkOOestLiKzEe
RgnfF/6Q4+GbxdmMdRjh8uJmpDJrGJ+Wh6f94WW925Se+Lvcge5moMU5am+wXa0udUzuC+C/
igh7LuYxnIiiQdE8rsYXVr27OB1RMwP1mNHcriNG4SUd5ZPusnSkJs7xcOzZVDQYz90tAKMX
SUAVGUiuohmw3zFkmQ9wgOZigGSBjAZmraYt726L6w4qh5+7foY2Wc6tpvMFB/2YtUSVmzQ3
hVW74AyUz0/XV5/QZ/u5x22w2erH+5/Xh81fv36/u/11Y124o/Xwisfyqfr5PA4tly/SQudp
2nOgwMDxmVW5Y1oc5wNrF6N9yxK/mMgKQd3fvUdny/vLW7pDwxr/YZ5et950Z6yrWeF3XZ2G
EC4EACkz3AFbNSalCPyOr5ottIiLJQ+nzAcrG01VJk0YE9gQQOokQ5Tqo7EdzI+aAHERGuIl
RQP3AfCtTIS1nEQP4CsQqCKdAo+ZgVbQwuQpSmiFvQC8tx0SAeigIVmtAlNliKPDPJk5+qUM
hIfsVq1HTsCzqpwIsGtaTqLhknWuUwE35SBbfBTm8JU0BicXhIrsYQ+XRbYn4KfRNyxn6jPy
QI8fzrDnuPR71roMtmeVWE8aQTrBw3hYFVPtGp5bn6tDDsCmC5ZFK47+lOjwRTqtMGIECjHS
91cdPIXXqRleNUoZ3qfgAO8alyI97Dfl8bg/eKcfrxXifirXp7dDeawAeTXRA6B8ZHFaZ8U0
EMRtBoKZPBMFOr20gp6qyA+kph3aTBiABsCpJBUwDHjcmU/rXPy8WBpgDGS292BLfR8yk/QS
K9SrYgl6MYONFBYoO+x8uALGBrQAuHSaD0I1LVa4ubulCV/eIRhNW0KkxfGSsAPxrVX8bU+Q
E4CmsZT0RGfy+3T6GBvqDU2dOTY2+83Rfke38yzXimaIWASB5EIlNHUhEx7KlDsWUpOvaXMb
gzZ1zDsVYEOny8t3qEVEI9+YrzK5dJ73XDJ+XdDRLEt0nB0CP8coZhzQA6WgNjAORGGZHv2p
2oToUAbm/ku3S3TppiGgS0EDVc6mzuO+RgTu7jfwOEVbeHszbFbzfgsYbxnnsbUmAYtltLq/
7dKtIgYPL9ZZP1ShuNAoqFpEoBUphxRmBIVcaZpOwKhutpfXA1oNhcX+uDFcTVVCzAJiw/Js
TABMlOhYGEZ+Io951d6qnlSYyikiL9iPJbHFxFphjaAULORETAEJXdJEUKVjUg17RwRo6LEW
HkoqaQVmL5H3ZLqyTh1v4mW/2572hyoE1N5h60bgmYNmXjh2b7lTTBlfgefgULJGAdtOaCsn
72gPAufNxEQpA/bZFV6JJQdmA8lxb1+7lw3HKWmllCiM1A282YYbKspNLypWN97eUF7DPNZp
BEbuujekbUXs43DFqi5XdOigJf/HGS6pdVmEqIIAoOf9xXd+Uf0z2CcBY6EVeJZnq3QIwQOA
AxWVEXDShp/dZKssmmg8xrU7mkFGyGNRgxAwnJyL+4v+BaTGzQdWN4KzoTR671luA1IOfVzF
18G2qMX97U2H20xGM5Nd/zveJ06qwe9xEivEBQCB7qIFR2+JxkUPxeXFBcWnD8XVl4sekz4U
1/2ug1noae5hmm4+Zilc2RSmwYPN+wtteC1caQn+FeLlDNntsua2bnxTcWYB93vjwUWbJjD+
ajC8difnvqZDTTz2rWsGGoWOBQHHyWBVRL6hQkbdm67Yt+HUUJk0yqdn5L//pzx4oFvX38qX
cney2J/xVHr7V8zB9vB/7WHRcQhK+fRdGZy2F04JxjF3UHJecCj/963cbX54x836eaDqrXXP
+gGs80j5+FwOOw/zHpY+eTs2G/Q+pFx65Wnz+WPPpHDKTEKrjWBEgBiKqu18kjBA7B5f99vd
aTARmkyrCmiTolkxyansSh1RQIvZSxZohwfGkc1IkoocOUXgTxqSJsJ8+XJBg9mUc5bRbGB1
x0oHk/GRb3frww9PvLw9rxvO6gvD9TCBjCAVAysKlNGA1MRApnnaXECwPbz8sz6Unn/Y/l1F
Gds4sE8vN5BZvGCZlQ6XxpsqNY3EuetoY6b8dlh7T83XH+3XO0k5m7+exz1jKjOTw9E/sKFe
7xUMYExteyo36Ih/eixfy90jimgrmd1PqCoS2LFTTUuRxLIChN01/AGar4jYRFCKw85o3SiJ
sdU8sXoMkz4cwfLAFiKkx9oBI5Niohejy5Lgh2AcjYgjzYbhjaoVPX6KAMCBHlC1YjFFQKVt
gjypIp0iywDpy+QPYX8edIODGrIg7s/OGCo1GxBRNuFnI6e5yokkr4YTRvVTZ7epEBsoRlTj
VdqZ6ABgp9bc5MKqopMqkFssQmlsxJiIawFCXyUMpcnYpJMdMZgyE1NQ0olfBYnqq66VT6+f
Fl9d54tFK86B4aKYwIKrDOOAFsslsFdL1nY5w4wdIB2MBuVZAqAXTk52g9bDdAVxnRhKR/0N
bogvqhiYHUFNQny/yUhk9REheqDupZWt96k2OGvkfHzzFTMWmgWi8YCHU9USWV8+ouNBj3pc
VfrjoPkqd4RKZcqLqgKjKScitlJDvTpUTPbAg4rgVocB5GEgsrEFdbCyRx7VF/TJLgVWbUaa
EPRSdWE2cDe8VaJGwKEFEnQKRB1HJk4cQFnjPAgO3NkJZQApB9RgdaWIkLsiQtwtxSLzXki+
XUQvrzHoIJbgOpGqpj/qrs8JKl01isREnTl5hOHeCRwbmD2/Q1BYJCanNRq8HhHYQLW2ysyA
VjRNjVS26KQl3iENh1cn6eiTYUYqT3qJ+KZtlJMenW4Kt3J91WB72IRuwMWUq/mnP9fH8tH7
d5XjfD3sn7bPvVqU8yqwd9FY315xEGJv4EasAOP8/udv//pXv9AOCxWrPr2EaKeZ2IBNuGtM
knbDLTXHUfHgmhdNJtBtVLO8V0E3QQ1JwdGkyhalsIE8wU794qyabjmpor9HI8cuMjBhrsFd
Yn/0wM+oYCPANQKnfM1FjloTNmHrvdxdsgXVwTJik1UvJiLAP9Ak1KVtllvE93Lzdlr/+Vza
GljPhq9OPUQ6kUkQGxR4uhSgImueyZQKSVY8q/Ieo9eDsPm9SWPpyCDgloYOsV1zXL7sAbvH
rZs4wqDvxkOaQEvMktyaolaRn6MsFY3Yaj24P1thA9DVuI4JbqcDfW+6+rfSzyK2zF2P7o6s
8tlwMqDrzv26E2NcKjV2tA1s3nTPDfwX7gjRINYvjEIXr7vxmaYc5qZC1Crsqi7Qz+5vLn6/
7YQnCTtERXS72dVZz/3gYI8TG6B3xB5o//IhdQUjHiY57V896HHpxgAk21xm4yL0AvMis0Fu
uEhHzhBQ3EQkPIxZRumrs7ymRlQWuc974OI6XR8sxfnDVodaAfDLv7ebrmfZ+mnbTd3sqXHE
JK9qU0IRpa5wvJibOA0cKUcDWIChHXbUflTTn71YW8A9kt6zY/y8Xz9a17T1fxeg/5nvWBte
3cLW6lGaYVCt42eAY117tB3EPHNkf6sOWNJeTwOGIlZziq3PxQ9YdpAb5ShJRvI8jzCXP5Eg
ulKcTTnGfh7tffauappoR9Te0LytAhfPxVjucS7uAFGtq1nai6uaRjeVzGPh6bfX1/3h1DBZ
vD1uqPXCdcQrNIPk4kAsIqUx547BYckdB68BD9M64IpcoBBw3rF3PC+x/aClFL9f8+XtaJgp
v6+PntwdT4e3F1sOdvwLGPLROx3WuyNO5QGSKr1H2Ov2Ff/a7J49n8rD2gvSKeuEWPb/7JCX
vZf94xuY1w8YMNweSvjEFf/YDJW7E8A0QALef3mH8tm+SDn2z7btgkzhN5EbS9MA4InmuUqJ
1naicH88OYl8fXikPuPsv389V2boE+yga4I/cKXjj0OdhOs7T9feDg+pBx+V+9PiFs21rHmt
c1QNrwARDXuvkoBx8NUVBtKt3OrR1cvd69tpPGcbzEzSfMxnIRyUvWr5q/JwSD8OjUXu/z/h
s117SBocQJK1OXDkegPcRgmbMXQtM+g0VxEpkGYuGq6KRVazDiK/7bmk4P5Xxb2OCpPFezmc
ZO6S7JTf/XZ9+72Ypo4q10RzNxFWNK2SU+4Ms+HwX0p/3YiID92L1lGz+wGAk2MVWJqPmemK
kzx0ReNZAPmO9pgmhJpuT9MxY6cm9TbP+82/h0pF7CzwT8MVvsLBfAoADXxMhlkhe2xg1uMU
SzZPe5iv9E5/ld768XGL8GH9XM16/NxLIsiEm4wGX3hXg/c+Z9rCEcDH/HjB5o6ycEvFtCLt
RlR0dLciWirCRewovjEhOEqM3kfznocQbK0n3bK+9iI1VbY7AQBLdp8MkG1lX9+eT9unt90G
T79RVI/jFEIc+OBZ/n4Jzh7LHPVc0AUfaRWOlCPSY0RbNL4ODYIFLfm1c/RMxGnkqEzCyc3t
9e+OYiAg69iV0WGT5ZeLCwvz3KNXmrtqqoBsZMHi6+svSyzhYT59ApmY5uC9KVpxxMKXrPHj
x1mRw/r1r+3mSGkA31HTB+2Fj7U1fDQd46n3gb09bvdgZs8FkB/pJ6gs9r1o++cBM1iH/dsJ
EMrZ4gaH9Uvp/fn29AS2wx/bjoAWTQysRdZWRdynNt1yucoTquA/B6lQIWYkpTGRLcyRrBN3
Q/qolBobz45RyHvWPNfjtB22WYD22McZ2J7+9eOIj369aP0D7eZYaBKV2i8uuZBzcnNInTJ/
6tA1ZpU6hAkH5lEqnRY0X9AHH8cO6RSxxtdkjnQoeErCp79UJTykdTRWxEUJn/EmKqV5lneq
ii1pdEkZaAJQ6f2GmF/e3N5d3tWUVqYMPidkDu/FR4UzcgAqpzZmkzwgE/0Y4MLgJb3dfOlL
nbred+UO6GADIQRM7HWQCu4hGVv+eLs57I/7p5MX/ngtD5/m3re3EpA2oQvAuk5dz/wwPd0U
ARfEubT+TwjejDj3db31iSKWqOX7dcXhogk2jjGnxQ96/3bo2ZxzmGamM17Iu6svnSA7tIq5
IVonkX9u7QB0GU0UneKXKo5zp7rNypf9qUT/gxJs9M8NunxjxZq9vhy/kWPSWDe37FZ0C0nk
2DV854O2DzE9tQOsvn396B1fy8326Rx/Oasm9vK8/wbNes+HWmtyALdxs3+haMky/TU4lCUW
nZTe1/1BfqW6bT/HS6r969v6GWYeTt3ZHL4YHu1siTmE765BS3zasyzmPCcPLLVMPCyHab2+
pXFabBunpdnCcTvpIh6tHsMPG7iMsbfIQMCmoO9itiySrJuXkClm4lxa28JOm1XPVOTyfYJ4
zHYArnuvdVt8XIeEsANpiHlczFTC0KJcOXshdk+XrLi6S2L0E2gb0uuF87kBNHeUm8R8bISJ
ClhK82VsrOTZ7vGw3z52u4GXlSlHKanPHOVAQz+3ctMXGMHZbHffaEVMK8SqfNDQbz1spIdU
DtKhxnQk4wE31WFPEOOKHTpK1a8K08Ef6xSzdCQGdWGgqxxYoRyFvDavhz1cdgZmqEtOpUMA
fVu/4JDAilY4Hw8H7J3RX3Nl6CPEeGmgbwpHtLkiu6gBpsYcNAU2HeDAgFzxwnrz1wAP61Hq
oWLyY/n2uLcJs/bWWpkBU+P6vKXxUEZ+JujTtg+paetcvfNyUKs/3IeCqTTLDfABIxwwIYnG
x6LLzdthe/pBoa+ZWDmitYLnGUBMAHVCW1VpM+Lv9u0vvNl0UwuDz0otm9kqAJuqYVU5Rifi
M+hGc0evkIlekc3InXOl45xIIxl1DqzdLevk8YbU3i+5sRKnRodNeG4D2wAHmXA4gQBj2LhC
opgLukQicVADmTSvHCeS+D0eWAU6qGM8vxtV40SkrQ3DXz1if4lAGsl+7R4HWMg5eH0002b8
kn7ZgOPM5YUv6aQzkqXJC+e017Q9A8ot/dwLKE4CHacA58Z+yFW0zen3YFXo8PoK89DB8Hcj
tXDqAZ86kwKh8R66WeaqCc1BMSg/1f1nvjbRqq2nBS5iMjWho1a1KhcMBWZuOwwNrT5gXm7Q
3PRuGWyUA2f4/1fIley2DQPRe7/Cxx7aIkkDtJccaFt2BGuLZEe9CalruIGRNGgSoJ/fWShK
pGboUxeOKXFEzgzJ995STgwk0lPqWHBCL+DuxqSFj6eqIZWJzvsw4vX/ftifGPFC//vy9/H5
7URHnL+eDlD0T1AB8EdTUq5cEyvV8YS+qRZ3uzTZ3lw7rApkaCR+THq49sTBPpNUDKSa/emV
XmhvRcOkAMvXjSjVJZfNFjBPp9B41i14kxmgramLm8uLq2vfk1VnmrxTZR4QBENPMI1cIO0K
CDJ44JbPS0VmgskwbRG9cZVjf4InkA2PbDwH+DcNA2Mxs+V4IKslF8+IHNGVRSadfnhk2ekD
SQCqaxOz6dEKcqY1uJuANFtL2hXcFaPH+sssC1pZHn6+H48hYQzdR7TgRi3QfN62/hVgZE1Z
aJUgd1OXKEU1EW0LrMo5wpLVhG0HCVHK4imDn/ctkScwCnLXBJCRwOpe5XJQ8GMbhrBP38I2
RLq3GCHU/4lYRShtgzNoPFh9rjKSH5OG2zcLPQ3MeATssfhEtRD6uQ3u2S0oBGbWLPuzP72/
cNC5fXg+Bpv+1TbAG8tV6BSXrLgGG6FohWCNQG7RqL0T71JGs7aApQTLtwz2N1K74655jXiL
heCzEaOJ6fE8wVCGYRI5A59iF5skqYKFwwUbHou5hTv7+Pry+EyXYp9mT+9vh38H+Asydr4Q
Z6evHHDHRn2vKZe5Q9XxPuE+vm+jPrBQja0h4TQvnOGocRTFurQtG6GmTFsZZTPMtvRSehBi
o/54OQOXnukLvWOq1GV7+T3pqTAPSbhBDVzDOGJ116DtIneC2QMGiDJnUEwh9lK/2baxjmNl
bKRpNNZW6TmLJhbQe/ZB7BsvahhLsU2NsP9DbTkxM6GSHNEMVGeixdnvQkaqw0mu7s6G8tgs
tfqMXa0n5t4TIbVGObjAvZto09c+jl2haAH5fBMyCokHrnVdm+pWtunpMCJdyG8kCoFEB7HN
OaPLoYSHgj2kOTA3k9+BiS0hE8P+MO9x67YRf6HEsZX+ZS1dMPJla2Q45Dx1sP/wumV8RKxO
L6pWCtLXVAjKw9o3eSXD0Afc/Wa99K608N+xEmQ3h5SNaTvdovofI+yH8hlb4xUMnmaiSDAh
HMeSZ/xFIduvMrNuJOfjFRJUFPOyIXbuVtE/ZFhrRGGPrqK2Z0CVrXzkyawdXWjMZthsTuqP
muvzPC2VRZaWrClF96/dxY/vFyNt5KAtGclB+G071qW6kluJ0/N10kYPG7NdhwZFAs1Z8PPi
NkUApnUes6Fp/Irj8mZRmciickKUvRpU5LNASlBuXpxKSbfyg63bF7ZpAZs3fUvlLFB0yFtz
/wHZlYO+qFsAAA==

--5mCyUwZo2JvN/JJP--
