Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F307CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23BB2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeLOHGl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 02:06:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727757AbeLOHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 02:06:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBF74eOQ072703
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 02:06:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pcvrj0c87-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 02:06:38 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Sat, 15 Dec 2018 07:06:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 15 Dec 2018 07:06:34 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBF76Y8n3473682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Dec 2018 07:06:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4CD411C04C;
        Sat, 15 Dec 2018 07:06:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9245511C04A;
        Sat, 15 Dec 2018 07:06:33 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 15 Dec 2018 07:06:33 +0000 (GMT)
Received: from [9.102.52.54] (unknown [9.102.52.54])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2F36FA0118;
        Sat, 15 Dec 2018 18:06:31 +1100 (AEDT)
Subject: Re: [ANNOUNCE] Call for Papers - linux.conf.au Kernel Miniconf,
 Christchurch NZ, 21-25 Jan 2019
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
References: <4e8f907e-ce44-191e-8ded-29ba9ab1cd08@au1.ibm.com>
Date:   Sat, 15 Dec 2018 18:06:30 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
In-Reply-To: <4e8f907e-ce44-191e-8ded-29ba9ab1cd08@au1.ibm.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18121507-0028-0000-0000-0000032AD223
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121507-0029-0000-0000-000023E72325
Message-Id: <6fb351c7-cedd-7853-6640-3e673f831d21@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812150063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/18 12:10 pm, Andrew Donnellan wrote:
> The linux.conf.au Kernel Miniconf is happening once again, this time in 
> Christchurch on 22 Jan 2019.
> 
> *** Submissions close on 2018-12-16, 23:59 AoE, with early submissions 
> (before 2018-11-16, 23:59 AoE) given priority. ***

This deadline is in just under 53 hours, and will not be extended.

> 
> *** Submission details: http://lca-kernel.ozlabs.org/2019-cfp.html ***
> 
> The Kernel Miniconf is a 1 day stream alongside the main LCA conference 
> to talk about kernel stuff.
> 
> We invite submissions on anything related to kernel and low-level 
> systems programming. We welcome submissions from developers of all 
> levels of experience in the kernel community, covering a broad range of 
> topics.
> 
> Past Kernel Miniconfs have included technical talks on topics such as 
> memory management, RCU, scheduling and filesystems, as well as talks on 
> Linux kernel community topics such as licensing and Linux kernel 
> development process.
> 
> We strongly encourage both first-time and seasoned speakers from all 
> backgrounds, ages, genders, nationalities, ethnicities, religions and 
> abilities. Like the main LCA conference itself, we respect and encourage 
> diversity at our miniconf.
> 
> Speakers will need to purchase an LCA ticket to attend.
> 
> See http://lca-kernel.ozlabs.org/2019-cfp.html for full details and the 
> submission form.
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

