Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31CC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9D213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBJS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:26:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbfBJS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:26:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1AIOa2P089586
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 13:26:07 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qjrq397dt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 13:26:07 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Sun, 10 Feb 2019 18:26:06 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Feb 2019 18:26:02 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1AIQ1x527459778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Feb 2019 18:26:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E0E6A047;
        Sun, 10 Feb 2019 18:26:01 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB2D6A058;
        Sun, 10 Feb 2019 18:25:59 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.228.140])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 10 Feb 2019 18:25:59 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
From:   James Bottomley <jejb@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 10 Feb 2019 10:25:58 -0800
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021018-0012-0000-0000-00001707E471
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010572; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01159141; UDB=6.00604871; IPR=6.00939678;
 MB=3.00025517; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-10 18:26:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021018-0013-0000-0000-00005627AB00
Message-Id: <1549823158.4142.12.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-10_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=625 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen
> as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify
> this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.
> 
> Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for
> trusted keys")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

This isn't really a bug, is it?

We have no formatting requirements for the MAINTAINERS file and the
section owner is free to align with tabs, spaces or nothing as they see
fit.  Most use a single tab, but a couple don't. The only real thing
that cares is get_maintainers.pl and it uses \s* as the parse regexp,
so it doesn't care either.

Now, we could possibly agree the file looks better with a single space
or a single tab between the tag and the value and thus we should be
doing this, but we'd need to agree on that and update the tag
description accordingly.

James

