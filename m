Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD09C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8384B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeLNTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:19:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730548AbeLNTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:19:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEJFTxP007835
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:19:51 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pcgp24m7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:19:51 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Dec 2018 19:19:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 19:19:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEJJjUF45744144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 19:19:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC88FAE045;
        Fri, 14 Dec 2018 19:19:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD84AE04D;
        Fri, 14 Dec 2018 19:19:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.89.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 19:19:44 +0000 (GMT)
Subject: Re: linux-next: Tree for Dec 14 (security/integrity/ima/)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>
Date:   Fri, 14 Dec 2018 14:19:34 -0500
In-Reply-To: <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org>
References: <20181214181826.5775b958@canb.auug.org.au>
         <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121419-4275-0000-0000-000002F0A4F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121419-4276-0000-0000-000037FDD67D
Message-Id: <1544815174.3681.16.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing Paul Gortmaker]

On Fri, 2018-12-14 at 08:25 -0800, Randy Dunlap wrote:
> On 12/13/18 11:18 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20181213:
> > 
> 
> on i386:
> 
>   CC      security/integrity/ima/ima_main.o
> ../security/integrity/ima/ima_main.c: In function 'ima_load_data':
> ../security/integrity/ima/ima_main.c:535:3: error: implicit declaration of function 'is_module_sig_enforced' [-Werror=implicit-function-declaration]
>    sig_enforce = is_module_sig_enforced();
>    ^
> 
> 
> Needs:

Commit 4f83d5ea643a ("security: integrity: make ima_main explicitly
non-modular") just removed module.h.

Mimi 


> 
> ---
>  security/integrity/ima/ima_main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20181214.orig/security/integrity/ima/ima_main.c
> +++ linux-next-20181214/security/integrity/ima/ima_main.c
> @@ -24,6 +24,7 @@
>  #include <linux/init.h>
>  #include <linux/file.h>
>  #include <linux/binfmts.h>
> +#include <linux/module.h>
>  #include <linux/mount.h>
>  #include <linux/mman.h>
>  #include <linux/slab.h>
> 
> 
> 

