Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B04ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D952150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D952150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbeITELW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbeITELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:11:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JMTR03045407
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:31:17 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mkwj7uy59-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:31:17 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Wed, 19 Sep 2018 16:31:16 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 16:31:13 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JMVBFg33816828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 15:31:11 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9F4C7805E;
        Wed, 19 Sep 2018 16:31:11 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3481278063;
        Wed, 19 Sep 2018 16:31:08 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.133.102])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 19 Sep 2018 16:31:07 -0600 (MDT)
Subject: Re: [PATCH RFC] MAINTAINERS: Update from @linux.vnet.ibm.com to
 @linux.ibm.com
From:   James Bottomley <jejb@linux.ibm.com>
To:     paulmck@linux.ibm.com, linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, dougmill@linux.ibm.com, eajames@linux.ibm.com,
        haver@linux.ibm.com, fbarrat@linux.ibm.com, jallen@linux.ibm.com,
        manoj@linux.ibm.com, mrochs@linux.ibm.com, mikecyr@linux.ibm.com,
        zohar@linux.ibm.com, naveen.n.rao@linux.ibm.com,
        pfsmorigo@linux.ibm.com, pjk1939@linux.ibm.com,
        seroyer@linux.ibm.com, tlfalcon@linux.ibm.com,
        tyreld@linux.ibm.com, ukrishn@linux.ibm.com
Date:   Wed, 19 Sep 2018 15:31:04 -0700
In-Reply-To: <20180919222733.GA13679@linux.ibm.com>
References: <20180919222733.GA13679@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18091922-0012-0000-0000-000016B6C335
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009736; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01090773; UDB=6.00563535; IPR=6.00870794;
 MB=3.00023396; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-19 22:31:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091922-0013-0000-0000-00005476011E
Message-Id: <1537396264.14262.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-19 at 15:27 -0700, Paul E. McKenney wrote:
> IBM's patch-friendly email infrastructure is changing domains from
> @linux.vnet.ibm.com to @linux.ibm.com, which if nothing else might
> save a bit of typing.  This commit therefore updates us stragglers'
> email addresses in the MAINTAINERS file.  The old addresses are
> expected to continue to work for a few more months.
> 
> While in the neighborhood, remove some obsolete entries, which
> results
> in an orphaned subsystem: "JSM Neo PCI based serial card".
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Douglas Miller <dougmill@linux.ibm.com>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Frank Haverkamp <haver@linux.ibm.com>
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: James Bottomley <jejb@linux.ibm.com>

Acked-by: James Bottomley <jejb@linux.ibm.com>

James

