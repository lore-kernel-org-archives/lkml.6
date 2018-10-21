Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A79C67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 01:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853EF2174B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 01:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853EF2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeJUJXj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 05:23:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbeJUJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 05:23:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9L197nT147091
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 21:11:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n808e87rt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 21:11:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Sun, 21 Oct 2018 02:11:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 21 Oct 2018 02:11:08 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9L1B7nf5964204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 21 Oct 2018 01:11:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47FC11C054;
        Sun, 21 Oct 2018 01:11:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5351E11C04C;
        Sun, 21 Oct 2018 01:11:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 21 Oct 2018 01:11:07 +0000 (GMT)
Received: from [9.102.49.12] (unknown [9.102.49.12])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0C18CA0146;
        Sun, 21 Oct 2018 12:11:05 +1100 (AEDT)
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [ANNOUNCE] Call for Papers - linux.conf.au Kernel Miniconf,
 Christchurch NZ, 21-25 Jan 2019
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
Date:   Sun, 21 Oct 2018 12:10:53 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18102101-0016-0000-0000-0000021631C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102101-0017-0000-0000-0000326DE2C1
Message-Id: <4e8f907e-ce44-191e-8ded-29ba9ab1cd08@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810210010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux.conf.au Kernel Miniconf is happening once again, this time in 
Christchurch on 22 Jan 2019.

*** Submissions close on 2018-12-16, 23:59 AoE, with early submissions 
(before 2018-11-16, 23:59 AoE) given priority. ***

*** Submission details: http://lca-kernel.ozlabs.org/2019-cfp.html ***

The Kernel Miniconf is a 1 day stream alongside the main LCA conference 
to talk about kernel stuff.

We invite submissions on anything related to kernel and low-level 
systems programming. We welcome submissions from developers of all 
levels of experience in the kernel community, covering a broad range of 
topics.

Past Kernel Miniconfs have included technical talks on topics such as 
memory management, RCU, scheduling and filesystems, as well as talks on 
Linux kernel community topics such as licensing and Linux kernel 
development process.

We strongly encourage both first-time and seasoned speakers from all 
backgrounds, ages, genders, nationalities, ethnicities, religions and 
abilities. Like the main LCA conference itself, we respect and encourage 
diversity at our miniconf.

Speakers will need to purchase an LCA ticket to attend.

See http://lca-kernel.ozlabs.org/2019-cfp.html for full details and the 
submission form.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

