Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C62190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403834AbeLUO36 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:29:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387489AbeLUO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:29:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBLETLfN102181
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:29:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ph1q6rw9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:29:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 21 Dec 2018 14:29:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Dec 2018 14:29:50 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBLETn8a56295464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Dec 2018 14:29:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A59411C05C;
        Fri, 21 Dec 2018 14:29:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6035111C052;
        Fri, 21 Dec 2018 14:29:49 +0000 (GMT)
Received: from [9.148.204.67] (unknown [9.148.204.67])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Dec 2018 14:29:48 +0000 (GMT)
Date:   Fri, 21 Dec 2018 16:29:45 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181220083423.40233348@lwn.net>
References: <1544130781-13443-1-git-send-email-rppt@linux.ibm.com> <20181220075912.GA12338@rapoport-lnx> <20181220083423.40233348@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 0/2] docs/mm-api: link kernel-doc comments from slab_common.c
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18122114-0016-0000-0000-00000239BF51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122114-0017-0000-0000-0000329220C5
Message-Id: <1E20B2F5-93F6-4763-9068-75630DF2541C@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 20, 2018 5:34:23 PM GMT+02:00, Jonathan Corbet <corbet@lwn.net> wrote:
>On Thu, 20 Dec 2018 09:59:13 +0200
>Mike Rapoport <rppt@linux.ibm.com> wrote:
>
>> ping?
>
>Sorry, been traveling,

No problem, I just wanted to make sure it didn't fall between the cracks.

> and I still don't really know what to do with
>patches that are more mm/ than Documentation/. 

Well, these seem to be quite documentation, although they touch mm files ;-)

> I've just applied these, though.

Thanks!

>Thanks,
>
>jon

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

