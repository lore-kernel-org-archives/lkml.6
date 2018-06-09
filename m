Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iwfqI6pwG1veWAAAmS7hNA
	; Sat, 09 Jun 2018 06:16:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7EA77608B8; Sat,  9 Jun 2018 06:16:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BE06A607E7;
	Sat,  9 Jun 2018 06:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE06A607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeFIGP7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:15:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752756AbeFIGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:15:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w596E7bV036870
        for <linux-kernel@vger.kernel.org>; Sat, 9 Jun 2018 02:15:58 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jg4j87b50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 02:15:58 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 9 Jun 2018 02:15:56 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 9 Jun 2018 02:15:54 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w596FrWo9044380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Jun 2018 06:15:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADAE3B2064;
        Sat,  9 Jun 2018 03:17:21 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D890B205F;
        Sat,  9 Jun 2018 03:17:21 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.216.44])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  9 Jun 2018 03:17:21 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A6CC16C998C; Fri,  8 Jun 2018 23:17:44 -0700 (PDT)
Date: Fri, 8 Jun 2018 23:17:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/dev 114/116] drivers/iommu/amd_iommu.c:3566:21: sparse:
 symbol 'stupid_workaround' was not declared. Should it be static?
Reply-To: paulmck@linux.vnet.ibm.com
References: <201806090402.ONNRpjQE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201806090402.ONNRpjQE%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060906-2213-0000-0000-000002B61269
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009156; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044319; UDB=6.00534726; IPR=6.00823355;
 MB=3.00021546; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-09 06:15:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060906-2214-0000-0000-00005A6AAF56
Message-Id: <20180609061743.GE3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806090048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 04:11:26AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
> head:   f20dfe840ba05efdc4071106cffa31cb67cf6bc8
> commit: 814ee31d1f906ad00daccb58944ab16fa279690c [114/116] fixup! EXP iommu: Placeholder for fix in mainline
> reproduce:
>         # apt-get install sparse
>         git checkout 814ee31d1f906ad00daccb58944ab16fa279690c
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/iommu/amd_iommu.c:3539:30: sparse: expression using sizeof(void)
>    drivers/iommu/amd_iommu.c:3542:36: sparse: expression using sizeof(void)
>    drivers/iommu/amd_iommu.c:3542:36: sparse: expression using sizeof(void)
> >> drivers/iommu/amd_iommu.c:3566:21: sparse: symbol 'stupid_workaround' was not declared. Should it be static?
> 
> Please review and possibly fold the followup patch.

This whole thing disappears when I rebase to v4.18-rc1.  ;-)

							Thanx, Paul
